import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  /// Scaffold组件的唯一标识
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  set loading (bool loading) {
    setState(() {
      this.loading = loading;
      if(loading) {
        Function.apply(loadCallback, loadCallbackArgs);
      }
    });
  }

  /// 是否正在加载
  get loading => this.loading;

  List loadCallbackArgs = [];

  /// 加载完成后需要执行的回调函数
  void loadCallback(List argument) { }
}