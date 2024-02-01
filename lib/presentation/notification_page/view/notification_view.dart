import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/presentation/resources/color_manager.dart';
import '/presentation/resources/constants_manager.dart';
import '/presentation/resources/font_manager.dart';
import '/presentation/resources/strings_manager.dart';
import '/presentation/resources/values_manager.dart';

class NotificationView extends StatelessWidget {
  final String payLoad;
  const NotificationView({Key? key, required this.payLoad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: AppSize.s25,
            color: Get.isDarkMode ? ColorManager.white : ColorManager.darkGrey,
          ),
          onPressed: () => Get.back(),
        ),
        elevation: AppSize.s0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        title: Text(
          payLoad.split('|')[AppConstants.zero],
          style: TextStyle(
              color:
                  Get.isDarkMode ? ColorManager.white : ColorManager.darkGrey),
        ),
      ),
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: AppSize.s10),
          Column(
            children: [
              Text(
                AppStrings.hello,
                style: context.theme.textTheme.headlineLarge,
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              Text(
                AppStrings.newReminder,
                style: context.theme.textTheme.titleMedium!
                    .copyWith(fontSize: FontSize.s18),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p30, vertical: AppPadding.p10),
              margin: const EdgeInsets.symmetric(horizontal: AppMargin.m30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s30),
                color: ColorManager.primary,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.text_format,
                          size: AppSize.s30,
                          color: ColorManager.white,
                        ),
                        const SizedBox(width: AppSize.s10),
                        Text(
                          AppStrings.title,
                          style: context.theme.textTheme.labelMedium,
                        )
                      ],
                    ),
                    const SizedBox(height: AppSize.s15),
                    Text(
                      payLoad.split('|')[1],
                      style: context.theme.textTheme.titleMedium!
                          .copyWith(fontSize: FontSize.s20),
                    ),
                    const SizedBox(height: AppSize.s25),
                    Row(
                      children: [
                        const Icon(
                          Icons.description,
                          size: AppSize.s30,
                          color: ColorManager.white,
                        ),
                        const SizedBox(width: AppSize.s10),
                        Text(
                          AppStrings.description,
                          style: context.theme.textTheme.labelMedium,
                        )
                      ],
                    ),
                    const SizedBox(height: AppSize.s15),
                    Text(
                      payLoad.split('|')[2],
                      style: context.theme.textTheme.titleMedium!
                          .copyWith(fontSize: FontSize.s20),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: AppSize.s25),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: AppSize.s30,
                          color: ColorManager.white,
                        ),
                        const SizedBox(width: AppSize.s10),
                        Text(
                          AppStrings.date,
                          style: context.theme.textTheme.labelMedium,
                        )
                      ],
                    ),
                    const SizedBox(height: AppSize.s15),
                    Text(
                      payLoad.split('|')[3],
                      style: context.theme.textTheme.titleMedium!
                          .copyWith(fontSize: FontSize.s20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSize.s20),
        ],
      )),
    );
  }
}
