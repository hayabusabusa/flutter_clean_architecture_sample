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

// NOTE: 下位の Repository( Gateway ) に実装させるインターフェース
abstract class ArticlesRepositoryInterface {
  Future<List<QiitaItem>> fetchArticles();
}

class ArticlesUseCase implements ArticlesUseCaseInput {
  final ArticlesRepositoryInterface _articlesRepository;

  // NOTE: Presenter を後から指定する.
  // UseCase は Presenter が生成されていなくてもオブジェクト化できるようにするため.
  ArticlesUseCaseOutput output;

  ArticlesUseCase(
    this._articlesRepository,
  ): assert(_articlesRepository != null);

  @override
  void fetchArticles() {
    _articlesRepository.fetchArticles()
      .then((value) {
        output.useCaseDidUpdateArticles(value);
      })
      .catchError((error) {
        output.useCaseDidRecieveError(error);
      });
  }
}