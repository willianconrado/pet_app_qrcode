import 'package:cloud_firestore/cloud_firestore.dart';

enum HealthEventType {
  appointment,
  vaccination,
  medication,
  care
}

class HealthEvent {
  final String id;
  final HealthEventType type;
  final String title;
  final String description;
  final DateTime dateTime;
  final String? petId;
  final String? petName;
  final String? petImageUrl;
  final String userId;

  HealthEvent({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.dateTime,
    this.petId,
    this.petName,
    this.petImageUrl,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'description': description,
      'dateTime': Timestamp.fromDate(dateTime),
      'petId': petId,
      'petName': petName,
      'petImageUrl': petImageUrl,
      'userId': userId,
    };
  }

  factory HealthEvent.fromMap(Map<String, dynamic> map) {
    return HealthEvent(
      id: map['id'] ?? '',
      type: HealthEventType.values.byName(map['type'] ?? 'appointment'),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      petId: map['petId'],
      petName: map['petName'],
      petImageUrl: map['petImageUrl'],
      userId: map['userId'] ?? '',
    );
  }
}
