import 'package:url_launcher/url_launcher.dart';

import 'package:clean_architecture_sample/usecase/usecase.dart';

class URLLaunchRepository implements URLLaunchRepositoryInterface {
  @override
  Future<void> launchInWebView(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
      );
    } else {
      throw Exception('Could not launch $url');
    }
  }
}