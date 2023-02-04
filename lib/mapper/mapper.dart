import 'package:libraryWDA/models/doctor_list_item.dart';
import 'package:libraryWDA/models/exam_list_item.dart';
import 'package:libraryWDA/models/query_list_item.dart';

class Mapper {
  toDoctorListItem(data) {
    return data.map((p) => Doctor.fromJson(p)).toList();
  }

  toBookListItem(data) {
    return data.map((p) => Book.fromJson(p)).toList();
  }

  toExamListItem(data) {
    return data.map((p) => Exam.fromJson(p)).toList();
  }
}
