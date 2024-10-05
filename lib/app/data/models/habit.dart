// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Habit {
  String? id;
  String title;
  String description;
  int period;
  Habit({
    this.id,
    required this.title,
    required this.description,
    required this.period,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    int? period,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      period: period ?? this.period,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'period': period,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] as String,
      description: map['description'] as String,
      period: map['period'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Habit.fromJson(String source) =>
      Habit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Habit(id: $id, title: $title, description: $description, period: $period)';
  }

  @override
  bool operator ==(covariant Habit other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.period == period;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        period.hashCode;
  }
}
