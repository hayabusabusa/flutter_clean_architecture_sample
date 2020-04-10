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
    // Repositories
    final articlesRepository = ArticlesRepository(_apiClient);
    final urlLaunchRepository = URLLaunchRepository();
    // UseCase
    final useCase = ArticlesUseCase(
      articlesRepository: articlesRepository,
      urlLaunchRepository: urlLaunchRepository
    );
    // Presenter
    final presenter = ArticleListPresenter(useCase);
    // View
    final view = ArticleListScreen(presenter: presenter,);

    // NOTE: UseCase の Output に Presenter を指定
    useCase.output = presenter;

    // NOTE: Presenter の Output に View を指定
    presenter.output = view;

    return view;
  }

  SearchScreen createSearchScreen() {
    // Repositories
    final articlesRepository = ArticlesRepository(_apiClient);
    final urlLaunchRepository = URLLaunchRepository();
    // UseCase
    final useCase = SearchUseCase(
      articlesRepository: articlesRepository, 
      urlLaunchRepository: urlLaunchRepository,
    );
    // Presenter
    final presenter = SearchPresenter(useCase);
    // View
    final view = SearchScreen(presenter: presenter,);

    useCase.output = presenter;
    presenter.output = view;

    return view;
  }
}