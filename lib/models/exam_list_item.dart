class Exam {
  final String id;
  final String createdAt;
  final List exams;

  const Exam({
    required this.id,
    required this.createdAt,
    required this.exams,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      createdAt: json['createdAt'],
      exams: json['exams'],
    );
  }
}
