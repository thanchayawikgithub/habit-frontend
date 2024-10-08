import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:habit_frontend/app/data/models/habit_record.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Habit {
  String? id;
  String title;
  String description;
  String? userId;
  List<HabitRecord> habitRecords;
  IconData? icon;
  String? reminderTime;
  Color color;
  Habit({
    this.id,
    required this.title,
    required this.description,
    this.userId,
    required this.habitRecords,
    this.icon,
    this.reminderTime,
    required this.color,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    String? userId,
    List<HabitRecord>? habitRecords,
    IconData? icon,
    String? reminderTime,
    Color? color,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      habitRecords: habitRecords ?? this.habitRecords,
      icon: icon ?? this.icon,
      reminderTime: reminderTime ?? this.reminderTime,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'userId': userId,
      'habitRecords': habitRecords.map((x) => x.toMap()).toList(),
      'icon': icon?.codePoint,
      'reminderTime': reminderTime,
      'color': color.value,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] as String,
      description: map['description'] as String,
      userId: map['userId'] != null ? map['userId'] as String : null,
      habitRecords: List<HabitRecord>.from(
        (map['habitRecords'] as List<dynamic>).map<HabitRecord>(
          (x) => HabitRecord.fromMap(x as Map<String, dynamic>),
        ),
      ),
      icon: map['icon'] != null
          ? IconData(map['icon'] as int, fontFamily: 'MaterialIcons')
          : null,
      reminderTime:
          map['reminderTime'] != null ? map['reminderTime'] as String : null,
      color: Color(map['color'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Habit.fromJson(String source) =>
      Habit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Habit(id: $id, title: $title, description: $description, userId: $userId, habitRecords: $habitRecords, icon: $icon, reminderTime: $reminderTime, color: $color)';
  }

  @override
  bool operator ==(covariant Habit other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.userId == userId &&
        listEquals(other.habitRecords, habitRecords) &&
        other.icon == icon &&
        other.reminderTime == reminderTime &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        userId.hashCode ^
        habitRecords.hashCode ^
        icon.hashCode ^
        reminderTime.hashCode ^
        color.hashCode;
  }
}
