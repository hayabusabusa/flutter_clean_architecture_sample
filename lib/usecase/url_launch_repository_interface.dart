// NOTE: 下位の Repository( Gateway ) に実装させるインターフェース.
abstract class URLLaunchRepositoryInterface {
  Future<void> launchInWebView(String url);
}