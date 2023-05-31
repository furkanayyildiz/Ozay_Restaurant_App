class CategoryModel {
  final String name;
  final String imageLink;

  CategoryModel({
    required this.name,
    required this.imageLink,
  });

  static CategoryModel fromFirestore(Map<String, dynamic> firestore) {
    return CategoryModel(
      name: firestore['name'],
      imageLink: firestore['imageLink'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'name': name,
      'imageLink': imageLink,
    };
  }
}
