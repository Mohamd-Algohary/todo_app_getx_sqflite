// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/presentation/common/button.dart';
import '/presentation/home_page/controller/controller.dart';
import '/presentation/resources/routes_manager.dart';
import '/presentation/resources/strings_manager.dart';

class AddTask extends GetWidget<HomeViewController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd('en_US').format(DateTime.now()).toString(),
              style: context.theme.textTheme.headlineMedium,
            ),
            Text(
              AppStrings.today,
              style: context.theme.textTheme.headlineLarge,
            )
          ],
        ),
        MyButton(
          lable: AppStrings.addTask,
          onPress: () async {
            await Get.toNamed(Routes.addTask);
            controller.getTasks();
          },
        ),
      ],
    );
  }
}
