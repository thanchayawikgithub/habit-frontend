// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:habit_frontend/app/data/models/habit.dart';

class HabitRecord {
  String? id;
  String habitId;
  String date;
  bool status;
  Habit? habit;
  HabitRecord({
    this.id,
    required this.habitId,
    required this.date,
    this.status = false,
    this.habit,
  });

  HabitRecord copyWith({
    String? id,
    String? habitId,
    String? date,
    bool? status,
    Habit? habit,
  }) {
    return HabitRecord(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      status: status ?? this.status,
      habit: habit ?? this.habit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'habitId': habitId,
      'date': date,
      'status': status,
      'habit': habit?.toMap(),
    };
  }

  factory HabitRecord.fromMap(Map<String, dynamic> map) {
    return HabitRecord(
      id: map['id'] != null ? map['id'] as String : null,
      habitId: map['habitId'] as String,
      date: map['date'] as String,
      status: map['status'] as bool,
      habit: map['habit'] != null
          ? Habit.fromMap(map['habit'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HabitRecord.fromJson(String source) =>
      HabitRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HabitRecord(id: $id, habitId: $habitId, date: $date, status: $status, habit: $habit)';
  }

  @override
  bool operator ==(covariant HabitRecord other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.habitId == habitId &&
        other.date == date &&
        other.status == status &&
        other.habit == habit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        habitId.hashCode ^
        date.hashCode ^
        status.hashCode ^
        habit.hashCode;
  }
}
