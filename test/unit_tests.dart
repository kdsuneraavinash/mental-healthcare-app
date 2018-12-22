// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mental_healthcare_app/logic/clinic_locations/clinic_location.dart';
import 'package:mental_healthcare_app/logic/doc_list/doctor.dart';
import 'package:mental_healthcare_app/logic/trivia_qa/trivia_question.dart';

void main() {
  test("Checking if API call works correctly", () async {
    expect(await TriviaQuestion.getQuestionFromOpenDB(),
        allOf([isNotNull, isMap, isNotEmpty]));
  });

  test("Checking if trivia fromOpenDBJSON() works", () async {
    expect(await TriviaQuestion.fromOpenDB(), allOf([isNotNull]));
  });

  test("Checking if test Doctors loaded successfully", () {
    expect(Doctor.loadTestDoctors(), allOf([isNotNull]));
  });

  test("Checking if test Clinic Locations loaded successfully", () {
    expect(ClinicLocation.getTestLocations(), allOf([isNotNull]));
  });
}
