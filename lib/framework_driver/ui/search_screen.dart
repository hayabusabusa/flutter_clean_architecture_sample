import 'package:clean_architecture_sample/entity/qiita_item.dart';
import 'package:flutter/material.dart';

import 'package:clean_architecture_sample/framework_driver/ui/widget/widgets.dart';
import 'package:clean_architecture_sample/interface_adapter/presenter/presenter.dart';

class SearchScreen extends StatefulWidget implements SearchPresenterOutput {
  final SearchPresenterInput _presenter;

  SearchScreen({
    Key key,
    SearchPresenterInput presenter,
  }): this._presenter = presenter,
      super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchScreenState();

  @override
  Function(String) recieveError;

  @override
  Function(List<QiitaItem>) updateArticles;

  @override
  Function(bool) updateIsLoading;
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _editingController = TextEditingController();

  List<QiitaItem> _ariticles = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // NOTE: Listen scroll event.
    // PrimaryScrollController を有効にしたい場合: https://qiita.com/heavenosk/items/30e9769fcfde5f0fc096
    _scrollController.addListener(_scrollListener);
    // NOTE: Listen text editing event

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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _editingController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double position = _scrollController.offset / _scrollController.position.maxScrollExtent;
    if (position >= 1) {
      widget._presenter?.onReachBottom();
    }
  }

  void _onEditingComplete() {
    widget._presenter.onTextEditingComplete(_editingController.text);
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
              (item) { widget._presenter?.onTapListItem(item); }
            ),
          ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RoundedTextField(
          hintText: 'キーワードを入力',
          onSubmited: (text) {
            widget._presenter.onTextEditingComplete(text); 
          },
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: () {
            Navigator.of(context).pop();
          }
        ),
      ),
      body: _buildBody(),
    );
  }
}