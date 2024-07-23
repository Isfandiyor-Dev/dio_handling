class CategoryModel {
  final int id;
  final String name;
  final String image;
  final String? creationAt;
  final String? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.creationAt,
    this.updatedAt,
  });

  // fromJson metodi
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      creationAt: json['creationAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // toJson metodi
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
    };
  }
}
