class Todo {
  final int id;
  String title;
  String message;
  bool completed;

  Todo({
    required this.id,
    required this.title,
    required this.message,
    this.completed = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      message: json['message'],
    );
  }
}
