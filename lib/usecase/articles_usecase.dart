import 'package:clean_architecture_sample/entity/entity.dart';
import 'package:flutter/material.dart';

// NOTE: 下位の Presenter に実装させるインターフェース
abstract class ArticlesUseCaseOutput {
  void useCaseDidUpdateArticles(List<QiitaItem> articles);
  void useCaseIsLoading(bool isLoading);
  void useCaseDidRecieveError(Error error);
}

// NOTE: 下位の Presenter に公開するインターフェース
abstract class ArticlesUseCaseInput {
  void fetchArticles();
  void openURL(String url);
}

// NOTE: 下位の Repository( Gateway ) に実装させるインターフェース.
abstract class ArticlesRepositoryInterface {
  Future<List<QiitaItem>> fetchArticles();
}

// NOTE: 下位の Repository( Gateway ) に実装させるインターフェース.
abstract class URLLaunchRepositoryInterface {
  Future<void> launchInWebView(String url);
}

class ArticlesUseCase implements ArticlesUseCaseInput {
  final ArticlesRepositoryInterface _articlesRepository;
  final URLLaunchRepositoryInterface _urlLaunchRepository;

  // NOTE: Presenter を後から指定する.
  // UseCase は Presenter が生成されていなくても(下位に依存しない)オブジェクト化できるようにするため.
  ArticlesUseCaseOutput output;

  ArticlesUseCase({
    @required ArticlesRepositoryInterface articlesRepository,
    @required URLLaunchRepositoryInterface urlLaunchRepository,
  }): _articlesRepository = articlesRepository,
      _urlLaunchRepository = urlLaunchRepository,
      assert(articlesRepository != null),
      assert(urlLaunchRepository != null);

  @override
  void fetchArticles() {
    output?.useCaseIsLoading(true);
    _articlesRepository.fetchArticles()
      .then((value) {
        output?.useCaseIsLoading(false);
        output?.useCaseDidUpdateArticles(value);
      })
      .catchError((error) {
        output?.useCaseIsLoading(false);
        output?.useCaseDidRecieveError(error);
      });
  }

  @override
  void openURL(String url) {
    _urlLaunchRepository.launchInWebView(url)
      .catchError((error) {
        output.useCaseDidRecieveError(error);
      });
  }
}