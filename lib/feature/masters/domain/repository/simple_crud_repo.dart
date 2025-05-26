abstract class SimpleCrudRepo<T> {
  Future<List<T>> getAllTasks();
  Future<int> createTask(T o);
  Future<int> updateTask(T o);
  Future<int> deleteTask(T o);
}
