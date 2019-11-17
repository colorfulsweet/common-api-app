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
          onPressed: (){ // 点击事件, 打开底部升起的浮动框
            showModalBottomSheet(
              context: context,
              builder: (bottomSheetContext) => _OneChatFrom({}),
//              isScrollControlled: true,
            );
          },
          tooltip: '添加一言',
          child: Icon(Icons.add), // 子元素是一个图标
        ),
//        bottomSheet: _OneChatFrom(),
      ),
    );
  }
}

/// 添加一言 表单
class _OneChatFrom extends StatelessWidget {
  final Map<String, String> fromData;

  _OneChatFrom(this.fromData);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: fromData['hitokoto'],
            decoration: InputDecoration(
              labelText: '内容',
            ),
            maxLines: 2, // 可折行
            validator: (v) {
              return v.trim().isNotEmpty ? null : '必须输入内容';
            },
            onChanged: (value) {
              this.fromData['hitokoto'] = value;
            },
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text('保存'),
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  // TODO 保存一言
                  print(this.fromData);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('取消'),
                textColor: Theme.of(context).hintColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      )
    );
  }

}