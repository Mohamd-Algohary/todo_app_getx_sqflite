// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../domain/usecase/usecase.dart';
import '../../home_page/controller/controller.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '/presentation/resources/constants_manager.dart';
import '/presentation/resources/strings_manager.dart';
import '../../../domain/model/task.dart';

class AddTaskViewController extends GetxController {
  final Usecase _usecase;
  late Task task;
  TextEditingController? titleController;
  TextEditingController? noteController;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString startTime =
      DateFormat('hh:mm a').format(DateTime.now()).toString().obs;
  RxString endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: AppConstants.min15)))
      .toString()
      .obs;

  int selectedColor = AppConstants.zero;
  int selectedRemind = AppConstants.min5;
  List<int> remindList = [];
  String selectedRepeat = AppStrings.none;
  List<String> repeatList = [];

  AddTaskViewController(this._usecase);

  @override
  void onInit() {
    titleController = TextEditingController();
    noteController = TextEditingController();
    task = Task();
    repeatList = [
      AppStrings.none,
      AppStrings.daily,
      AppStrings.weekly,
      AppStrings.monthly
    ];
    remindList = [
      AppConstants.min5,
      AppConstants.min10,
      AppConstants.min15,
      AppConstants.min20
    ];
    super.onInit();
  }

  //! Add data to DB
  Future<int> addTask({required Task task}) async {
    return await _usecase.excuteInsert(task);
  }

  void creatTask() async {
    if (titleController!.text.isEmpty || noteController!.text.isEmpty) {
      Get.snackbar(
        AppStrings.requiredField,
        AppStrings.pleaseEnterValue,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorManager.grey.withOpacity(AppSize.s0_7),
        colorText: Get.isDarkMode ? ColorManager.white : ColorManager.darkGrey,
      );
    } else {
      task.title = titleController!.text;
      task.note = noteController!.text;
      task.isCompleted = AppConstants.zero;
      task.date = DateFormat('dd-MM-yyyy').format(selectedDate.value);
      task.startTime = startTime.toString();
      task.endTime = endTime.toString();
      task.color = selectedColor;
      task.remind = selectedRemind;
      task.repeat = selectedRepeat;
      await addTask(task: task) != 0
          ? HomeViewController.to.getTasks()
          : {
              Get.showSnackbar(const GetSnackBar(
                  title: AppStrings.error,
                  message: AppStrings.somethingWentWrong))
            };

      Get.back();
    }
  }

  void getTimeFromUser(BuildContext context, bool isStartTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.now()
          : TimeOfDay.fromDateTime(
              DateTime.now().add(
                const Duration(minutes: AppConstants.min15),
              ),
            ),
    );
    if (pickedTime == null)
      return;
    else {
      isStartTime
          ? startTime.value = pickedTime.format(context)
          : endTime.value = pickedTime.format(context);
    }
  }

  void getDateFromUser(BuildContext context) async {
    var pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate.value,
            firstDate: DateTime(AppConstants.firstDate),
            lastDate: DateTime(AppConstants.lastDate)) ??
        DateTime.now();

    selectedDate.value = pickedDate;
  }
}
