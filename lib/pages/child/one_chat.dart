import 'package:flutter/material.dart';
import 'package:blog_api/common/base_state.dart';
import 'package:provider/provider.dart';

import 'package:blog_api/common/profile_notifier.dart';

/// 一言
class OneChat extends StatefulWidget {
  OneChat({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _OneChatState createState() => _OneChatState();
}

class _OneChatState extends BaseState<OneChat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: super.scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
          Icon(Icons.person),
          Container(
            padding: EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            child: Text(Provider.of<ProfileNotifier>(context).user.realname),
          ),
          ],
        ),
        // 浮动按钮
        floatingActionButton: FloatingActionButton(
          onPressed: (){ // 点击事件, 打开浮动框
            showDialog(
              context: context,
              builder: (dialogContext) => _OneChatFrom(dialogContext)
            );
          },
          tooltip: '添加一言',
          child: Icon(Icons.add), // 子元素是一个图标
        ),
      ),
    );
  }
}

/// 添加一言 表单
class _OneChatFrom extends StatelessWidget {
  final BuildContext dialogContext;

  _OneChatFrom(this.dialogContext);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('添加一言'),
      content: Text('这里应该是个表单'),
      actions: <Widget>[
        FlatButton(
          child: Text('保存'),
          onPressed: () {
            // TODO 保存一言
            Navigator.of(dialogContext).pop();
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
    );;
  }
}