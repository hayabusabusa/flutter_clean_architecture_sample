import 'package:clean_architecture_sample/entity/entity.dart';
import 'package:clean_architecture_sample/usecase/usecase.dart';
import 'package:clean_architecture_sample/framework_driver/network/network.dart';

class ArticlesRepository implements ArticlesRepositoryInterface {
  // NOTE: あくまでインターフェースに依存するため、実際の実装には依存しない.
  // そのため http ではなく他のパッケージで実装しても、インターフェースに沿っていれば変更も可能.
  APIClientInterface _apiClient;

  ArticlesRepository(
    this._apiClient
  ): assert(_apiClient != null);

  @override
  Future<QiitaAllItems> fetchArticles(int page) async {
    return _apiClient.fetchAllItems(page);
  }
}