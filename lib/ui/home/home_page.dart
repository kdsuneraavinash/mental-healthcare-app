import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/bloc/featured_post_bloc.dart';
import 'package:mental_healthcare_app/logic/articles/featured_post.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:mental_healthcare_app/ui/articles/category_view.dart';
import 'package:mental_healthcare_app/ui/articles/post_card.dart';
import 'package:mental_healthcare_app/ui/clinic_locations/clinic_location_map.dart';
import 'package:mental_healthcare_app/ui/doc_list/doc_list_page.dart';
import 'package:mental_healthcare_app/ui/transition_maker.dart';

class HomePageContent extends StatelessWidget {
  final FeaturedPostBLoC bloc;

  HomePageContent() : bloc = FeaturedPostBLoC();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
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
                      return CategoryView.buildSectionHeader("Recent Articles");
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
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      child: SliverAppBar(
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/article-reader.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      theme.UIColors.primaryColor.withAlpha(0xBB),
                      BlendMode.srcATop,
                    ),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Welcome to Sahanaya App.\n"
                            "An information center for mental health issues.",
                        textAlign: TextAlign.center,
                        style: theme.UITextThemes().articleTopBarBackgroundText,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildIconButton(
                            FontAwesomeIcons.newspaper,
                            () => TransitionMaker.slideTransition(
                                  destinationPageCall: () => CategoryView(),
                                )..start(context),
                          ),
                          _buildIconButton(
                            FontAwesomeIcons.handsHelping,
                            () => TransitionMaker.slideTransition(
                                  destinationPageCall: () => DocListPage(),
                                )..start(context),
                          ),
                          _buildIconButton(
                            FontAwesomeIcons.map,
                            () => TransitionMaker.slideTransition(
                                  destinationPageCall: () =>
                                      ClinicLocationMap(),
                                )..start(context),
                          )
                        ],
                      ),
                    ],
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
                margin: EdgeInsets.only(bottom: 100.0),
              ),
            ],
          ),
        ),
        expandedHeight: MediaQuery.of(context).size.height,
        backgroundColor: theme.UIColors.primaryColor,
        pinned: false,
        floating: false,
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback destinationCallBack) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IconButton(
        icon: Icon(icon),
        onPressed: destinationCallBack,
        color: Colors.white,
        splashColor: Colors.white,
      ),
    );
  }

  Widget _buildChildControl(Widget child, BuildContext context) {
    return SizedBox(
      child: Center(child: child),
      height: MediaQuery.of(context).size.height - 200,
    );
  }
}
