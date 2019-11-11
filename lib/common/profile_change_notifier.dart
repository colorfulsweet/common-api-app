import 'package:flutter/material.dart';

import 'package:blog_api/common/global.dart';
import 'package:blog_api/models/index.dart';


class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

/// 用户状态在登录状态发生变化时更新、通知其依赖项
class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User user) {
    if (user?.username != _profile.user?.username) {
      _profile.lastLogin = _profile.user?.username;
      _profile.user = user;
      notifyListeners();
    }
  }
}