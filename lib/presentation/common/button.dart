import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/presentation/resources/color_manager.dart';
import '/presentation/resources/values_manager.dart';

class MyButton extends StatelessWidget {
  final String lable;
  final Function() onPress;
  const MyButton({Key? key, required this.lable, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        width: AppSize.s100,
        height: AppSize.s35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s10),
          color:
              Get.isDarkMode ? ColorManager.darkHeader : ColorManager.primary,
        ),
        child: Text(
          lable,
          style: context.theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
