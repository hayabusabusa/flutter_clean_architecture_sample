import 'package:clean_architecture_sample/usecase/usecase.dart';
import 'package:clean_architecture_sample/interface_adapter/interface_adapter.dart';
import 'package:clean_architecture_sample/framework_driver/ui/screens.dart';
import 'package:clean_architecture_sample/framework_driver/network/network.dart';

class AppBuilder {
  final APIClientInterface _apiClient;

  AppBuilder(
    this._apiClient,
  ): assert(_apiClient != null);

  static ArticleListScreen createArticleListScreen() {
    final view = ArticleListScreen();
    //final useCase = ArticlesUseCase();
    final presenter = ArticleListPresenter(view);

    view.inject(presenter);

    return view;
  }
}