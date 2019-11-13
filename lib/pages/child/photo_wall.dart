import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:blog_api/common/profile_notifier.dart';
import 'package:blog_api/common/global.dart';

/// 照片墙
class PhotoWall extends StatefulWidget {
  PhotoWall({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PhotoWallState createState() => _PhotoWallState();
}


class _PhotoWallState extends State<PhotoWall> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<double> heights = [50,80,30,60,55,90];
  List<String> imgUrls = [];

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
      body:  StaggeredGridView.countBuilder(
//        controller: _scrollController,
        itemCount: this.imgUrls.length,
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) => Container(
          child: Image.network(
            this.imgUrls[index], // 图片地址
            fit: BoxFit.fitWidth, // fit属性指定控制图片拉伸适应容器的方式, 这里是按高度适应
          ),
        ),
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      ),
    );
  }
  @override
  void initState() {
    this._loadImagesData();
    super.initState();
  }

  void _loadImagesData () async {
    Response response = await Dio().get('${Global.API_BASE_PATH}common/photos?start=0&limit=20');
    print(response.data['data']);
//    var thumbnailUrls = response.data['data'].map((item) {
//      return 'https://cdn.colorfulsweet.site/' + item['thumbnail'];
//    });
//    print(thumbnailUrls);
//    imgUrls.addAll(thumbnailUrls);
  }
}