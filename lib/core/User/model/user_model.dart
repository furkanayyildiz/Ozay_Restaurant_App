import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String surname;
  final String email;
  final String phone;
  final String uId;

  UserModel(
    this.name,
    this.surname,
    this.email,
    this.phone,
    this.uId,
  );

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      data['name'],
      data['surname'],
      data['email'],
      data['phone'],
      data['uId'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      "surname": surname,
      'email': email,
      'phone': phone,
      'uId': uId,
    };
  }
}
