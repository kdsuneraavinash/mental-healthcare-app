import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/bloc/category_view_bloc.dart';
import 'package:mental_healthcare_app/logic/articles/category.dart';
import 'package:mental_healthcare_app/logic/articles/post.dart';
import 'package:mental_healthcare_app/ui/articles/post_card.dart';
import 'package:mental_healthcare_app/ui/transition_maker.dart';

const double EMPTY_SECTION_HEIGHT = 100.0;

class CategoryView extends StatelessWidget {
  final CategoryViewBLoC bloc;
  final Category category;

  CategoryView({this.category}) : bloc = CategoryViewBLoC(category: category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.category?.name ?? "Read Articles"),
      ),
      body: StreamBuilder<List<Category>>(
        stream: bloc.categoryListStream,
        builder: (_, categorySnapshot) => StreamBuilder<List<Post>>(
              stream: bloc.postListStream,
              builder: (_, postSnapshot) => _buildBodyContent(
                    context,
                    categorySnapshot,
                    postSnapshot,
                  ),
            ),
      ),
    );
  }

  Widget _buildBodyContent(
      BuildContext context,
      AsyncSnapshot<List<Category>> categorySnapshot,
      AsyncSnapshot<List<Post>> postSnapshot) {
    return ListView(physics: ClampingScrollPhysics(), children: [
      _buildSectionHeader(context, "Sub Categories",
          _buildCategoryStreamBuilder(context, categorySnapshot)),
      _buildSectionHeader(
          context, "Articles", _buildPostStreamBuilder(context, postSnapshot))
    ]);
  }

  Widget _buildLoadingSpinner(BuildContext context) {
    return SizedBox(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
        ),
      ),
      height: EMPTY_SECTION_HEIGHT,
    );
  }

  Widget _buildEmptySection() {
    return Container(
      child: Icon(
        FontAwesomeIcons.circle,
        size: 41.0,
      ),
      height: EMPTY_SECTION_HEIGHT,
      alignment: Alignment.center,
    );
  }

  List<Widget> _buildCategoryStreamBuilder(
    BuildContext context,
    AsyncSnapshot<List<Category>> categorySnapshot,
  ) {
    if (!categorySnapshot.hasData) return [_buildLoadingSpinner(context)];
    if (categorySnapshot.data.length == 0) return [];
    return categorySnapshot.data
        .map((v) => _buildSubCategoryItem(v, context))
        .toList();
  }

  List<Widget> _buildPostStreamBuilder(
    BuildContext context,
    AsyncSnapshot<List<Post>> postSnapshot,
  ) {
    if (!postSnapshot.hasData) return [_buildLoadingSpinner(context)];
    if (postSnapshot.data.length == 0) return [_buildEmptySection()];
    return postSnapshot.data.map((v) => PostCard(v)).toList();
  }

  Widget _buildSubCategoryItem(Category category, BuildContext context) {
    return ListTile(
      onTap: () => TransitionMaker.fadeTransition(
            destinationPageCall: () => CategoryView(category: category),
          )..start(context),
      trailing: CircleAvatar(
        child: Text(
          "${category.count}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
      title: Text(category.name),
      subtitle: Text(category.slug),
      leading: Icon(
        FontAwesomeIcons.folder,
        color: Theme.of(context).accentColor,
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String text, List<Widget> children) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w900,
          fontSize: 18.0,
        ),
      ),
      children: children,
    );
  }
}
