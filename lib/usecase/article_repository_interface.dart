import 'package:clean_architecture_sample/entity/entity.dart';

// UseCase 対 Repository は 1 対 N になるので
// 特定の UseCase でインターフェースを実装するのは避けるため専用のファイルを作成.

// NOTE: 下位の Repository( Gateway ) に実装させるインターフェース.
abstract class ArticlesRepositoryInterface {
  Future<QiitaAllItems> fetchArticles(int page);
}