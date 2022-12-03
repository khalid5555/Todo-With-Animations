class NoteModel {
  int? id;
  String? title;
  String? body;
  int? categoryId;
  String? dateTimeCreated;
  int? color;
  String? dateTimeEdited;
  NoteModel({
    this.id,
    this.title,
    this.body,
    this.categoryId,
    this.dateTimeCreated,
    this.color,
    this.dateTimeEdited,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (body != null) {
      result.addAll({'body': body});
    }
    if (categoryId != null) {
      result.addAll({'categoryId': categoryId});
    }
    if (dateTimeCreated != null) {
      result.addAll({'dateTimeCreated': dateTimeCreated});
    }
    if (color != null) {
      result.addAll({'color': color});
    }
    if (dateTimeEdited != null) {
      result.addAll({'dateTimeEdited': dateTimeEdited});
    }

    return result;
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id']?.toInt(),
      title: map['title'],
      body: map['body'],
      categoryId: map['categoryId']?.toInt(),
      dateTimeCreated: map['dateTimeCreated'],
      color: map['color']?.toInt(),
      dateTimeEdited: map['dateTimeEdited'],
    );
  }
}
