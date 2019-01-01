import 'package:meta/meta.dart';
import 'package:mental_healthcare_app/logic/about_us/about_us_storage.dart';

class AboutPerson {
  final String name;
  final String photo;
  final String description;
  final String title;
  final String url;

  AboutPerson(
      {@required this.name,
      @required this.photo,
      @required this.description,
      @required this.title,
      @required this.url});

  factory AboutPerson.fromMap(Map<String, String> map) {
    return AboutPerson(
      name: map["name"],
      photo: map["photo"],
      description: map["description"],
      title: map["title"],
      url: map["url"],
    );
  }

  static List<AboutPerson> loadData() {
    List jsnPeople = getJsonPeople();
    List<AboutPerson> doctors =
        jsnPeople.map((d) => AboutPerson.fromMap(d)).toList();
    return doctors;
  }

  @override
  String toString() {
    return {
      "name": name,
      "photo": photo,
      "description": description,
      "title": title,
      "url": url
    }.toString();
  }
}

