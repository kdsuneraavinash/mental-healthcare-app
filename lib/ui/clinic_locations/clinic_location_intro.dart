import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:mental_healthcare_app/ui/clinic_locations/clinic_location_map.dart';
import 'package:mental_healthcare_app/ui/transition_maker.dart';
import 'package:mental_healthcare_app/ui/trivia_qa/trivia_qa.dart';

import 'package:flutter/material.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:mental_healthcare_app/ui/text_intro_screen.dart';
import 'package:mental_healthcare_app/ui/trivia_qa/trivia_qa.dart';

class ClinicLocationIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextIntroScreen(
      appBarColor: theme.UIColors.clinicColor,
      appBarTitleText: "Clinic Locations Start Page",
      fabColor: theme.UIColors.clinicFabColor,
      fabIconColor: theme.UIColors.clinicFabIconColor,
      pageCall: () => ClinicLocationMap(),
      faqs: <FAQBlock>[
        FAQBlock(
            "What is this Feature?",
            "This is a Map built to allow user to "
            "find nearby clinics easily. "),
        FAQBlock(
            "Any additional Permissions?",
            "Yes. We do require location access in order to"
            " view your location in the map."),
        FAQBlock(
            "What are the symbols?",
            "Blue dot means you. Red markers denote clinic locations"
            ". Tap on a Red marker to see the address, time duration"
            " and some description. You can use the map button in the "
            "bottom right corner to view routes, etc... "
            "using Google Maps App"),
        FAQBlock(
            "Is that all?",
            "Yes, for now. But we are hoping to add more "
            "features in future.")
      ],
    );
  }
}
