import 'package:get/get.dart';

import '../../../app/notification_manager.dart';
import '../../../domain/model/task.dart';
import '../../../domain/usecase/usecase.dart';
import '../../../app/size_config.dart';

class HomeViewController extends GetxController
    with StateMixin<HomeViewController> {
  static HomeViewController get to => Get.find();

  final Usecase _usecase;
  late NotificationManager notificationServices;
  RxList<Task> tasksList = <Task>[].obs;
  Rxn<DateTime> selectedDate = Rxn<DateTime>();

  HomeViewController(
    this._usecase,
  );

  @override
  void onInit() {
    SizeConfig.init(Get.context!);
    getTasks();
    notificationServices = NotificationManager();
    notificationServices.requestForPermission();
    selectedDate.value = DateTime.now();
    super.onInit();
  }

  //! Get data from DB
  void getTasks() async {
    //change(state, status: RxStatus.loading());

    var tasks = await _usecase.excuteGetTasks();
    tasksList.assignAll(tasks.map((data) {
      return Task.fromJson(data);
    }).toList());

    change(state, status: RxStatus.success());
  }

  //! Delete data from DB
  Future<int> deleteTask({required Task task}) async {
    return await _usecase.excuteDelete(task);
  }

  //! Delete all DB
  Future<int> deleteAllTask() async {
    return await _usecase.excuteDeleteAll();
  }

  //! update data in DB
  Future<int> updateTask({required Task task}) async {
    return await _usecase.excuteUpdate(task);
  }
}
