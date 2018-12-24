import 'package:meta/meta.dart';
import 'package:mental_healthcare_app/logic/doc_list/test_doctors.dart';

enum Sex { MALE, FEMALE }

class Doctor {
  final String name;
  final Sex sex;
  final String institute;
  final String contactNumber;
  final String email;

  Doctor(
      {@required this.name,
      @required this.sex,
      @required this.institute,
      @required this.contactNumber,
      @required this.email});

  factory Doctor.fromMap(Map<String, String> map) {
    return Doctor(
      name: map["name"],
      sex: map["sex"] == "male" ? Sex.MALE : Sex.FEMALE,
      institute: map["institute"],
      email: map["email"],
      contactNumber: map["contact_number"],
    );
  }

  static List<Doctor> loadTestDoctors() {
    List jsnDoctors = getJsonDoctors();
    List<Doctor> doctors = jsnDoctors.map((d) => Doctor.fromMap(d)).toList();
    return doctors;
  }

  @override
  String toString() {
    return {
      "Name": name,
      "Gender": sex,
      "Institute": institute,
      "Email": email,
      "Tel": contactNumber
    }.toString();
  }
}
