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

  Post({
    this.id,
    this.date,
    this.link,
    this.slug,
    this.title,
    this.excerpt,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        id: map["id"],
        date: map["date"],
        link: map["link"],
        slug: map["slug"],
        title: map["title"]["rendered"],
        excerpt: map["excerpt"]["rendered"]);
  }

  static List<Post> getPostsFromJson(List<Map<String, dynamic>> postMaps) {
    return postMaps.map((v) => Post.fromMap(v)).toList();
  }

  static List<Post> getTestPosts() {
    return getPostsFromJson(getJsonPosts());
  }

  static Future<List<Post>> getPostsFromWeb(int categoryId) async {
    String postUrl = "$POST_URL"
        "?_fields[]=id"
        "&_fields[]=date"
        "&_fields[]=link"
        "&_fields[]=slug"
        "&_fields[]=title"
        "&_fields[]=excerpt"
        "&per_page=100"
        "&categories=$categoryId";

    HTTP.Response response = await HTTP.get(postUrl);
    List postJson = JSON.jsonDecode(response.body);

    List<Map<String, dynamic>> parsedPosts = [];
    for (dynamic post in postJson) {
      if (post is Map<String, dynamic>) {
        parsedPosts.add(post);
      }
    }
    return getPostsFromJson(parsedPosts);
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
          "excerpt": excerpt
        }.toString();
  }
}
