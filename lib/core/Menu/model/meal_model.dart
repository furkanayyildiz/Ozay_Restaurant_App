class MealModel {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imageLink;
  final String category;

  MealModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageLink,
    required this.category,
  });

  static MealModel fromFirestore(Map<String, dynamic> firestore) {
    return MealModel(
      id: firestore['id'],
      name: firestore['name'],
      description: firestore['description'],
      price: firestore['price'],
      imageLink: firestore['imageLink'],
      category: firestore['category'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageLink': imageLink,
      'category': category,
    };
  }
}
