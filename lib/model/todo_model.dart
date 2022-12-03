class TodoModel {
  int? id;
  String? title;
  String? todo;
  int? isCompleted;
  String? date;
  int? color;
  String? remind;
  String? repeat;
  TodoModel({
    this.id,
    this.title,
    this.todo,
    this.isCompleted,
    this.date,
    this.color,
    this.remind,
    this.repeat,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (todo != null) {
      result.addAll({'todo': todo});
    }
    if (isCompleted != null) {
      result.addAll({'isCompleted': isCompleted});
    }
    if (date != null) {
      result.addAll({'date': date});
    }
    if (color != null) {
      result.addAll({'color': color});
    }
    if (remind != null) {
      result.addAll({'remind': remind});
    }
    if (repeat != null) {
      result.addAll({'repeat': repeat});
    }

    return result;
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id']?.toInt(),
      title: map['title'],
      todo: map['todo'],
      isCompleted: map['isCompleted']?.toInt(),
      date: map['date'],
      color: map['color']?.toInt(),
      remind: map['remind'],
      repeat: map['repeat'],
    );
  }
}
