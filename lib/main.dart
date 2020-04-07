import 'package:flutter/material.dart';

import 'package:clean_architecture_sample/di/app_builder.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CASample',
      home: AppBuilder.createArticleListScreen(),
    );
  }
}