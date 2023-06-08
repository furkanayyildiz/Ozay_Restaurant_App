class OpinionModel {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String phone;
  final String title;
  final String description;

  OpinionModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.title,
    required this.description,
  });

  static OpinionModel fromFirestore(Map<String, dynamic> firestore) {
    return OpinionModel(
      id: firestore['id'],
      name: firestore['name'],
      surname: firestore['surname'],
      email: firestore['email'],
      phone: firestore['phone'],
      title: firestore['title'],
      description: firestore['description'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'phone': phone,
      'title': title,
      'description': description,
    };
  }
}
