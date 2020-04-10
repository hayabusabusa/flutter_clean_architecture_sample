import 'package:clean_architecture_sample/entity/entity.dart';

abstract class APIClientInterface {
  Future<QiitaAllItems> fetchAllItems(int page);
  Future<QiitaAllItems> searchAllItems(String keyword, int page);
}