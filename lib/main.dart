import 'package:flutter/material.dart';

import 'package:clean_architecture_sample/framework_driver/network/network.dart';
import 'package:clean_architecture_sample/di/app_builder.dart';

void main() {
  final apiClient = APIClient();
  final builder = AppBuilder(apiClient);
  
  runApp(App(builder));
}

class App extends StatelessWidget {
  final AppBuilder _builder;

  App(
    this._builder
  ): assert(_builder != null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CASample',
      home: _builder.createArticleListScreen(),
    );
  }
}