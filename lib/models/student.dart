class Student {
  final int id;
  final String name;
  final String rollNumber;
  final List<int> electiveIds;

  Student({
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.electiveIds,
  });

  // Factory constructor to create a Student object from a JSON object
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      rollNumber: json['roll_number'],
      electiveIds: List<int>.from(json['elective_ids']),
    );
  }

  // Method to convert the Student object into a map to be sent in the request body
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'roll_number': rollNumber,
      'elective_ids': electiveIds,
    };
  }
}
