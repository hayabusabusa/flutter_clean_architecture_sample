import 'package:flutter/material.dart';

import 'package:clean_architecture_sample/entity/entity.dart';
import 'package:clean_architecture_sample/framework_driver/ui/widget/widgets.dart';

class ArticleListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: 24,
        itemBuilder: (context, index) => ArticleItem(QiitaItem.stub()),
      ),
    );
  }
}