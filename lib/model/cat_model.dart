class CategoryModel {
  int? id;
  String? name;
  int? color;
  CategoryModel({
    this.id,
    this.name,
    this.color,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (color != null) {
      result.addAll({'color': color});
    }

    return result;
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id']?.toInt(),
      name: map['name'],
      color: map['color']?.toInt(),
    );
  }
}
