import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:clean_architecture_sample/secret.dart';
// NOTE: Framework and Driver から Entity への依存は順方向
// 層を跨いだ依存は厳密にはダメなので、厳しくするならレスポンスを直で流したりするといいかもしれない.
import 'package:clean_architecture_sample/entity/entity.dart';

abstract class APIClientInterface {
  Future<List<QiitaItem>> fetchItems();
}

class APIClient implements APIClientInterface {
  static const String baseURL = 'https://qiita.com/api/v2';
  static const String accessToken = 'Bearer ' + qiitaAccessToken;

  final http.Client httpClient = http.Client();

  @override
  Future<List<QiitaItem>> fetchItems() async {
    final url = baseURL + '/items';
    final headers = {
      "Content-Type": "application/json",
      "Authorization": accessToken,
    };
    final response = await httpClient.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> array = json.decode(response.body);
      return array.map((i) => QiitaItem.fromJson(i)).toList();
    } else {
      throw Exception('Failed to GET /items. (code=${response.statusCode})');
    }
  }
}