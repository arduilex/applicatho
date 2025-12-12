import 'package:cloud_firestore/cloud_firestore.dart';

class Verse {
  final String id;
  final String text;
  final String reference;

  Verse({
    required this.id,
    required this.text,
    required this.reference,
  });

  factory Verse.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Verse(
      id: doc.id,
      text: data['text'] ?? '',
      reference: data['reference'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'reference': reference,
    };
  }
}
