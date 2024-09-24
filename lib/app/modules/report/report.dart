// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Report {
  int id;
  String title;
  int progress;
  String target;
  String status;
  Report({
    required this.id,
    required this.title,
    required this.progress,
    required this.target,
    required this.status,
  });

  Report copyWith({
    int? id,
    String? title,
    int? progress,
    String? target,
    String? status,
  }) {
    return Report(
      id: id ?? this.id,
      title: title ?? this.title,
      progress: progress ?? this.progress,
      target: target ?? this.target,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'progress': progress,
      'target': target,
      'status': status,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] as int,
      title: map['title'] as String,
      progress: map['progress'] as int,
      target: map['target'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) =>
      Report.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Report(id: $id, title: $title, progress: $progress, target: $target, status: $status)';
  }

  @override
  bool operator ==(covariant Report other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.progress == progress &&
        other.target == target &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        progress.hashCode ^
        target.hashCode ^
        status.hashCode;
  }
}
