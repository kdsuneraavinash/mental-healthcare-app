import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/bloc/book_bloc.dart';
import 'package:mental_healthcare_app/logic/books/book.dart';

class Books extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Books"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BookShelf(),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).accentColor,
        child: FlatButton.icon(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.phone),
          label: Text("Call & Buy"),
        ),
      ),
    );
  }
}

class BookShelf extends StatelessWidget {
  final BookBLoC bloc = BookBLoC();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Book>>(
      stream: bloc.booksStream,
      builder: (_, snapshot) => snapshot.hasData && snapshot.data != null
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) => Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Image.network(
                              snapshot.data[index].image,
                              height: 125,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0),
                              color: Colors.grey[500]
                            ),
                          ),
                        ),
                        height: 160,
                        width: 110,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline
                                    .copyWith(fontWeight: FontWeight.w800),
                                softWrap: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data[index].description,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
