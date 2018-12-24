import 'dart:async';

import 'package:mental_healthcare_app/logic/articles/category.dart';
import 'package:mental_healthcare_app/logic/articles/post.dart';

class CategoryViewBLoC {
  Category category;
  List<Category> subCategories;
  List<Post> posts;

  // Out Streams
  StreamController<List<Category>> _categoryListStreamController =
      StreamController();
  Stream<List<Category>> get categoryListStream =>
      _categoryListStreamController.stream;

  StreamController<List<Post>> _postListStreamController = StreamController();
  Stream<List<Post>> get postListStream => _postListStreamController.stream;

  CategoryViewBLoC({this.category}) {
    _populateCategoryListStream();
    _populatePostListStream();
  }

  void _populateCategoryListStream() async {
    if (category == null) {
      subCategories = await Category.getCategoriesFromWeb();
    } else {
      subCategories = category.subCategories;
    }
    _categoryListStreamController.add(subCategories);
  }

  void _populatePostListStream() async {
    posts = await Post.getPostsFromWeb(category?.id ?? 0);
    _postListStreamController.add(posts);
  }

  void dispose() {
    _categoryListStreamController.close();
    _postListStreamController.close();
  }
}
