import 'package:get/get.dart';

import '/data/repo_impl/repository_impl.dart';
import '/domain/repository/repository.dart';
import '/domain/usecase/usecase.dart';
import '/domain/usecase/usecase_impl.dart';
import '/presentation/home_page/controller/controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Repository>(() => RepositoryImpl());
    Get.lazyPut<Usecase>(() => UsecaseImpl(Get.find<Repository>()));
    Get.lazyPut<HomeViewController>(
        () => HomeViewController(Get.find<Usecase>()));
  }
}
