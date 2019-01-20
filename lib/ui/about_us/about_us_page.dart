import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mental_healthcare_app/bloc/about_us_bloc.dart';
import 'package:mental_healthcare_app/localization/localization.dart';
import 'package:mental_healthcare_app/logic/about_us/about_person.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;

class AboutUsPage extends StatelessWidget {
  AboutUsPage() : this.bloc = AboutUsBLoC();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AboutPerson>>(
      stream: bloc.aboutPersonStream,
      builder: (_, snapshot) => snapshot.hasData
          ? DefaultTabController(
              length: snapshot.data.length,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(CustomLocalizationProvider.of(context)
                      .localization
                      .consultantsAppBarTitle),
                  backgroundColor: theme.UIColors.primaryColor,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: snapshot.data
                        .map(
                          (v) => Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  v.title.length > 11
                                      ? v.title.substring(0, 11) + "..."
                                      : v.title,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                        )
                        .toList(),
                  ),
                ),
                body: TabBarView(
                  children:
                      snapshot.data.map((v) => AboutUsPageContent(v)).toList(),
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(CustomLocalizationProvider.of(context)
                    .localization
                    .consultantsAppBarTitle),
                backgroundColor: theme.UIColors.primaryColor,
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  final AboutUsBLoC bloc;
}

class AboutUsPageContent extends StatelessWidget {
  const AboutUsPageContent(this.aboutPerson);

  Widget build(BuildContext context) {
    return ListView(
      children: _buildInfoList(context),
    );
  }

  List<Widget> _buildInfoList(BuildContext context) {
    List<Widget> column = [
      Container(height: 25.0, color: theme.UIColors.primaryColor),
      PersonDetailsPageHeader(photoUrl: this.aboutPerson.photo),
    ];

    _addToColumn(column, "Name", this.aboutPerson.name, Icons.person);
    _addToColumn(column, "Title", this.aboutPerson.title, Icons.work);
    _addToColumn(column, "Email", this.aboutPerson.url, Icons.email);

    column.add(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child:
                Text("Description", style: Theme.of(context).textTheme.subhead),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              this.aboutPerson.description,
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );

    return column;
  }

  void _addToColumn(
      List<Widget> column, String title, dynamic value, IconData icon) {
    if (value != null) {
      column.add(
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(value),
        ),
      );
    }
  }

  final AboutPerson aboutPerson;
}

class PersonDetailsPageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: theme.UIColors.primaryColor,
          height: 180.0,
        ),
        _buildHeaderImage(context),
      ],
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 60.0, left: 50.0, right: 50.0),
            child: Divider(
              color: Colors.white,
            ),
          ),
          Center(
              child: Stack(
            children: <Widget>[
              ClipOval(
                child: Container(
                  width: 160.0,
                  height: 160.0,
                  color: Colors.black,
                ),
                clipBehavior: Clip.antiAlias,
              ),
              ClipOval(
                child: SizedBox(
                  width: 160.0,
                  height: 160.0,
                  child: CachedNetworkImage(
                    placeholder: Center(
                      child: CircularProgressIndicator(),
                    ),
                    imageUrl: photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
              ),
            ],
          )),
        ],
      ),
    );
  }

  PersonDetailsPageHeader({@required this.photoUrl});
  final String photoUrl;
}
