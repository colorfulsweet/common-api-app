import 'package:flutter/material.dart';

import 'package:blog_api/common/profile_change_notifier.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false, // 不显示返回按钮
      ),
      body: Text('这里是首页, 当前用户'+Provider.of<UserModel>(context).user.toJson().toString()),
    );
  }
}