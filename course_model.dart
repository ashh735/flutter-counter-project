class Course {
  final String id;
  final String subjectCode;
  final String subjectName;

  Course({
    required this.id,
    required this.subjectCode,
    required this.subjectName,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      subjectCode: json['subject_code'],
      subjectName: json['subject_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject_code': subjectCode,
      'subject_name': subjectName,
    };
  }
}
