import 'package:flutter/foundation.dart';

import 'package:clean_architecture_sample/entity/entity.dart';
import 'package:clean_architecture_sample/usecase/usecase.dart';

// NOTE: 下位の Presenter に実装させるインターフェース
abstract class ArticlesUseCaseOutput {
  void useCaseDidUpdateArticles(List<QiitaItem> articles);
  void useCaseIsLoading(bool isLoading);
  void useCaseDidRecieveError(Exception error);
}

// NOTE: 下位の Presenter に公開するインターフェース
abstract class ArticlesUseCaseInput {
  void fetchArticles();
  void fetchNextPageArticles();
  void openURL(String url);
}

class ArticlesUseCase implements ArticlesUseCaseInput {
  final ArticlesRepositoryInterface _articlesRepository;
  final URLLaunchRepositoryInterface _urlLaunchRepository;

  /// 取得完了した記事一覧.
  List<QiitaItem> _fetchedArticles = [];
  /// 取得完了したページのインデックス. ( 初期値は 1 )
  int _currentPage = 1;
  /// 次のページを取得中かどうか. ( ScrollController のイベントは複数回走るため )
  bool _isLoadingNexPage = false;

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
    _articlesRepository.fetchArticles(_currentPage)
      .then((value) {
        _fetchedArticles = value.items;
        output?.useCaseIsLoading(false);
        output?.useCaseDidUpdateArticles(_fetchedArticles);
      })
      .catchError((error) {
        output?.useCaseIsLoading(false);
        output?.useCaseDidRecieveError(error);
      });
  }

  @override
  void fetchNextPageArticles() {
    // NOTE: 現在取得中かどうかを確認.
    if (_isLoadingNexPage) { return; }

    // NOTE: ロードの状態と取得したページを更新.
    _isLoadingNexPage = true;
    _currentPage += 1;

    _articlesRepository.fetchArticles(_currentPage)
      .then((value) {
        _isLoadingNexPage = false;
        _fetchedArticles.addAll(value.items);
        output?.useCaseDidUpdateArticles(_fetchedArticles);
      })
      .catchError((error) {
        _isLoadingNexPage = false;
        output?.useCaseDidRecieveError(error);
      });
  }

  @override
  void openURL(String url) {
    _urlLaunchRepository.launchInWebView(url)
      .catchError((error) {
        output?.useCaseDidRecieveError(error);
      });
  }
}