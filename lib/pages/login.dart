import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blog_api/common/global.dart';
import 'package:blog_api/models/index.dart';
import 'package:blog_api/common/common_notifier.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /// 表单的唯一标识
  GlobalKey _formKey = new GlobalKey<FormState>();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  /// 是否显示密码明文
  bool pwdShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: 50.0),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _onLogin,
                  textColor: Colors.white,
                  child: Text('登录'),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
  void _onLogin () {
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      print('用户名:${_usernameController.text} 密码:${_pwdController.text}');

      Global.profile.token = '123';
      Provider.of<CommonNotifier>(context).user = User.fromJson({'username': _usernameController.text});

      Navigator.pushNamed(context, 'home');
    }
  }
}