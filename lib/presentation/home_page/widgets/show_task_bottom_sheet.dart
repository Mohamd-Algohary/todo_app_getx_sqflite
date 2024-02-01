import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../app/size_config.dart';
import '../../../domain/model/task.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

void showTaskBottomSheet(BuildContext context, Task task, controller) {
  Get.bottomSheet(
    SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: AppPadding.p4),
        width: SizeConfig.screenWidth,
        height: SizeConfig.orientation == Orientation.landscape
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * AppSize.s0_6
                : SizeConfig.screenHeight * AppSize.s0_85)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * AppSize.s0_35
                : SizeConfig.screenHeight * AppSize.s0_45),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSize.s10),
            topRight: Radius.circular(AppSize.s10),
          ),
          color: Get.isDarkMode ? ColorManager.darkHeader : ColorManager.white,
        ),
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: AppSize.s6,
                width: AppSize.s120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s10),
                    color: Get.isDarkMode
                        ? ColorManager.gray600
                        : ColorManager.gray300),
              ),
            ),
            const SizedBox(height: AppSize.s22),
            task.isCompleted == 1
                ? const SizedBox()
                : buildBottomSheet(
                    lable: AppStrings.taskCompleted,
                    onTap: () async {
                      controller.notificationServices.cancelNotification(task);
                      task.isCompleted = 1;
                      await controller.updateTask(task: task) != 0
                          ? controller.getTasks()
                          : {
                              Get.showSnackbar(const GetSnackBar(
                                  title: AppStrings.error,
                                  message: AppStrings.somethingWentWrong))
                            };
                      Get.back();
                    },
                    clr: ColorManager.primary),
            buildBottomSheet(
                lable: AppStrings.deleteTask,
                onTap: () async {
                  controller.notificationServices.cancelNotification(task);
                  await controller.deleteTask(task: task) != 0
                      ? controller.getTasks()
                      : {
                          Get.showSnackbar(const GetSnackBar(
                              title: AppStrings.error,
                              message: AppStrings.somethingWentWrong))
                        };
                  Get.back();
                },
                clr: ColorManager.red500),
            Divider(
              color:
                  Get.isDarkMode ? ColorManager.grey : ColorManager.darkHeader,
            ),
            buildBottomSheet(
                lable: AppStrings.cancel,
                onTap: () {
                  Get.back();
                },
                clr: ColorManager.primary),
            const SizedBox(height: AppSize.s22),
          ],
        ),
      ),
    ),
  );
}

Widget buildBottomSheet(
    {required String lable,
    required Function() onTap,
    required Color clr,
    bool isColse = false}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m4),
      height: AppSize.s65,
      width: SizeConfig.screenWidth * AppSize.s0_95,
      decoration: BoxDecoration(
        border: Border.all(
          width: AppSize.s2,
          color: isColse
              ? Get.isDarkMode
                  ? ColorManager.gray600
                  : ColorManager.gray300
              : clr,
        ),
        borderRadius: BorderRadius.circular(AppSize.s22),
        color: isColse ? ColorManager.transparent : clr,
      ),
      child: Text(
        lable,
        style: isColse
            ? Get.context!.theme.textTheme.titleLarge
            : Get.context!.theme.textTheme.titleLarge!
                .copyWith(color: ColorManager.white),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
