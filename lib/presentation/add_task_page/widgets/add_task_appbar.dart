import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class AddTaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddTaskAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: AppSize.s25,
          color: Get.isDarkMode ? ColorManager.white : ColorManager.darkGrey,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      elevation: AppSize.s0,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      actions: const [
        CircleAvatar(
          radius: AppSize.s20,
          backgroundImage: AssetImage(ImageAssets.person),
        ),
        SizedBox(width: AppSize.s18),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
