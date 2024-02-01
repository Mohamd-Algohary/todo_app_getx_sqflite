// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '/app/size_config.dart';
import '/presentation/resources/assets_manager.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/strings_manager.dart';
import '/presentation/resources/values_manager.dart';

Center noTasks(context, controller) {
  return Center(
    child: Wrap(
      direction: SizeConfig.orientation == Orientation.portrait
          ? Axis.vertical
          : Axis.horizontal,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizeConfig.orientation == Orientation.portrait
            ? const SizedBox(height: AppSize.s60)
            : const SizedBox(height: AppSize.s20),
        SvgPicture.asset(
          ImageAssets.task,
          semanticsLabel: AppStrings.task,
          height: AppSize.s100,
          color: ColorManager.primary.withOpacity(AppSize.s0_6),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20, vertical: AppPadding.p14),
          child: Text(
            AppStrings.noTasksYet,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        )
      ],
    ),
  );
}
