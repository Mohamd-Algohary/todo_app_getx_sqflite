import 'package:flutter/material.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app/notification_manager.dart';
import '../../../app/size_config.dart';
import '../../common/task_tile.dart';
import '../../resources/constants_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../controller/controller.dart';
import '../widgets/add_date_bar.dart';
import '../widgets/add_task.dart';
import '../widgets/app_bar.dart';
import '../widgets/no_tasks_view.dart';
import '../widgets/show_task_bottom_sheet.dart';

class HomeView extends GetWidget<HomeViewController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: controller.obx(
        (state) => Scaffold(
          appBar: const HomeAppBar(),
          backgroundColor: context.theme.scaffoldBackgroundColor,
          body: Container(
            margin: const EdgeInsets.only(
                left: AppMargin.m20,
                right: AppMargin.m10,
                top: AppMargin.m10,
                bottom: AppMargin.m15),
            width: SizeConfig.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AddTask(),
                AddDateBar(),
                showTasks(context),
              ],
            ),
          ),
        ),
        onLoading: const CircularProgressIndicator.adaptive(),
      ),
    );
  }

  Widget showTasks(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          var isNoTasks = true;
          if (controller.tasksList.isEmpty) {
            return noTasks(context, controller);
          } else {
            print(controller.selectedDate.value!);
            return RefreshIndicator(
              onRefresh: () async {
                controller.getTasks();
              },
              child: ListView.builder(
                scrollDirection: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                itemCount: controller.tasksList.length,
                itemBuilder: (ctx, index) {
                  var task = controller.tasksList[index];
                  var split = task.date!.split('-');
                  var date =
                      DateTime.parse('${split[2]}-${split[1]}-${split[0]}');

                  if (task.date ==
                          DateFormat('dd-MM-yyyy')
                              .format(controller.selectedDate.value!) ||
                      task.repeat == AppStrings.daily ||
                      (task.repeat == AppStrings.monthly &&
                          date.day == controller.selectedDate.value!.day) ||
                      (task.repeat == AppStrings.weekly &&
                          controller.selectedDate.value!
                                      .difference(date)
                                      .inDays %
                                  AppConstants.weekdays ==
                              0)) {
                    isNoTasks = false;
                    var hour = task.startTime!.split(':')[0];
                    var minutes = task.startTime!.split(':')[1].split(' ')[0];
                    var isPM = task.startTime!.split(':')[1].split(' ')[1];

                    NotificationManager().scheduledNotification(
                        hour: isPM == 'PM'
                            ? int.parse(hour) + AppConstants.halfDayHours
                            : int.parse(hour),
                        minutes: int.parse(minutes),
                        task: task);
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration:
                          const Duration(seconds: AppConstants.animationDelay),
                      child: SlideAnimation(
                        horizontalOffset: AppSize.s300,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () =>
                                showTaskBottomSheet(ctx, task, controller),
                            child: TaskTile(
                              task,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (isNoTasks &&
                      index == controller.tasksList.length - 1) {
                    return noTasks(context, controller);
                  } else {
                    return const SizedBox(height: AppSize.s0);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
