import 'package:flutter/material.dart';

import '../data_source/local_data_source.dart';
import '/domain/model/task.dart';
import '../../app/constants.dart';
import '../../domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  RepositoryImpl({Key? key});

  @override
  Future<int> insert(Task task) async {
    return await LocalDataSource.db!.insert(Constants.tableName, task.toJson());
  }

  @override
  Future<int> updateRaw(Task task) async {
    return await LocalDataSource.db!.rawUpdate(
        'UPDATE ${Constants.tableName} SET isCompleted = ? WHERE id = ?',
        [task.isCompleted, task.id]);
  }

  @override
  Future<int> delete(Task task) async {
    return await LocalDataSource.db!
        .delete(Constants.tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  @override
  Future<int> deleteAll() async {
    return await LocalDataSource.db!.delete(Constants.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> getTasks() async {
    return await LocalDataSource.db!.query(Constants.tableName);
  }
}
