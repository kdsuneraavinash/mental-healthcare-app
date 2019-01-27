import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/bloc/post_card_bloc.dart';
import 'package:mental_healthcare_app/logic/articles/post.dart';
import 'package:mental_healthcare_app/ui/articles/article_view.dart';
import 'package:mental_healthcare_app/ui/transition_maker.dart';
import 'package:intl/intl.dart';

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
                      child: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                              imageUrl: snapshot.data,
                              fit: BoxFit.cover,
                              height: imageHeight,
                              width: MediaQuery.of(context).size.width),
                          Positioned(
                            right: 16.0,
                            top: 16.0,
                            child: Opacity(
                              opacity: 0.5,
                              child: CircleAvatar(
                                child: Text(
                                  "En",
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                  padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 10.0),
                  child: Text(
                    (DateFormat("'Posted' dd, MMMM, yyyy")
                            .format(DateTime.parse(post.date)))
                        .toString()
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    post.title,
                    style: Theme.of(context).textTheme.headline.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 32.0,
                          letterSpacing: 2.0,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: Text(
                    post.excerpt,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Divider(color: Colors.black),
                MaterialButton(
                  onPressed: () => TransitionMaker.slideTransition(
                        destinationPageCall: () =>
                            ArticleView(post.title, post.link),
                      )..start(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("READ",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 3.0)),
                        Icon(FontAwesomeIcons.arrowRight)
                      ],
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
