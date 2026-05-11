import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'health_event.model.dart';

class HealthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  // Stream of health events for the current user
  Stream<List<HealthEvent>> getHealthEvents() {
    if (currentUserId == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('health_events')
        .orderBy('dateTime', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return HealthEvent.fromMap(doc.data());
      }).toList();
    });
  }

  // Stream of health events for a specific type
  Stream<List<HealthEvent>> getHealthEventsByType(HealthEventType type) {
    if (currentUserId == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('health_events')
        .where('type', isEqualTo: type.name)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return HealthEvent.fromMap(doc.data());
      }).toList();
    });
  }

  // Add a new health event
  Future<void> addHealthEvent({
    required HealthEventType type,
    required String title,
    required String description,
    required DateTime dateTime,
    String? petId,
    String? petName,
    String? petImageUrl,
  }) async {
    if (currentUserId == null) return;

    final id = const Uuid().v4();
    final event = HealthEvent(
      id: id,
      type: type,
      title: title,
      description: description,
      dateTime: dateTime,
      petId: petId,
      petName: petName,
      petImageUrl: petImageUrl,
      userId: currentUserId!,
    );

    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('health_events')
        .doc(id)
        .set(event.toMap());
  }

  // Delete a health event
  Future<void> deleteHealthEvent(String id) async {
    if (currentUserId == null) return;

    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('health_events')
        .doc(id)
        .delete();
  }
}
