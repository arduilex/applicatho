import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/saint.dart';
import '../models/verse.dart';
import '../models/event.dart';
import '../models/prayer.dart';
import '../models/church.dart';
import '../models/member.dart';
import '../models/faq.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Random _random = Random();

  // Saints - Choix aléatoire
  Stream<Saint?> getRandomSaint() {
    return _firestore
        .collection('saints')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      // Choisir un document aléatoire
      final randomIndex = _random.nextInt(snapshot.docs.length);
      return Saint.fromFirestore(snapshot.docs[randomIndex]);
    });
  }

  // Verses - Choix aléatoire
  Stream<Verse?> getRandomVerse() {
    return _firestore
        .collection('verses')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      // Choisir un document aléatoire
      final randomIndex = _random.nextInt(snapshot.docs.length);
      return Verse.fromFirestore(snapshot.docs[randomIndex]);
    });
  }

  Stream<List<Verse>> getAllVerses() {
    return _firestore
        .collection('verses')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Verse.fromFirestore(doc)).toList());
  }

  // Events
  Stream<List<Event>> getUpcomingEvents({int limit = 3}) {
    return _firestore
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .orderBy('date', descending: false)
        .limit(limit)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Event.fromFirestore(doc)).toList());
  }

  Stream<List<Event>> getAllEvents() {
    return _firestore
        .collection('events')
        .orderBy('date', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Event.fromFirestore(doc)).toList());
  }

  // Prayers
  Stream<List<Prayer>> getPrayers() {
    return _firestore
        .collection('prayers')
        .orderBy('category')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Prayer.fromFirestore(doc)).toList());
  }

  // Churches
  Stream<List<Church>> getChurches() {
    return _firestore.collection('churches').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Church.fromFirestore(doc)).toList());
  }

  // Members
  Stream<List<Member>> getMembers() {
    return _firestore
        .collection('members')
        .orderBy('order')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Member.fromFirestore(doc)).toList());
  }

  // FAQ
  Stream<List<FAQ>> getFAQs() {
    return _firestore
        .collection('faqs')
        .orderBy('order')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => FAQ.fromFirestore(doc)).toList());
  }

  // Admin functions
  Future<void> addSaint(Saint saint) async {
    await _firestore.collection('saints').add(saint.toMap());
  }

  Future<void> updateSaint(Saint saint) async {
    await _firestore.collection('saints').doc(saint.id).update(saint.toMap());
  }

  Future<void> deleteSaint(String id) async {
    await _firestore.collection('saints').doc(id).delete();
  }

  Future<void> addVerse(Verse verse) async {
    await _firestore.collection('verses').add(verse.toMap());
  }

  Future<void> updateVerse(Verse verse) async {
    await _firestore.collection('verses').doc(verse.id).update(verse.toMap());
  }

  Future<void> deleteVerse(String id) async {
    await _firestore.collection('verses').doc(id).delete();
  }

  Future<void> addEvent(Event event) async {
    await _firestore.collection('events').add(event.toMap());
  }

  Future<void> updateEvent(Event event) async {
    await _firestore.collection('events').doc(event.id).update(event.toMap());
  }

  Future<void> deleteEvent(String id) async {
    await _firestore.collection('events').doc(id).delete();
  }

  Future<void> addPrayer(Prayer prayer) async {
    await _firestore.collection('prayers').add(prayer.toMap());
  }

  Future<void> updatePrayer(Prayer prayer) async {
    await _firestore.collection('prayers').doc(prayer.id).update(prayer.toMap());
  }

  Future<void> deletePrayer(String id) async {
    await _firestore.collection('prayers').doc(id).delete();
  }

  Future<void> addChurch(Church church) async {
    await _firestore.collection('churches').add(church.toMap());
  }

  Future<void> updateChurch(Church church) async {
    await _firestore.collection('churches').doc(church.id).update(church.toMap());
  }

  Future<void> deleteChurch(String id) async {
    await _firestore.collection('churches').doc(id).delete();
  }

  Future<void> addMember(Member member) async {
    await _firestore.collection('members').add(member.toMap());
  }

  Future<void> updateMember(Member member) async {
    await _firestore.collection('members').doc(member.id).update(member.toMap());
  }

  Future<void> deleteMember(String id) async {
    await _firestore.collection('members').doc(id).delete();
  }

  Future<void> addFAQ(FAQ faq) async {
    await _firestore.collection('faqs').add(faq.toMap());
  }

  Future<void> updateFAQ(FAQ faq) async {
    await _firestore.collection('faqs').doc(faq.id).update(faq.toMap());
  }

  Future<void> deleteFAQ(String id) async {
    await _firestore.collection('faqs').doc(id).delete();
  }
}
