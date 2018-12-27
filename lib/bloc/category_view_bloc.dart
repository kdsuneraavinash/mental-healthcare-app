import 'dart:async';

import 'package:mental_healthcare_app/logic/articles/category.dart';
import 'package:mental_healthcare_app/logic/articles/post.dart';
import 'package:rxdart/subjects.dart';

class CategoryViewBLoC {
  Category category;
  List<Category> _subCategories;
  List<Post> _posts;

  // Out Streams
  StreamController<List<Category>> _categoryListStreamController =
      BehaviorSubject();
  Stream<List<Category>> get categoryListStream =>
      _categoryListStreamController.stream;

  StreamController<List<Post>> _postListStreamController = BehaviorSubject();
  Stream<List<Post>> get postListStream => _postListStreamController.stream;

  CategoryViewBLoC({this.category}) {
    _populateCategoryListStream();
    _populatePostListStream();
  }

  void _populateCategoryListStream() async {
    if (category == null) {
      _subCategories = await Category.getCategoriesFromWeb();
    } else {
      _subCategories = category.subCategories;
    }
    _categoryListStreamController.add(_subCategories);
  }

  void _populatePostListStream() async {
    _posts = await Post.getPostsFromWeb(category?.id ?? 0);
    _postListStreamController.add(_posts);
  }

  void dispose() {
    _categoryListStreamController.close();
    _postListStreamController.close();
  }
}
