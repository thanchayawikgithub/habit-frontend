// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Habit {
  String? id;
  String title;
  String description;
  int period;
  List<String> dayOfweeks;
  Habit({
    this.id,
    required this.title,
    required this.description,
    required this.period,
    required this.dayOfweeks,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    int? period,
    List<String>? dayOfweeks,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      period: period ?? this.period,
      dayOfweeks: dayOfweeks ?? this.dayOfweeks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'period': period,
      'dayOfweeks': dayOfweeks,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      period: map['period'] ?? 0,
      dayOfweeks: List<String>.from(
          map['dayOfweeks'] ?? []), // Correctly casting to List<String>
    );
  }

  String toJson() => json.encode(toMap());

  factory Habit.fromJson(String source) =>
      Habit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Habit(id: $id, title: $title, description: $description, period: $period, dayOfweeks: $dayOfweeks)';
  }

  @override
  bool operator ==(covariant Habit other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.period == period &&
        listEquals(other.dayOfweeks, dayOfweeks);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        period.hashCode ^
        dayOfweeks.hashCode;
  }
}
