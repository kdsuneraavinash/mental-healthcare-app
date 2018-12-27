import 'package:mental_healthcare_app/logic/articles/post.dart';

class FeaturedPost extends Post {
  FeaturedPost({
    id,
    date,
    link,
    slug,
    title,
    excerpt,
    featuredMediaId,
  }) : super(
          id: id,
          date: date,
          link: link,
          slug: slug,
          title: title,
          excerpt: excerpt,
    featuredMediaId: featuredMediaId,
        );

  factory FeaturedPost.fromPost(Post post) {
    return FeaturedPost(
      id: post.id,
      date: post.date,
      link: post.link,
      slug: post.slug,
      title: post.title,
      excerpt: post.excerpt,
      featuredMediaId: post.featuredMediaId,
    );
  }

  factory FeaturedPost.fromMap(Map<String, dynamic> map) {
    return FeaturedPost.fromPost(Post.fromMap(map));
  }

  static Future<List<FeaturedPost>> getFeaturedPostsFromWeb() async {
    String postUrl = "$POST_URL"
        "?filter[orderby]=date"
        "&order=desc"
        "&_fields[]=id"
        "&_fields[]=date"
        "&_fields[]=link"
        "&_fields[]=slug"
        "&_fields[]=title"
        "&_fields[]=excerpt"
        "&_fields[]=featured_media"
        "&per_page=6";

    List<Post> parsedPosts = await Post.getPostsFromWeb(-1, postUrl);
    return parsedPosts.map((v) => FeaturedPost.fromPost(v)).toList();
  }

  @override
  String toString() {
    return "FEATURED " + super.toString();
  }
}
