import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/presentation/resources/color_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../app/size_config.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      margin: const EdgeInsets.only(left: AppMargin.m15, top: AppMargin.m15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.theme.textTheme.titleLarge,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
            margin: const EdgeInsets.only(top: AppMargin.m5),
            width: SizeConfig.screenWidth,
            height: AppSize.s50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s10),
                border: Border.all(
                  color: Colors.grey,
                )),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    autofocus: false,
                    style: context.theme.textTheme.titleMedium,
                    cursorColor: Get.isDarkMode
                        ? ColorManager.gray100
                        : ColorManager.gray700,
                    readOnly: widget != null ? true : false,
                    decoration: InputDecoration(
                      hintText: hint,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                widget ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
