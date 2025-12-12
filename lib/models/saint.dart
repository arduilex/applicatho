import 'package:cloud_firestore/cloud_firestore.dart';

class Saint {
  final String id;
  final String name;
  final String imageUrl;
  final String description;

  Saint({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory Saint.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Saint(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
    };
  }
}
