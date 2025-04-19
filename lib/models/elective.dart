class Elective {
  final int subjectId;
  final String subjectName;
  final String subjectCode;

  Elective({
    required this.subjectId,
    required this.subjectName,
    required this.subjectCode,
  });

  factory Elective.fromJson(Map<String, dynamic> json) {
    return Elective(
      subjectId: json['subject_id'],
      subjectName: json['subject_name'],
      subjectCode: json['subject_code'],
    );
  }
}
