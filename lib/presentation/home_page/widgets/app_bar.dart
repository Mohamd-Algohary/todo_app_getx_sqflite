import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/app/theme_manager.dart';
import '/presentation/home_page/controller/controller.dart';
import '/presentation/resources/assets_manager.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/strings_manager.dart';
import '/presentation/resources/values_manager.dart';

class HomeAppBar extends GetWidget<HomeViewController>
    implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Get.isDarkMode
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_round_outlined,
          size: AppSize.s25,
          color: Get.isDarkMode ? ColorManager.white : ColorManager.darkGrey,
        ),
        onPressed: () {
          ThemeManager().switchTheme();
        },
      ),
      elevation: AppSize.s0,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      actions: [
        IconButton(
          onPressed: () {
            if (controller.tasksList.isNotEmpty)
              Get.dialog(showAlertDialog(context));
            else {}
          },
          icon: const Icon(
            Icons.delete,
            size: AppSize.s25,
          ),
          color: Get.isDarkMode ? ColorManager.white : ColorManager.darkGrey,
          tooltip: AppStrings.deleteall,
        ),
        const CircleAvatar(
          radius: AppSize.s20,
          backgroundImage: AssetImage(ImageAssets.person),
        ),
        const SizedBox(width: AppSize.s18),
      ],
      centerTitle: true,
    );
  }

  AlertDialog showAlertDialog(context) {
    return AlertDialog(
      title: Text(
        AppStrings.deleteall,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        AppStrings.areYouSure,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      backgroundColor:
          Get.isDarkMode ? ColorManager.darkGrey : ColorManager.white,
      elevation: AppSize.s15,
      actions: [
        TextButton(
          onPressed: () async {
            controller.notificationServices.cancelAllNotification();
            await controller.deleteAllTask() != 0
                ? controller.getTasks()
                : {
                    Get.showSnackbar(const GetSnackBar(
                        title: AppStrings.error,
                        message: AppStrings.somethingWentWrong))
                  };
            Get.back();
          },
          child: Text(AppStrings.delete,
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            AppStrings.cancel,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
