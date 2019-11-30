import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:photo_view/photo_view.dart';

import 'package:blog_api/common/base_state.dart';
import 'package:blog_api/common/profile_notifier.dart';

/// 照片墙
class PhotoWall extends StatefulWidget {
  PhotoWall({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PhotoWallState createState() => _PhotoWallState();
}


class _PhotoWallState extends BaseState<PhotoWall> {
  // 滚动控制器
  ScrollController _scrollController = ScrollController();
  String _pictureCdn;
  List<dynamic> _imgData = [];
  int _start = 0;
  final int _limit = 20;

  @override
  Widget build(BuildContext context) {
    // 获取屏幕的尺寸
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
      body: ModalProgressHUD(
        inAsyncCall: super.loading,
        child: RefreshIndicator(
          onRefresh: _refreshImagesData,
          child: buildStaggeredGridView(screenSize, context),
        ),
      ),
    );
  }
  /// 构建瀑布流布局
  StaggeredGridView buildStaggeredGridView(Size screenSize, BuildContext context) {
    return StaggeredGridView.countBuilder(
      controller: _scrollController,
      itemCount: this._imgData.length,
      primary: false,
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: EdgeInsets.all(10),
      itemBuilder: (staggeredGridViewContext, index) => Container(
        height: (screenSize.width - 30) / 2 / this._imgData[index]['width'] * this._imgData[index]['height'],
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          boxShadow: [BoxShadow(color:Colors.black54, blurRadius: 6, spreadRadius: 1, offset:Offset(-2,-2))]
        ),
        child: GestureDetector(
          onTap: (){
            showDialog(
              context: staggeredGridViewContext,
              builder: (dialogContext) => PhotoView(
                onTapUp: (BuildContext context, TapUpDetails details, PhotoViewControllerValue controllerValue){
                  Navigator.of(dialogContext).pop();
                },
                imageProvider: NetworkImage(this._pictureCdn + this._imgData[index]['name']),
              )
            );
          },
          child: Image.network(
            this._pictureCdn + this._imgData[index]['thumbnail'], // 图片缩略图地址
            fit: BoxFit.fitWidth, // fit属性指定控制图片拉伸适应容器的方式, 这里是占满宽度, 高度成比例缩放
          ),
        ),
      ),
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    );
  }
  @override
  void initState() {
    super.initState();
    this._pictureCdn = this._getPictureCdn().toString();
    this._refreshImagesData();
    this._scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        this._moreImagesData();
      }
    });
  }

  dynamic _getPictureCdn() async {
    super.loading = true;
    var response = await super.http.get('common/config/picture_cdn');
    return response.data;
  }

  /// 下拉时刷新数据
  Future<void> _refreshImagesData() {
    return this._loadImagesData(false, (List<dynamic> imgData){
      this._imgData = imgData;
    });
  }
  /// 滑动到底部时加载更多数据
  Future<void> _moreImagesData() {
    return this._loadImagesData(true, (List<dynamic> imgData){
      this._imgData.addAll(imgData);
    });
  }

  Future<void> _loadImagesData(bool isAdd, Function callback) {
    if(super.loading) return null;
    if(isAdd) {
      super.loading = true;
      this._start += this._limit;
    } else {
      this._start = 0;
    }
    return super.http.get('common/photos', queryParameters: {'start': this._start, 'limit': this._limit})
        .then((response) {
      super.loading = false;
      // 动态改变数据需要调用setState
      setState((){
        callback(response.data['data']);
      });
    });
  }
}