import 'package:blog_api/models/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blog_api/pages/login.dart';
import 'package:blog_api/pages/home.dart';
import 'package:blog_api/common/global.dart';
import 'package:blog_api/common/common_notifier.dart';

void main() => Global.init().then((e) => runApp(BlogApi()));

class BlogApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InheritedProvider<CommonNotifier>(
      value: CommonNotifier(),
      child: MaterialApp(
        title: '博客api管理后台',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        routes: {
          'login' : (context) => Login(title: '登录'),
          'home' : (context) => Home(title: '首页')
        },
        initialRoute: 'login',
      ),
    );
  }
}



