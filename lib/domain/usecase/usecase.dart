abstract class Usecase<Input, Output> {
  Future<Output> excuteInsert(Input input);
  Future<Output> excuteUpdate(Input input);
  Future<Output> excuteDelete(Input input);
  Future<Output> excuteDeleteAll();
  Future<List<Map<String, dynamic>>> excuteGetTasks();
}
