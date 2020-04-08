import 'package:url_launcher/url_launcher.dart';

abstract class URLLaunchRepositoryInterface {
  Future<void> launchInWebView(String url);
}

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