import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/bloc/post_card_bloc.dart';
import 'package:mental_healthcare_app/logic/articles/post.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:mental_healthcare_app/ui/articles/article_view.dart';
import 'package:mental_healthcare_app/ui/transition_maker.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final PostCardBLoC bloc;

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).size.width / (16 / 9);
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4.0)],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: imageHeight,
            child: StreamBuilder<String>(
              stream: bloc.mediaLinkStream,
              builder: (_, snapshot) => snapshot.hasData
                  ? ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                          imageUrl: snapshot.data,
                          fit: BoxFit.cover,
                          height: imageHeight,
                          width: MediaQuery.of(context).size.width),
                    )
                  : SizedBox(
                      height: imageHeight,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 0.0),
                  child: Text(
                    post.slug,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: theme.UIColors.secondaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    post.title,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(post.excerpt),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton.icon(
                    color: theme.UIColors.accentColor,
                    onPressed: () => TransitionMaker.fadeTransition(
                          destinationPageCall: () =>
                              ArticleView(post.title, post.link),
                        )..start(context),
                    icon: Icon(
                      FontAwesomeIcons.arrowRight,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Read",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PostCard(this.post) : bloc = PostCardBLoC(post.featuredMediaId);
}
