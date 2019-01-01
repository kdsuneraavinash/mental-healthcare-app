// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mental_healthcare_app/logic/articles/category.dart';
import 'package:mental_healthcare_app/logic/articles/featured_post.dart';
import 'package:mental_healthcare_app/logic/articles/post.dart';
import 'package:mental_healthcare_app/logic/location/location.dart';
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

  test("Checking if test Doctors loads successfully from local test file", () {
    expect(Doctor.loadTestDoctors(), allOf([isNotNull]));
  });

  test(
      "Checking if test Clinic Locations loads successfully from local test file",
      () {
    expect(Location.getLocations(), allOf([isNotNull]));
  });

  test("Checking if test Categories load successfully from local test file",
      () {
    expect(Category.getTestCategories(), allOf([isNotNull]));
  });

  test("Checking if test Posts load successfully from local test file", () {
    expect(Post.getTestPosts(), allOf([isNotNull]));
  });

  test("Checking if Categories load successfully from web", () async {
    expect(await Category.getCategoriesFromWeb(), allOf([isNotNull]));
  });

  test("Checking if Featured Posts load successfully from web", () async {
  expect(await FeaturedPost.getFeaturedPostsFromWeb(), allOf([isNotNull]));
  });
}
