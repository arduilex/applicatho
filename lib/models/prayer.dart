import 'package:cloud_firestore/cloud_firestore.dart';

class Prayer {
  final String id;
  final String title;
  final String text;
  final String category;

  Prayer({
    required this.id,
    required this.title,
    required this.text,
    required this.category,
  });

  factory Prayer.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Prayer(
      id: doc.id,
      title: data['title'] ?? '',
      text: data['text'] ?? '',
      category: data['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'text': text,
      'category': category,
    };
  }
}
