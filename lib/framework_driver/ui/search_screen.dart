import 'package:flutter/material.dart';

import 'package:clean_architecture_sample/framework_driver/ui/widget/widgets.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RoundedTextField(hintText: 'キーワードを入力',),
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
    );
  }
}