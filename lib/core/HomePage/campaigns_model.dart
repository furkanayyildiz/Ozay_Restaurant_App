class CampaignsModel {
  final String title;
  final String description;

  CampaignsModel({
    required this.title,
    required this.description,
  });

  static CampaignsModel fromFirestore(Map<String, dynamic> firestore) {
    return CampaignsModel(
      title: firestore['title'],
      description: firestore['description'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }
}
