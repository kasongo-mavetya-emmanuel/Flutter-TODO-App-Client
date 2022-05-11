class TaskModel{
  String title;
  String  id;
  String description;

  TaskModel({
    required this.title,
    required this.id,
    required this.description,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['name'] as String,
      id: map['_id'] as String,
      description: map['description'] as String,
    );
  }
}