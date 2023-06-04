class CartModel {
  final String id;
  final String name;
  final String imageLink;
  final int price;
  final int quantity;
  final int totalPrice;
  final String category;

  CartModel({
    required this.name,
    required this.imageLink,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.id,
    required this.category,
  });

  static CartModel fromFirestore(Map<String, dynamic> firestore) {
    return CartModel(
      id: firestore['id'],
      name: firestore['name'],
      price: firestore['price'],
      imageLink: firestore['imageLink'],
      category: firestore['category'],
      quantity: firestore['quantity'],
      totalPrice: firestore['totalPrice'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'name': name,
      'imageLink': imageLink,
      'price': price,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'id': id,
      'category': category,
    };
  }
}
