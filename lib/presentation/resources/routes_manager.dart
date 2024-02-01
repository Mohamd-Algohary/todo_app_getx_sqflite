import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_page/binding/binding.dart';
import '../add_task_page/view/add_task_view.dart';
import '../home_page/view/home_view.dart';
import '../notification_page/view/notification_view.dart';
import 'strings_manager.dart';

class Routes {
  static const String home = '/';
  static const String addTask = '/addTask';
  static const String notification = '/notification';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return GetPageRoute(
            page: () => const HomeView(), binding: HomeBinding());
      case Routes.addTask:
        return GetPageRoute(page: () => const AddTaskView());
      case Routes.notification:
        return GetPageRoute(
            page: () =>
                NotificationView(payLoad: settings.arguments as String));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(child: Text(AppStrings.noRouteFoundBody)),
      ),
    );
  }
}
