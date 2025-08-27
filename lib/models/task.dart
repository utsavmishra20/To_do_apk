class Task {
  String id;
  String title;
  String? description;
  bool isCompleted;
  DateTime? duedate;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.duedate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'duedate': duedate,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      duedate: json['duedate'],
      isCompleted: json['isCompleted'],
    );
  }
}
