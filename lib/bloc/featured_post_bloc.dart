import 'dart:async';

import 'package:mental_healthcare_app/logic/articles/featured_post.dart';
import 'package:rxdart/subjects.dart';

class FeaturedPostBLoC {
  List<FeaturedPost> _posts;

  // Out Streams
  StreamController<List<FeaturedPost>> _featuredPostListStreamController =
      BehaviorSubject();
  Stream<List<FeaturedPost>> get featuredPostListStream =>
      _featuredPostListStreamController.stream;

  FeaturedPostBLoC() {
    _populateFeaturedPostListStream();
  }

  void _populateFeaturedPostListStream() async {
    _posts = await FeaturedPost.getFeaturedPostsFromWeb();
    _featuredPostListStreamController.add(_posts);
  }

  void dispose() {
    _featuredPostListStreamController.close();
  }
}
