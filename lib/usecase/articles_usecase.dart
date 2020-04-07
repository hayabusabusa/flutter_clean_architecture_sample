import 'package:clean_architecture_sample/entity/entity.dart';

// NOTE: 下位の Presenter に実装させるインターフェース
abstract class ArticlesUseCaseOutput {
  void useCaseDidUpdateArticles(List<QiitaItem> articles);
  void useCaseDidRecieveError(Error error);
}

// NOTE: 下位の Presenter に公開するインターフェース
abstract class ArticlesUseCaseInput {
  void fetchArticles();
}

class ArticlesUseCase implements ArticlesUseCaseInput {
  @override
  void fetchArticles() {
    
  }
}