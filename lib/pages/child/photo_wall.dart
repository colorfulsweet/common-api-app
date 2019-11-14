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
  // 滚动控制器
  ScrollController _scrollController = ScrollController();
  List<String> imgUrls = [];
  int _start = 0;
  int _limit = 20;
  bool _isLoading = false; // 是否正在加载


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
      body: RefreshIndicator(
        onRefresh: _refreshImagesData,
        child: StaggeredGridView.countBuilder(
          controller: _scrollController,
          itemCount: this.imgUrls.length,
          primary: false,
          crossAxisCount: 4,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) => Container(
            child: Image.network(
              this.imgUrls[index], // 图片地址
              fit: BoxFit.fitWidth, // fit属性指定控制图片拉伸适应容器的方式, 这里是占满宽度, 高度成比例缩放
            ),
          ),
          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    this._refreshImagesData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        this._moreImagesData();
      }
    });
  }
  /// 下拉时刷新数据
  Future<void> _refreshImagesData () async {
    return this._loadImagesData(false, (List<String> thumbnails){
      this.imgUrls = thumbnails;
    });
  }
  /// 滑动到底部时加载更多数据
  Future<void> _moreImagesData() {
    return this._loadImagesData(true, (List<String> thumbnails){
      this.imgUrls.addAll(thumbnails);
    });
  }

  Future<void> _loadImagesData(bool isAdd, Function callback) async {
    if(this._isLoading) return null;
    if(isAdd) {
      this._start += this._limit;
    } else {
      this._start = 0;
    }
    this._isLoading = true;
    return Dio().get('${Global.API_BASE_PATH}common/photos', queryParameters: {'start': this._start, 'limit': this._limit})
        .then((Response response) {
      this._isLoading = false;
      List<String> thumbnails = [];
      response.data['data'].forEach((item) {
        thumbnails.add('https://cdn.colorfulsweet.site/' + item['thumbnail']);
      });
      // 动态改变数据需要调用setState
      setState((){
        callback(thumbnails);
      });
    });
  }
}