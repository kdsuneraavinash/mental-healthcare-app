import 'package:flutter/material.dart';
import 'package:mental_healthcare_app/bloc/featured_post_bloc.dart';
import 'package:mental_healthcare_app/logic/articles/featured_post.dart';
import 'package:mental_healthcare_app/ui/articles/post_card.dart';

class HomePageContent extends StatelessWidget {
  final FeaturedPostBLoC bloc;

  HomePageContent() : bloc = FeaturedPostBLoC();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FeaturedPost>>(
      stream: bloc.featuredPostListStream,
      builder: (_, snapshot) {
        return ListView.builder(
            itemCount: snapshot.data?.length ?? 1,
            physics: ClampingScrollPhysics(),
            itemBuilder: (listContext, index) {
              if (snapshot.hasData && snapshot.data.length > 0) {
                return PostCard(snapshot.data[index]);
              } else {
                return _buildChildControl(CircularProgressIndicator(), context);
              }
            });
      },
    );
  }

  Widget _buildChildControl(Widget child, BuildContext context) {
    return SizedBox(
      child: Center(child: child),
      height: MediaQuery.of(context).size.height - 200,
    );
  }
}
