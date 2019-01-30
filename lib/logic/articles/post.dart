import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as HTTP;
import 'dart:convert' as JSON;

import 'package:mental_healthcare_app/logic/articles/test_posts.dart';

const String POST_URL =
    "http://kdsuneraavinash-dev.000webhostapp.com/wp-json/wp/v2/posts";

class Post {
  final int id;
  final String date;
  final String link;
  final String slug;
  final String title;
  final String excerpt;
  final int featuredMediaId;

  String get formattedDate {
    DateTime x = DateTime.parse(date);
    int d = x.day;
    int m = x.month;
    int y = x.year;

    List<String> month = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    return "$d, ${month[m]}, $y";
  }

  Post({
    this.id,
    this.date,
    this.link,
    this.slug,
    this.title,
    this.excerpt,
    this.featuredMediaId,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map["id"],
      date: map["date"],
      link: map["link"],
      slug: map["slug"],
      title: HtmlUnescape().convert(map["title"]["rendered"]),
      excerpt: HtmlUnescape()
          .convert(map["excerpt"]["rendered"])
          .replaceAll("</p>", "")
          .replaceAll("<p>", ""),
      featuredMediaId: map["featured_media"],
    );
  }

  static List<Post> getPostsFromJson(List<Map<String, dynamic>> postMaps) {
    return postMaps.map((v) => Post.fromMap(v)).toList();
  }

  static List<Post> getTestPosts() {
    return getPostsFromJson(getJsonPosts());
  }

  static Future<List<Post>> getPostsFromWeb(
      [int categoryId = -1, String url]) async {
    String postUrl = url ??
        "$POST_URL"
        "?_fields[]=id"
        "&_fields[]=date"
        "&_fields[]=link"
        "&_fields[]=slug"
        "&_fields[]=title"
        "&_fields[]=excerpt"
        "&_fields[]=featured_media"
        "&per_page=100";
    if (categoryId != -1) postUrl += "&categories=$categoryId";

    try {
      HTTP.Response response = await HTTP.get(postUrl);
      List postJson = JSON.jsonDecode(response.body);

      List<Map<String, dynamic>> parsedPosts = [];
      for (dynamic post in postJson) {
        if (post is Map<String, dynamic>) {
          parsedPosts.add(post);
        }
      }
      return getPostsFromJson(parsedPosts);
    } catch (e) {
      print("Network Exception: $e");
      return [];
    }
  }

  @override
  String toString() {
    return "POST: " +
        {
          "id": id,
          "date": date,
          "link": link,
          "slug": slug,
          "title": title,
          "excerpt": excerpt,
          "featured_media": featuredMediaId
        }.toString();
  }
}
