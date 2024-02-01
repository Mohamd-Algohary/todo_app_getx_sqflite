import '/domain/repository/repository.dart';
import 'usecase.dart';

import '../model/task.dart';

class UsecaseImpl extends Usecase<Task, int> {
  final Repository _repository;
  UsecaseImpl(
    this._repository,
  );

  @override
  Future<int> excuteInsert(Task input) async {
    return await _repository.insert(input);
  }

  @override
  Future<int> excuteUpdate(Task input) async {
    return await _repository.updateRaw(input);
  }

  @override
  Future<int> excuteDelete(Task input) async {
    return await _repository.delete(input);
  }

  @override
  Future<int> excuteDeleteAll() async {
    return await _repository.deleteAll();
  }

  @override
  Future<List<Map<String, dynamic>>> excuteGetTasks() async {
    return await _repository.getTasks();
  }
}
