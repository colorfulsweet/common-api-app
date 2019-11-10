import 'package:flutter/material.dart';

import 'package:blog_api/pages/login.dart';
import 'package:blog_api/pages/home.dart';

void main() => runApp(BlogApi());

class BlogApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '博客api管理后台',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      routes: {
        'login' : (context) => Login(title: '登录'),
        'home' : (context) => Home(title: '首页')
      },
      initialRoute: 'login',
    );
  }
}



