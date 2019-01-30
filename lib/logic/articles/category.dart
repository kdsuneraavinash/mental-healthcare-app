import 'package:mental_healthcare_app/logic/articles/test_categories.dart';
import 'package:http/http.dart' as HTTP;
import 'dart:convert' as JSON;

const String CATEGORY_URL =
    "http://kdsuneraavinash-dev.000webhostapp.com/wp-json/wp/v2/categories";

class Category {
  final int id;
  final int count;
  final String description;
  final String link;
  final String name;
  String slug;
  final int parent;
  List articles;
  List<Category> subCategories;

  Category({
    this.id,
    this.count,
    this.description,
    this.link,
    this.name,
    this.slug,
    this.parent,
  }) {
    this.articles = [];
    this.subCategories = [];
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        id: map["id"],
        count: map["count"],
        description: map["description"],
        link: map["link"],
        name: map["name"],
        slug: "/${map["slug"]}",
        parent: map["parent"]);
  }

  static List<Category> getCategoriesFromJson(
      List<Map<String, dynamic>> categoryMaps) {
    Map<int, Category> indexedCategories = Map.fromEntries(
      categoryMaps.map(
        (v) {
          Category category = Category.fromMap(v);
          return MapEntry<int, Category>(category.id, category);
        },
      ),
    );

    List<Category> mainCategories = [];

    for (Category category in indexedCategories.values) {
      if (category.parent == 0) {
        mainCategories.add(category);
        continue;
      }
      if (!indexedCategories.containsKey(category.parent)) continue;
      Category parentCategory = indexedCategories[category.parent];
      category.slug = "${parentCategory.slug}${category.slug}";
      parentCategory.subCategories.add(category);
    }

    return mainCategories;
  }

  static List<Category> getTestCategories() {
    return getCategoriesFromJson(getJsonCategories());
  }

  static Future<List<Category>> getCategoriesFromWeb() async {
    String categoryUrl = "$CATEGORY_URL"
        "?_fields[]=id"
        "&_fields[]=count"
        "&_fields[]=description"
        "&_fields[]=link"
        "&_fields[]=name"
        "&_fields[]=slug"
        "&_fields[]=parent";

    try {
      HTTP.Response response = await HTTP.get(categoryUrl);

      List categoryJson = JSON.jsonDecode(response.body);

      List<Map<String, dynamic>> parsedCategories = [];
      for (dynamic category in categoryJson) {
        if (category is Map<String, dynamic>) {
          parsedCategories.add(category);
        }
      }
      return getCategoriesFromJson(parsedCategories);
    } catch (e) {
      print("Network Exception: $e");
      return [];
    }
  }

  @override
  String toString() {
    return "CATEGORY: " +
        {
          "id": id,
          "count": count,
          "description": description,
          "link": link,
          "name": name,
          "slug": slug,
          "parent": parent,
          "subCategories": subCategories
        }.toString();
  }
}
