class Task {
  int id;
  String name;
  String description;
  final DateTime createdAt;
  DateTime deadlineAt;
  bool isFavourite;

  Task(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.deadlineAt,
      this.isFavourite = false,
      required this.description,
      });

  // void toggleDone() {
  //   isDone = !isDone;
  // }

}
