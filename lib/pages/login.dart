import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'package:blog_api/common/global.dart';
import 'package:blog_api/models/index.dart';
import 'package:blog_api/common/profile_notifier.dart';
import 'package:blog_api/components/full_button.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /// 表单的唯一标识
  final GlobalKey _formKey = GlobalKey<FormState>();
  /// Scaffold组件的唯一标识
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  /// 是否显示密码明文
  bool pwdShow = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: false,
          child: Column(
            children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: '用户名',
                hintText: '请输入用户名/邮箱',
                prefixIcon: Icon(Icons.person),
              ),
              // 校验用户名（不能为空）
              validator: (v) {
                return v.trim().isNotEmpty ? null : '必须输入用户名';
            }),
            TextFormField(
              controller: _pwdController,
              autofocus: false,
              decoration: InputDecoration(
                labelText: '密码',
                hintText: '请输入密码',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(this.pwdShow ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      this.pwdShow = !this.pwdShow;
                    });
                  },
                )),
              obscureText: !this.pwdShow,
              //校验密码（不能为空）
              validator: (v) {
                return v.trim().isNotEmpty ? null : '必须输入密码';
              },
            ),
            FullButton(text:'登录', onPressed: this._onLogin,)
            ],
          ),
        ),
      ),
    );
  }
  void _onLogin() async{
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      Response response = await Dio().post( '${Global.API_BASE_PATH}common/login',
          data: {'username': _usernameController.text, 'password': _pwdController.text});

      if(response.data['statusCode'] == 401) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(response.data['msg'])));
        return;
      }
      // 保存token
      Global.profile.token = response.data['token'];
      // 组件间共享用户信息
      Provider.of<ProfileNotifier>(context).user = User.fromJson(response.data['userInfo']);

      Navigator.pushNamed(context, 'home');
    }
  }
}