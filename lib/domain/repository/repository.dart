import '../model/task.dart';

abstract class Repository {
  Future<int> insert(Task task);
  Future<int> updateRaw(Task task);
  Future<int> delete(Task task);
  Future<int> deleteAll();
  Future<List<Map<String, dynamic>>> getTasks();
}
