import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blog_api/route.dart';
import 'package:blog_api/common/global.dart';
import 'package:blog_api/common/profile_notifier.dart';

void main() => Global.init().then((e) => runApp(BlogApi()));

class BlogApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InheritedProvider<ProfileNotifier>(
      value: ProfileNotifier(),
      child: MaterialApp(
        title: '博客api管理后台',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        routes: routeTable,
        initialRoute: 'login',
      ),
    );
  }
}



