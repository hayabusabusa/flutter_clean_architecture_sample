import 'package:flutter/material.dart';

import 'package:clean_architecture_sample/entity/entity.dart';
import 'package:clean_architecture_sample/framework_driver/ui/widget/widgets.dart';

// NOTE: Test
import 'package:clean_architecture_sample/framework_driver/network/network.dart';

class ArticleListScreen extends StatefulWidget {
  final APIClient apiClient = APIClient();

  @override
  State<StatefulWidget> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<QiitaItem>>(
        future: widget.apiClient.fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => ArticleItem(snapshot.data[index]),
            );
          } else {
            return Center(
              child: Text('Empty.'),
            );
          }
        },
      ),
    );
  }
}