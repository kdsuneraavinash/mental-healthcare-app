import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/ui/about_us/about_us_page.dart';
import 'package:mental_healthcare_app/ui/articles/category_view.dart';
import 'package:mental_healthcare_app/ui/books/books.dart';
import 'package:mental_healthcare_app/ui/location_map/location_map.dart';
import 'package:mental_healthcare_app/ui/home/home_page.dart';
import 'package:mental_healthcare_app/ui/transition_maker.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageContent(),
      appBar: _buildAppBar(context),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          physics: ClampingScrollPhysics(),
          children: [buildDrawerHeading(context)] + buildDrawerActions(context),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      actions: _buildAppBarActions(context),
      backgroundColor: Theme.of(context).primaryColor,
      title: Text("Sahanaya App"),
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
              child: Text("English", style: TextStyle(color: Colors.white)),
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
            ],
      ),
    ];
  }

  Widget buildDrawerHeading(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      accountEmail: Text("https://www.ncmh.lk"),
      accountName: Text("National Council for Mental Health"),
      currentAccountPicture: CircleAvatar(
        child: Icon(FontAwesomeIcons.fly),
      ),
    );
  }

  List<Widget> buildDrawerActions(BuildContext context) {
    return [
      _buildDrawerListTile(
        title: "Read Articles",
        subtitle: "Spread Awareness",
        icon: FontAwesomeIcons.newspaper,
        destinationCallBack: () => TransitionMaker.slideTransition(
              destinationPageCall: () => CategoryView(),
            )..start(context),
        context: context,
      ),
      _buildDrawerListTile(
        title: "About Us",
        subtitle: "Know about NCMH",
        icon: FontAwesomeIcons.handsHelping,
        destinationCallBack: () => TransitionMaker.slideTransition(
              destinationPageCall: () => AboutUsPage(),
            )..start(context),
        context: context,
      ),
      _buildDrawerListTile(
        title: "Our Locations",
        subtitle: "View our locations and contacts",
        icon: FontAwesomeIcons.map,
        destinationCallBack: () => TransitionMaker.slideTransition(
              destinationPageCall: () => LocationMap(),
            )..start(context),
        context: context,
      ),
      _buildDrawerListTile(
        title: "Our Books",
        subtitle: "Read mental health books",
        icon: FontAwesomeIcons.book,
        destinationCallBack: () => TransitionMaker.slideTransition(
              destinationPageCall: () => Books(),
            )..start(context),
        context: context,
      ),
    ];
  }

  Widget _buildDrawerListTile({
    @required String title,
    @required String subtitle,
    @required IconData icon,
    Color iconColor,
    VoidCallback destinationCallBack,
    BuildContext context,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(
        icon,
        color: iconColor ?? Theme.of(context).accentColor,
      ),
      onTap: destinationCallBack,
    );
  }
}
