import 'package:flutter/foundation.dart';

import 'package:clean_architecture_sample/entity/entity.dart';
import 'package:clean_architecture_sample/usecase/usecase.dart';

/// `Presenter` 側に公開する `SearchUseCase` のインターフェース
abstract class SearchUseCaseInput {
  void fetchArticles(String keyword);
  void fetchNextPageArticles();
  void openURL(String url);
}

/// `SearchUseCase` を参照する `Presenter` が準拠するインターフェース
abstract class SearchUseCaseOutput {
  void useCaseDidUpdateArticles(List<QiitaItem> articles);
  void useCaseIsLoading(bool isLoading);
  void useCaseDidRecieveError(Exception error);
}

class SearchUseCase implements SearchUseCaseInput {
  ArticlesRepositoryInterface _articlesRepository;
  URLLaunchRepositoryInterface _urlLaunchRepository;

  /// 取得完了した記事一覧.
  List<QiitaItem> _fetchedArticles = [];
  /// 取得完了したページのインデックス. ( 初期値は 1 )
  int _currentPage = 1;
  /// 検索したキーワード
  String _currentKeyword = '';
  /// 次のページを取得中かどうか. ( ScrollController のイベントは複数回走るため )
  bool _isLoadingNexPage = false;

  SearchUseCaseOutput output;

  SearchUseCase({
    @required ArticlesRepositoryInterface articlesRepository,
    @required URLLaunchRepositoryInterface urlLaunchRepository,
  }): assert(articlesRepository != null), 
      assert(urlLaunchRepository != null),
      this._articlesRepository = articlesRepository, 
      this._urlLaunchRepository = urlLaunchRepository;

  @override
  void fetchArticles(String keyword) {
    output?.useCaseIsLoading(true);
    _articlesRepository.searchArticles(keyword, _currentPage)
      .then((value) {
        _fetchedArticles = value.items;
        _currentKeyword = keyword;
        output?.useCaseDidUpdateArticles(_fetchedArticles);
        output?.useCaseIsLoading(false);
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

    _articlesRepository.searchArticles(_currentKeyword, _currentPage)
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