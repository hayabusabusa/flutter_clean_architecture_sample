import 'package:flutter/material.dart';

// NOTE: 本当は Interface Adapter の Model とか
import 'package:clean_architecture_sample/entity/entity.dart';
import 'package:clean_architecture_sample/framework_driver/ui/widget/widgets.dart';

// NOTE: Test
import 'package:clean_architecture_sample/interface_adapter/interface_adapter.dart';

class ArticleListScreen extends StatefulWidget implements ArticleListPresenterOutput {
  ArticleListPresenterInput _presenter;

  void inject(ArticleListPresenterInput presenter) {
    _presenter = presenter;
  }

  @override
  State<StatefulWidget> createState() => _ArticleListScreenState();

  @override
  Function(List<QiitaItem>) updateArticles;
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  List<QiitaItem> _ariticles = [];

  @override
  void initState() {
    super.initState();
    widget.updateArticles = (articles) {
      setState(() {
        _ariticles = articles;
      });
    };
    widget._presenter.onInitState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qiita', style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w600),),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _ariticles.length,
        itemBuilder: (context, index) => ArticleItem(_ariticles[index]),
      ),
    );
  }
}