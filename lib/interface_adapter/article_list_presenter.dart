// NOTE: TEST
import 'package:clean_architecture_sample/entity/entity.dart';
import 'package:clean_architecture_sample/usecase/usecase.dart';
import 'package:clean_architecture_sample/framework_driver/network/network.dart';

// NOTE: View 側に実装させるインターフェース
abstract class ArticleListPresenterOutput {
  Function(List<QiitaItem>) updateArticles;
}

// NOTE: View 側に公開するインターフェース
abstract class ArticleListPresenterInput {
  void onInitState();
}

// NOTE: DIP より、上位レイヤーの抽象( UseCase の Output のインターフェース )をここで実装する
class ArticleListPresenter implements ArticleListPresenterInput, ArticlesUseCaseOutput {
  final APIClientInterface _apiClinet = APIClient();
  final ArticleListPresenterOutput _output;

  ArticleListPresenter(
    this._output,
  ): assert(_output != null); 

  @override
  void onInitState() {
    _apiClinet.fetchItems()
      .then((value) {
        _output.updateArticles(value);
      });
  }

  // MARK: UseCaes Output

  @override
  void useCaseDidUpdateArticles(List<QiitaItem> articles) {
    _output.updateArticles(articles);
  }

  @override
  void useCaseDidRecieveError(Error error) {
    // TODO: Show error
  }
}