import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/bloc/category_view_bloc.dart';
import 'package:mental_healthcare_app/logic/articles/category.dart';
import 'package:mental_healthcare_app/logic/articles/post.dart';
import 'package:mental_healthcare_app/ui/articles/article_view.dart';
import 'package:mental_healthcare_app/ui/transition_maker.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;

class CategoryView extends StatelessWidget {
  final CategoryViewBLoC bloc;
  final Category category;

  CategoryView({this.category}) : bloc = CategoryViewBLoC(category: category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              MediaQuery.removePadding(
                context: context,
                child: SliverAppBar(
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    title: Text(this.category?.name ?? "Categories"),
                    background: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://kdsuneraavinash-dev.000webhostapp.com/wp-content/uploads/2018/12/cropped-cropped-web_bg-1.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Opacity(
                          child: Container(
                              color: theme.UIColors.articlesOverlayColor),
                          opacity: 0.6,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              (category?.description?.substring(
                                      0,
                                      (category.description.length > 200)
                                          ? 200
                                          : category.description.length) ??
                                  "This is the Article Viewer.\n"
                                  "You can read articles of browse sub categories."),
                              textAlign: TextAlign.center,
                              style: theme.UITextThemes()
                                  .articleTopBarBackgroundText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  expandedHeight: 200.0,
                  backgroundColor: theme.UIColors.articlesOverlayColor,
                  pinned: true,
                  floating: false,
                ),
              )
            ];
          },
          body: StreamBuilder<List<Category>>(
            stream: bloc.categoryListStream,
            builder: (_, categorySnapshot) => StreamBuilder<List<Post>>(
                  stream: bloc.postListStream,
                  builder: (_, postSnapshot) => _buildBodyContent(
                      context, categorySnapshot, postSnapshot),
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyContent(
      BuildContext context,
      AsyncSnapshot<List<Category>> categorySnapshot,
      AsyncSnapshot<List<Post>> postSnapshot) {
    return ListView(
        physics: ClampingScrollPhysics(),
        children: _buildStickyHeaderHead("Sub Categories") +
            _buildCategoryStreamBuilder(context, categorySnapshot) +
            _buildStickyHeaderHead("Articles") +
            _buildPostStreamBuilder(context, postSnapshot));
  }

  Widget _buildLoadingSpinner() {
    return SizedBox(
      child: Center(child: CircularProgressIndicator()),
      height: 250.0,
    );
  }

  List<Widget> _buildStickyHeaderHead(String text) {
    return [
      Container(
        height: 50.0,
        color: theme.UIColors.articlesHeaderColor,
        padding: new EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: new Text(
          text,
          style: theme.UITextThemes().articleHeaderText,
        ),
      )
    ];
  }

  List<Widget> _buildCategoryStreamBuilder(
      BuildContext context, AsyncSnapshot<List<Category>> categorySnapshot) {
    if (categorySnapshot.hasData) {
      if (categorySnapshot.data.length == 0) {
        return [
          Container(
              child: Center(child: Text("No sub categories")), height: 50.0),
        ];
      } else {
        return categorySnapshot.data
            .map((v) => _buildSubCategoryList(v, context))
            .toList();
      }
    } else {
      return [_buildLoadingSpinner()];
    }
  }

  List<Widget> _buildPostStreamBuilder(
      BuildContext context, AsyncSnapshot<List<Post>> postSnapshot) {
    if (postSnapshot.hasData) {
      if (postSnapshot.data.length == 0) {
        return [
          Container(child: Center(child: Text("No posts")), height: 50.0)
        ];
      } else {
        return postSnapshot.data
            .map((v) => _buildPostList(v, context))
            .toList();
      }
    } else {
      return [_buildLoadingSpinner()];
    }
  }

  Widget _buildSubCategoryList(Category category, BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () => TransitionMaker.fadeTransition(
            destinationPageCall: () => CategoryView(
                  category: category,
                ))
          ..start(context),
        trailing: CircleAvatar(
          child: Text("${category.count}", style: theme.UITextThemes().articleHeaderText, ),
          backgroundColor: theme.UIColors.articleColor,
        ),
        title: Text("${category.name}"),
        subtitle: Text("${category.slug}"),
        leading: Icon(FontAwesomeIcons.folder),
      ),
    );
  }

  Widget _buildPostList(Post post, BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () => TransitionMaker.fadeTransition(
            destinationPageCall: () => ArticleView(post.title, post.link))
          ..start(context),
        title: Text("${post.title}"),
        subtitle: Text("${post.slug}"),
        leading: Icon(
          FontAwesomeIcons.newspaper,
          color: theme.UIColors.articleColor,
        ),
      ),
    );
  }
}
