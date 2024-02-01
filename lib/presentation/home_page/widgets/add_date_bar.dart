// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:get/get.dart';

import '/presentation/home_page/controller/controller.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/font_manager.dart';
import '/presentation/resources/values_manager.dart';

class AddDateBar extends GetWidget<HomeViewController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m10),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        width: AppSize.s80,
        height: AppSize.s110,
        selectionColor:
            Get.isDarkMode ? ColorManager.darkHeader : ColorManager.primary,
        selectedTextColor: ColorManager.white,
        monthTextStyle: context.theme.textTheme.bodyMedium!,
        dateTextStyle: context.theme.textTheme.bodyMedium!
            .copyWith(fontSize: FontSize.s25),
        dayTextStyle: context.theme.textTheme.bodyMedium!
            .copyWith(fontSize: FontSize.s14),
        onDateChange: (newDate) {
          controller.selectedDate.value = newDate;
        },
      ),
    );
  }
}
