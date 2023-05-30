import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String surname;
  final String email;
  final String phone;
  final String uId;

  UserModel({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.uId,
  });

  static UserModel fromFirestore(Map<String, dynamic> firestore) {
    return UserModel(
      name: firestore['name'],
      surname: firestore['surname'],
      email: firestore['email'],
      phone: firestore['phone'],
      uId: firestore['uId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'name': name,
      "surname": surname,
      'email': email,
      'phone': phone,
      'uId': uId,
    };
  }
}
