import 'package:flutter/material.dart';

import 'package:clean_architecture_sample/router.dart';
// NOTE: 本当は Interface Adapter の Model とか
import 'package:clean_architecture_sample/entity/entity.dart';
import 'package:clean_architecture_sample/framework_driver/ui/widget/widgets.dart';
import 'package:clean_architecture_sample/interface_adapter/interface_adapter.dart';

class ArticleListScreen extends StatefulWidget implements ArticleListPresenterOutput {
  final ArticleListPresenterInput _presenter;

  ArticleListScreen({
    Key key,
    ArticleListPresenterInput presenter,
  }): this._presenter = presenter, 
      super(key: key);

  @override
  State<StatefulWidget> createState() => _ArticleListScreenState();

  @override
  Function(List<QiitaItem>) updateArticles;

  @override
  Function(bool) updateIsLoading;

  @override
  Function(String) recieveError;
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  final ScrollController _scrollController = ScrollController();

  List<QiitaItem> _ariticles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // NOTE: Listen scroll event.
    // PrimaryScrollController を有効にしたい場合: https://qiita.com/heavenosk/items/30e9769fcfde5f0fc096
    _scrollController.addListener(_scrollListener);
    // NOTE: on update articles.
    widget.updateArticles = (articles) {
      setState(() {
        _ariticles = articles;
      });
    };
    // NOTE: on update is loading.
    widget.updateIsLoading = (isLoading) {
      setState(() {
        _isLoading = isLoading;
      });
    };
    // NOTE: on recieve error
    widget.recieveError = (errorMessage) {
      print(errorMessage);
    };
    widget._presenter.onInitState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double position = _scrollController.offset / _scrollController.position.maxScrollExtent;
    if (position >= 1) {
      widget._presenter.onReachBottom();
    }
  }

  Widget _buildBody() {
    return _isLoading 
      // Indicator
      ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green[300]),
        )
      ) 
      // ListView
      : Scrollbar(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _ariticles.length,
            itemBuilder: (context, index) => ArticleItem(
              _ariticles[index],
              (item) { widget._presenter.onTapListItem(item); }
            ),
          ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qiita', style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w600),),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () {
              Navigator.of(context).pushNamed(RouteName.search);
            }
          )
        ],
      ),
      body: _buildBody(),
    );
  }
}