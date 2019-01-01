import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/bloc/featured_post_bloc.dart';
import 'package:mental_healthcare_app/localization/localization.dart';
import 'package:mental_healthcare_app/logic/articles/featured_post.dart';
import 'package:mental_healthcare_app/main.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:mental_healthcare_app/ui/about_us/about_us_page.dart';
import 'package:mental_healthcare_app/ui/articles/category_view.dart';
import 'package:mental_healthcare_app/ui/articles/post_card.dart';
import 'package:mental_healthcare_app/ui/location_map/location_map.dart';
import 'package:mental_healthcare_app/ui/transition_maker.dart';

class HomePageContent extends StatelessWidget {
  final FeaturedPostBLoC bloc;

  HomePageContent() : bloc = FeaturedPostBLoC();

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: NestedScrollView(
        headerSliverBuilder: (_, __) => [_buildSliverAppBar(context)],
        body: StreamBuilder<List<FeaturedPost>>(
          stream: bloc.featuredPostListStream,
          builder: (_, snapshot) {
            return ListView.builder(
                itemCount: (snapshot.data?.length ?? 1) + 1,
                physics: ClampingScrollPhysics(),
                itemBuilder: (listContext, index) {
                  if (index == 0) {
                    return CategoryView.buildSectionHeader(
                        CustomLocalizationProvider.of(context)
                            .localization
                            .homePageRecentArticlesTitle);
                  } else {
                    if (snapshot.hasData && snapshot.data.length > 0) {
                      return PostCard(snapshot.data[index - 1]);
                    } else {
                      return _buildChildControl(
                          CircularProgressIndicator(), context);
                    }
                  }
                });
          },
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      child: SliverAppBar(
        flexibleSpace: _buildAppBarFlexibleSpace(context),
        actions: _buildAppBarActions(context),
        expandedHeight: MediaQuery.of(context).size.height,
        backgroundColor: theme.UIColors.primaryColor,
        pinned: true,
        floating: false,
        title: Text(CustomLocalizationProvider.of(context)
            .localization
            .homePageAppBarTitle),
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return [
      PopupMenuButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(FontAwesomeIcons.language, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  CustomLocalizationProvider.of(context)
                      .localization
                      .homePageAppBarLanguageSelected,
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    title: Text('English'),
                    leading: CircleAvatar(child: Text("En")),
                  ),
                  value: 'en'),
              // PopupMenuItem<String>(
              //     child: ListTile(
              //       contentPadding: EdgeInsets.all(0.0),
              //       title: Text('සිංහල'),
              //       leading: CircleAvatar(child: Text("සිං")),
              //     ),
              //     value: 'si'),
              // PopupMenuItem<String>(
              //     child: ListTile(
              //       contentPadding: EdgeInsets.all(0.0),
              //       title: Text('தமிழ்'),
              //       leading: CircleAvatar(child: Text("த")),
              //     ),
              //     value: 'ta'),
            ],
        onSelected: (v) => LocaleController.of(context).onLocaleChange(v),
      ),
    ];
  }

  Widget _buildAppBarFlexibleSpace(BuildContext context) {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.parallax,
      background: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("res/images/article-reader.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  theme.UIColors.primaryColor.withAlpha(0xBB),
                  BlendMode.srcATop,
                ),
              ),
            ),
            child: Center(
              child: Text(
                CustomLocalizationProvider.of(context)
                    .localization
                    .homePageCenterScreenText,
                textAlign: TextAlign.center,
                style: theme.UITextThemes().articleTopBarBackgroundText,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomCenter,
            child: Icon(
              FontAwesomeIcons.arrowDown,
              color: Colors.white,
            ),
            margin: EdgeInsets.only(bottom: 50.0),
          ),
        ],
      ),
    );
  }

  // Widget _buildIconButton(IconData icon, VoidCallback destinationCallBack) {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: IconButton(
  //       icon: Icon(icon),
  //       onPressed: destinationCallBack,
  //       color: Colors.white,
  //       splashColor: Colors.white,
  //     ),
  //   );
  // }

  Widget _buildChildControl(Widget child, BuildContext context) {
    return SizedBox(
      child: Center(child: child),
      height: MediaQuery.of(context).size.height - 200,
    );
  }
}
