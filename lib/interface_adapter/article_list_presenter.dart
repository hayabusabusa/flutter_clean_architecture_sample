// NOTE: TEST
import 'package:clean_architecture_sample/entity/entity.dart';
import 'package:clean_architecture_sample/usecase/usecase.dart';

// NOTE: View 側に実装させるインターフェース
abstract class ArticleListPresenterOutput {
  Function(List<QiitaItem>) updateArticles;
  Function(bool) updateIsLoading;
}

// NOTE: View 側に公開するインターフェース
abstract class ArticleListPresenterInput {
  void onInitState();
}

// NOTE: DIP より、上位レイヤーの抽象( UseCase の Output のインターフェース )をここで実装する
class ArticleListPresenter implements ArticleListPresenterInput, ArticlesUseCaseOutput {
  final ArticlesUseCaseInput _useCase;
  final ArticleListPresenterOutput _output;

  ArticleListPresenter(
    this._output,
    this._useCase,
  ): assert(_output != null,
            _useCase != null); 

  @override
  void onInitState() {
    _useCase.fetchArticles();
  }

  // MARK: UseCaes Output

  @override
  void useCaseDidUpdateArticles(List<QiitaItem> articles) {
    _output.updateArticles(articles);
  }

  @override
  void useCaseIsLoading(bool isLoading) {
    _output.updateIsLoading(isLoading);
  }

  @override
  void useCaseDidRecieveError(Error error) {
    // TODO: Show error
  }
}