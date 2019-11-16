import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blog_api/common/base_state.dart';
import 'package:blog_api/common/profile_notifier.dart';
import 'package:blog_api/components/full_button.dart';
import 'package:blog_api/common/global.dart';

/// 首页
class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends BaseState<Home> {
  final List<Map<String, dynamic>> _menus = [
    {'icon': Icons.photo_library, 'text': '照片墙', 'routeName': 'photoWall'},
    {'icon': Icons.query_builder, 'text': '其他'},
    {'icon': Icons.query_builder, 'text': '其他'},
    {'icon': Icons.query_builder, 'text': '其他'},
    {'icon': Icons.query_builder, 'text': '其他'},
    {'icon': Icons.query_builder, 'text': '其他'},
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: super.scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false, // 不显示返回按钮
        actions: <Widget>[
          Icon(Icons.person),
          Container(
            padding: EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            child: Text(Provider.of<ProfileNotifier>(context).user.realname),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 横轴元素数量
                mainAxisSpacing: 10, // 纵轴间距
                crossAxisSpacing: 10 // 横轴间距
            ),
            itemBuilder: (context, index){
              return AnimatedContainer(
                duration: Duration(seconds: 5),
                child:Ink(
                  color: Theme.of(context).cardColor,
                  child:InkWell(
                    onTap: () => Navigator.pushNamed(context, this._menus[index]['routeName']),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(this._menus[index]['icon'], size: 50),
                        Text(this._menus[index]['text'], style: TextStyle(fontSize: 20),) //query_builder
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: this._menus.length,
          ),
          FullButton(
            text: '退出登录',
            color: Theme.of(context).errorColor,
            onPressed: this._logout,
          ),
          ],
        )
      ),
    );
  }
  /// 退出登录
  void _logout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('确定退出登录？'),
          actions: <Widget>[
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // 清空token
                Global.profile.token = null;
                // 清空用户信息
                Provider.of<ProfileNotifier>(context).user = null;
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('取消'),
              textColor: Theme.of(context).hintColor,
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
