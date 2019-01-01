import 'package:flutter/material.dart';
import 'package:mental_healthcare_app/localization/localization.dart';
import 'package:mental_healthcare_app/localization/si_localization.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:mental_healthcare_app/ui/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // The root of application.
  @override
  Widget build(BuildContext context) {
    return LocaleController();
  }
}

class LocaleController extends StatefulWidget {
  @override
  _LocaleControllerState createState() => _LocaleControllerState();

  static _LocaleControllerState of(BuildContext context) {
    return context.ancestorStateOfType(TypeMatcher<_LocaleControllerState>());
  }
}

class _LocaleControllerState extends State<LocaleController> {
  @override
  Widget build(BuildContext context) {
    return CustomLocalizationProvider(
      child: Builder(
        builder: (insideContext) => MaterialApp(
            locale: Locale(
                CustomLocalizationProvider.of(insideContext)?.locale ?? 'en'),
            localizationsDelegates: [
              DefaultMaterialLocalizations.delegate,
              MaterialLocalizationSi.delegate
            ],
            supportedLocales: [Locale('en'), Locale('si')],
            title: CustomLocalizationProvider.of(insideContext)
                .localization
                .app_name,
            theme: theme.UITheme.build(),
            home: HomePage()),
      ),
      locale: locale,
    );
  }

  String locale;

  @override
  void initState() {
    locale = 'en';
    super.initState();
  }

  onLocaleChange(String l) {
    setState(() {
      locale = l;
    });
  }
}
