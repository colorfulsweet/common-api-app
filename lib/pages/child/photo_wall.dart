import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blog_api/common/profile_notifier.dart';

/// 照片墙
class PhotoWall extends StatefulWidget {
  PhotoWall({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PhotoWallState createState() => _PhotoWallState();
}


class _PhotoWallState extends State<PhotoWall> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      body: Container()
    );
  }

}