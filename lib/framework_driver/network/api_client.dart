import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:clean_architecture_sample/secret.dart';
// NOTE: Framework and Driver から Entity への依存は順方向
// 層を跨いだ依存は厳密にはダメなので、厳しくするならレスポンスを直で流したりするといいかもしれない.
import 'package:clean_architecture_sample/entity/entity.dart';

abstract class APIClientInterface {
  Future<QiitaAllItems> fetchAllItems(int page);
}

class APIClient implements APIClientInterface {
  static const String baseURL = 'https://qiita.com/api/v2';
  static const String accessToken = 'Bearer ' + qiitaAccessToken;

  final http.Client httpClient = http.Client();

  @override
  Future<QiitaAllItems> fetchAllItems(int page) async {
    final url = baseURL + '/items' + '?page=$page';
    final headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: accessToken,
    };
    final response = await httpClient.get(url, headers: headers);
    final totalCount = response.headers['Total-Count'] as int;

    if (response.statusCode == 200) {
      final List<dynamic> array = json.decode(response.body);
      final List<QiitaItem> items = array.map((i) => QiitaItem.fromJson(i)).toList();
      return QiitaAllItems(items: items, totalCount: totalCount);
    } else {
      throw Exception('Failed to GET /items. (code=${response.statusCode})');
    }
  }
}