import 'package:ozay_restaurant_app/core/Menu/model/cart_model.dart';

class OrderModel {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String phone;
  final int tableNumber;
  final String description;
  final int totalPrice;

  OrderModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.tableNumber,
    required this.description,
    required this.totalPrice,
  });
  static OrderModel fromFirestore(Map<String, dynamic> firestore) {
    return OrderModel(
      id: firestore['id'],
      name: firestore['name'],
      surname: firestore['surname'],
      email: firestore['email'],
      phone: firestore['phone'],
      tableNumber: firestore['tableNumber'],
      description: firestore['description'],
      totalPrice: firestore['totalPrice'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'name': name,
      'surname': surname,
      'email': email,
      'phone': phone,
      'tableNumber': tableNumber,
      'description': description,
      'id': id,
      'totalPrice': totalPrice,
    };
  }
}
