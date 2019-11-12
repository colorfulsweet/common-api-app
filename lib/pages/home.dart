import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blog_api/common/profile_notifier.dart';
import 'package:blog_api/components/full_button.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, dynamic>> menus = [
    {'icon': Icons.photo_library, 'text': '照片墙'},
    {'icon': Icons.query_builder, 'text': '其他'},
    {'icon': Icons.query_builder, 'text': '其他'},
    {'icon': Icons.query_builder, 'text': '其他'},
    {'icon': Icons.query_builder, 'text': '其他'},
    {'icon': Icons.query_builder, 'text': '其他'},
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
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
      body:

      Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 横轴元素数量
                mainAxisSpacing: 10, // 纵轴间距
                crossAxisSpacing: 10 // 横轴间距
            ),
            itemBuilder: (context, index){
              return Container(
                color: Colors.black12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(this.menus[index]['icon'], size: 50),
                    Text(this.menus[index]['text'], style: TextStyle(fontSize: 20),) //query_builder
                  ],
                ),
              );
            },
            itemCount: this.menus.length,
          ),
          FullButton(text: '退出登录', color: Theme.of(context).errorColor),
          ],
        )
      ),
    );
  }
}
