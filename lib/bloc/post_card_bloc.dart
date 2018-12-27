import 'dart:async';
import 'package:http/http.dart' as HTTP;
import 'dart:convert' as JSON;

import 'package:rxdart/subjects.dart';

const String MEDIA_URL =
    "http://kdsuneraavinash-dev.000webhostapp.com/wp-json/wp/v2/media";

class PostCardBLoC {
  final int mediaId;

  // Out Streams
  StreamController<String> _mediaLinkStreamController = BehaviorSubject();
  Stream<String> get mediaLinkStream => _mediaLinkStreamController.stream;

  PostCardBLoC(this.mediaId) {
    _retrieveMediaLink();
  }

  void _retrieveMediaLink() async {
    String postUrl = "$MEDIA_URL?include=$mediaId";

    HTTP.Response response = await HTTP.get(postUrl);
    List postJson = JSON.jsonDecode(response.body);
    _mediaLinkStreamController.add(postJson[0]["source_url"]);
  }

  void dispose() {
    _mediaLinkStreamController.close();
  }
}
