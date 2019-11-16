import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:blog_api/common/global.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  /// Scaffold组件的唯一标识
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  final Dio http = Dio();
  BaseState() {
    // 写入URL根路径
    http.options.baseUrl = Global.API_BASE_PATH;

    // 如果已登录就在请求头当中写入token
    if(Global.profile.token != null) {
      http.options.headers['token'] = Global.profile.token;
    }
  }
  set loading (bool loading) {
    setState(() {
      this._isLoading = loading;
    });
  }

  /// 是否正在加载
  get loading => this._isLoading;
}