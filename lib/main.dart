import 'package:flutter/material.dart';
import 'package:myflutterapp/pages/index_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluro/fluro.dart';
import './routers/routes.dart';
import './routers/application.dart';
import 'package:myflutterapp/pages/login.dart';
import 'package:provide/provide.dart';
import 'provide/count.dart';
import 'dart:io';
import 'package:flutter/services.dart';
void main() {
  //全局注册provide状态
  var counter =Counter();
  var providers  =Providers();
  providers
    ..provide(Provider<Counter>.value(counter));
  runApp(ProviderNode(child: MyApp(), providers: providers));
  if (Platform.isAndroid) {
// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    //-------------------主要代码start
    final router = Router();
    Routes.configureRoutes(router);
    Application.router=router;
    //-------------------主要代码end
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
          textSelectionColor: Colors.red,
      ),
      home: IndexPage(),//MyHomePage(title: 'Flutter Demo Home Page'), //入口页面
//      //注册路由表
//      routes: {
//        "router/login_page": (context) => LoginPage(),
//      },
      //----------------主要代码start
      onGenerateRoute: Application.router.generator,
      //----------------主要代码end
    );
  }
}



  
