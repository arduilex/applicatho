import 'package:cloud_firestore/cloud_firestore.dart';

class FAQ {
  final String id;
  final String question;
  final String answer;
  final int order;

  FAQ({
    required this.id,
    required this.question,
    required this.answer,
    required this.order,
  });

  factory FAQ.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return FAQ(
      id: doc.id,
      question: data['question'] ?? '',
      answer: data['answer'] ?? '',
      order: data['order'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      'order': order,
    };
  }
}
