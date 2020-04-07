import 'package:clean_architecture_sample/usecase/usecase.dart';
import 'package:clean_architecture_sample/interface_adapter/interface_adapter.dart';
import 'package:clean_architecture_sample/framework_driver/ui/screens.dart';
import 'package:clean_architecture_sample/framework_driver/network/network.dart';

class AppBuilder {
  final APIClientInterface _apiClient;

  AppBuilder(
    this._apiClient,
  ): assert(_apiClient != null);

  ArticleListScreen createArticleListScreen() {
    final view = ArticleListScreen();
    final repository = ArticlesRepository(_apiClient);
    final useCase = ArticlesUseCase(repository);
    final presenter = ArticleListPresenter(view, useCase);

    // NOTE: UseCase の Output に Presenter を指定
    useCase.output = presenter;

    // NOTE: View の Output に Presenter を指定
    view.inject(presenter);

    return view;
  }
}