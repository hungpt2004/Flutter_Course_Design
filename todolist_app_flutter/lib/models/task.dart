class Task {
  final String name;
  final String description;
  final DateTime createdAt;
  bool isDone;

  Task({required this.name, required this.createdAt, required this.description, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

}