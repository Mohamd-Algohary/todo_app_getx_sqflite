import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/controller.dart';
import '../widgets/add_task_appbar.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/strings_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../resources/constants_manager.dart';
import '/presentation/common/button.dart';
import '/presentation/common/input_field.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final AddTaskViewController _controller =
      Get.put(AddTaskViewController(Get.find()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AddTaskAppBar(),
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p15, vertical: AppPadding.p15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.addt,
                style: context.theme.textTheme.headlineLarge,
              ),
              InputField(
                title: AppStrings.title,
                hint: AppStrings.enterTitle,
                controller: _controller.titleController,
              ),
              InputField(
                title: AppStrings.note,
                hint: AppStrings.enterNote,
                controller: _controller.noteController,
              ),
              Obx(
                () => InputField(
                  title: AppStrings.date,
                  hint: DateFormat('dd-MM-yyyy')
                      .format(_controller.selectedDate.value),
                  widget: IconButton(
                      onPressed: () {
                        _controller.getDateFromUser(context);
                      },
                      icon: const Icon(
                        Icons.calendar_today_outlined,
                        color: ColorManager.grey,
                      )),
                ),
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InputField(
                        title: AppStrings.startDate,
                        hint: _controller.startTime.value,
                        widget: IconButton(
                            onPressed: () {
                              _controller.getTimeFromUser(context, true);
                            },
                            icon: const Icon(
                              Icons.access_time_outlined,
                              color: ColorManager.grey,
                            )),
                      ),
                    ),
                    Expanded(
                      child: InputField(
                        title: AppStrings.endDate,
                        hint: _controller.endTime.value,
                        widget: IconButton(
                            onPressed: () {
                              _controller.getTimeFromUser(context, false);
                            },
                            icon: const Icon(
                              Icons.access_time_outlined,
                              color: ColorManager.grey,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              InputField(
                title: AppStrings.remind,
                hint:
                    '${_controller.selectedRemind} ${AppStrings.minutesEarly}',
                widget: Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p10),
                  child: DropdownButton<int>(
                    items: _controller.remindList
                        .map((value) => DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            ))
                        .toList(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: ColorManager.grey,
                    ),
                    underline: const SizedBox(),
                    dropdownColor: Get.isDarkMode
                        ? ColorManager.darkGrey
                        : ColorManager.white,
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    style: context.theme.textTheme.titleMedium,
                    onChanged: ((newValue) {
                      setState(() {
                        _controller.selectedRemind =
                            newValue ?? AppConstants.zero;
                      });
                    }),
                  ),
                ),
              ),
              InputField(
                title: AppStrings.repeat,
                hint: _controller.selectedRepeat,
                widget: Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p10),
                  child: DropdownButton<String>(
                    items: _controller.repeatList
                        .map((value) => DropdownMenuItem<String>(
                            value: value, child: Text(value)))
                        .toList(),
                    style: context.theme.textTheme.titleMedium,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    underline: const SizedBox(),
                    dropdownColor: Get.isDarkMode
                        ? ColorManager.darkGrey
                        : ColorManager.white,
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    onChanged: ((newValue) {
                      setState(() {
                        _controller.selectedRepeat = newValue ?? '';
                      });
                    }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p15, top: AppPadding.p15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.color,
                          style: context.theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppSize.s8),
                        Wrap(
                          spacing: AppSize.s5,
                          children: List<Widget>.generate(
                            AppConstants.listLength,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _controller.selectedColor = index;
                                });
                              },
                              child: CircleAvatar(
                                  radius: AppSize.s15,
                                  backgroundColor: index == AppConstants.zero
                                      ? ColorManager.primary
                                      : index == 1
                                          ? ColorManager.pink
                                          : ColorManager.orange,
                                  child: _controller.selectedColor == index
                                      ? const Icon(
                                          Icons.done,
                                          color: ColorManager.white,
                                          size: AppSize.s15,
                                        )
                                      : null),
                            ),
                          ),
                        ),
                      ],
                    ),
                    MyButton(
                        lable: AppStrings.addt,
                        onPress: () {
                          _controller.creatTask();
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
