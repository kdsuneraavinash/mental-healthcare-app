import 'package:url_launcher/url_launcher.dart';

enum LaunchMethod { MAIL, CALL, MESSAGE }

class ContactHelper {
  /// * Launch in default app
  static void launchAction(dynamic value, LaunchMethod method) async {
    if (value == null) return;
    String url;

    switch (method) {
      case LaunchMethod.CALL:
        url = "tel:$value";
        break;
      case LaunchMethod.MESSAGE:
        url = "sms:$value";
        break;
      case LaunchMethod.MAIL:
        url = "mailto:$value";
        break;
    }

    launchUrl(url);
  }

  static void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      return;
    }
  }
}
