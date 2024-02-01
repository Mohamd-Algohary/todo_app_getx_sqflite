import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/presentation/resources/strings_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/font_manager.dart';
import '../../domain/model/task.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../app/size_config.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile(this.task, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateTaskWidth(
              SizeConfig.orientation == Orientation.portrait
                  ? AppSize.s8
                  : AppSize.s4)),
      margin: EdgeInsets.only(bottom: getProportionateTaskHeight(AppSize.s12)),
      width: SizeConfig.orientation == Orientation.portrait
          ? SizeConfig.screenWidth
          : SizeConfig.screenWidth / AppSize.s2,
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s16),
            color: task.color == 0
                ? ColorManager.primary
                : task.color == 1
                    ? ColorManager.pink
                    : ColorManager.orange),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title!,
                        style: context.theme.textTheme.labelLarge),
                    const SizedBox(height: AppSize.s12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          color: ColorManager.gray200,
                          size: AppSize.s18,
                        ),
                        const SizedBox(width: AppSize.s8),
                        Text(
                          '${task.startTime} - ${task.endTime}',
                          style: context.theme.textTheme.labelSmall,
                        )
                      ],
                    ),
                    const SizedBox(height: AppSize.s12),
                    Text(
                      task.note!,
                      style: context.theme.textTheme.labelSmall!
                          .copyWith(fontSize: FontSize.s15),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppMargin.m10),
              height: AppSize.s60,
              width: AppSize.s0_5,
              color: ColorManager.gray200.withOpacity(AppSize.s0_7),
            ),
            RotatedBox(
              quarterTurns: AppConstants.quarterTurns,
              child: Text(
                task.isCompleted == 1 ? AppStrings.completed : AppStrings.toDo,
                style: context.theme.textTheme.labelLarge!
                    .copyWith(fontSize: FontSize.s10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
