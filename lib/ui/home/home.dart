import 'package:flutter/material.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/ui/articles/category_view.dart';
import 'package:mental_healthcare_app/ui/clinic_locations/clinic_location_map.dart';
import 'package:mental_healthcare_app/ui/doc_list/doc_list_page.dart';
import 'package:mental_healthcare_app/ui/home/home_page.dart';
import 'package:mental_healthcare_app/ui/transition_maker.dart';
import 'package:mental_healthcare_app/ui/trivia_qa/trivia_start.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sanasuma App"),
      ),
      body: HomePageContent(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          physics: ClampingScrollPhysics(),
          children: [_buildDrawerHeading()] + _buildDrawerActions(context),
        ),
      ),
    );
  }

  Widget _buildDrawerHeading() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/drawer-header.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              theme.UIColors.primaryColor.withAlpha(0xCC),
              BlendMode.srcATop,
            ),
          ),
          color: theme.UIColors.primaryColor),
      accountEmail: Text("user@sahanaya.com"),
      accountName: Text("User"),
      currentAccountPicture: CircleAvatar(
        child: Icon(FontAwesomeIcons.user),
      ),
    );
  }

  List<Widget> _buildDrawerActions(BuildContext context) {
    return [
      _buildDrawerListTile(
        title: "Read Articles",
        subtitle: "Spread Awareness",
        icon: FontAwesomeIcons.newspaper,
        destinationCallBack: () => TransitionMaker.slideTransition(
              destinationPageCall: () => CategoryView(),
            )..start(context),
      ),
      _buildDrawerListTile(
        title: "Consultants & Psychiatrists",
        subtitle: "Contact Consultants",
        icon: FontAwesomeIcons.handsHelping,
        destinationCallBack: () => TransitionMaker.slideTransition(
              destinationPageCall: () => DocListPage(),
            )..start(context),
      ),
      _buildDrawerListTile(
        title: "Clinic Locations",
        subtitle: "View mental health clinics",
        icon: FontAwesomeIcons.map,
        destinationCallBack: () => TransitionMaker.slideTransition(
              destinationPageCall: () => ClinicLocationMap(),
            )..start(context),
      ),
      _buildDrawerListTile(
        title: "Trivia Questions",
        subtitle: "Test your knowledge",
        icon: FontAwesomeIcons.question,
        destinationCallBack: () => TransitionMaker.slideTransition(
              destinationPageCall: () => TriviaStartPage(),
            )..start(context),
      ),
      Divider(),
      _buildDrawerListTile(
        title: "Settings",
        subtitle: "Adjust settings",
        icon: FontAwesomeIcons.cogs,
        iconColor: Colors.black87,
      ),
    ];
  }

  Widget _buildDrawerListTile({
    @required String title,
    @required String subtitle,
    @required IconData icon,
    Color iconColor,
    VoidCallback destinationCallBack,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(
        icon,
        color: iconColor ?? theme.UIColors.accentColor,
      ),
      onTap: destinationCallBack,
    );
  }
}
