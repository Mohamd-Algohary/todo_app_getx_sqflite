import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';

import 'app/app.dart';
import 'data/data_source/local_data_source.dart';
import 'app/notification_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait({
    LocalDataSource.initDB(),
    GetStorage.init(),
    NotificationManager().initializeNotification()
  });
  runApp(MyApp());
}
