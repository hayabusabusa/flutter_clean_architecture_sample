import 'package:clean_architecture_sample/entity/entity.dart';
import 'package:clean_architecture_sample/usecase/usecase.dart';

/// `View` 側に公開する `SearchPresenter` のInputインターフェース
abstract class SearchPresenterInput {
  void onTextEditingComplete(String text);
  void onTapListItem(QiitaItem item);
  void onReachBottom();
}

/// `View` 側に実装させる `SearchPresenter` のOutputインターフェース
abstract class SearchPresenterOutput {
  Function(List<QiitaItem>) updateArticles;
  Function(bool) updateIsLoading;
  Function(String) recieveError;
}

class SearchPresenter implements SearchPresenterInput, SearchUseCaseOutput {
  SearchUseCaseInput _useCase;

  SearchPresenterOutput output;

  SearchPresenter(
    SearchUseCaseInput useCase,
  ): assert(useCase != null),
     this._useCase = useCase;

  @override
  void onTextEditingComplete(String text) {
    _useCase.fetchArticles(text);
  }

  @override
  void onTapListItem(QiitaItem item) {
    _useCase.openURL(item.url);
  }

  @override
  void onReachBottom() {
    _useCase.fetchNextPageArticles();
  }

  // MARK: UseCase Output

  @override
  void useCaseDidUpdateArticles(List<QiitaItem> articles) {
    output.updateArticles(articles);
  }

  @override
  void useCaseIsLoading(bool isLoading) {
    output.updateIsLoading(isLoading);
  }

  @override
  void useCaseDidRecieveError(Exception error) {
    output.recieveError(error.toString());
  }
}