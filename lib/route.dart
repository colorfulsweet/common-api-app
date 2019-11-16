import 'package:flutter/material.dart';

import 'package:blog_api/pages/login.dart';
import 'package:blog_api/pages/home.dart';
import 'package:blog_api/pages/child/photo_wall.dart';
import 'package:blog_api/pages/child/one_chat.dart';

/// 路由表
final Map<String, WidgetBuilder> routeTable = {
  'login' : (context) => Login(title: '博客API管理后台'),
  'home' : (context) => Home(title: '首页'),
  'photoWall' : (context) => PhotoWall(title: '照片墙'),
  'oneChat' : (context) => OneChat(title: '一言'),
};