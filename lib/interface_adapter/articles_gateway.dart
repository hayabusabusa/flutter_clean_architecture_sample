// NOTE: Framework and Driver への依存?
import 'package:clean_architecture_sample/framework_driver/network/network.dart';
// NOTE: 本当は Model などの View に表示する用のデータ
import 'package:clean_architecture_sample/entity/entity.dart';

abstract class ArticlesGatewayInout {
  Future<List<QiitaItem>> fetchArticles();
}

class ArticlesGateway extends ArticlesGatewayInout {
  final APIClient apiClient;

  ArticlesGateway(
    this.apiClient,
  );

  Future<List<QiitaItem>> fetchArticles() async {
    return await apiClient.fetchItems();
  }
}
