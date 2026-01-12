import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  final String id;
  final String name;
  final String role;
  final String photoUrl;
  final int order;
  final String contactUrl;

  Member({
    required this.id,
    required this.name,
    required this.role,
    required this.photoUrl,
    required this.order,
    required this.contactUrl,
  });

  factory Member.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Member(
      id: doc.id,
      name: data['name'] ?? '',
      role: data['role'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      order: data['order'] ?? 0,
      contactUrl: data['contactUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'role': role,
      'photoUrl': photoUrl,
      'order': order,
      'contactUrl': contactUrl,
    };
  }
}
