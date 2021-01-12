import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:myflutterapp/pages/index_page.dart';
import 'package:fluro/fluro.dart';
import 'package:myflutterapp/pages/index_page2.dart';
import 'package:myflutterapp/pages/select_user_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './routers/routes.dart';
import './routers/application.dart';
import 'package:provide/provide.dart';
import 'provide/currentMenuIndex.dart';
import 'provide/count.dart';
import 'dart:io';
import 'package:flutter/services.dart';




main () async   {
  WidgetsFlutterBinding.ensureInitialized(); //让main加异步async不报错
getUserType() async {
  SharedPreferences  _prefs =  await SharedPreferences.getInstance();
  var userType = _prefs.getString('userType');
  return  userType;
}
  var userType = await  getUserType();
  //全局注册provide状态
  var counter = Counter();
  var currentMenuIndex  =CurrentMenuIndexProvide();
  var providers  =Providers();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<CurrentMenuIndexProvide>.value(currentMenuIndex));
    runApp(ProviderNode(child: MyApp(userType:userType), providers: providers));

  if (Platform.isAndroid) {
// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  final userType;
  MyApp({this.userType});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Future<void> hideScreen() async {
      Future.delayed(Duration(milliseconds: 3600), () {
        FlutterSplashScreen.hide();
      });
    }
    hideScreen();
//    userType = null;

    return LayoutBuilder(

        builder: (context, constraints) {
          //-------------------主要代码start
          //配置路由
          //创建
          final router = new FluroRouter();
          //绑定
          Routes.configureRoutes(router);
          //全局赋值
          Application.router = router;
          //-------------------主要代码end
          return MaterialApp(
            title: '老马货主',
            debugShowCheckedModeBanner: false,
//            showPerformanceOverlay: true,
            theme: ThemeData(
              primarySwatch: Colors.lightBlue,
              textSelectionColor: Colors.red,
            ),
            home: IndexPage2(), //入口页面
//      //注册路由表
//      routes: {
//        "router/login_page": (context) => LoginPage(),
//      },

            //----------------主要代码start
            onGenerateRoute: Application.router.generator,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('zh', 'CH'),
              const Locale('en', 'US'),
            ],
            locale: Locale('zh'),
            //----------------主要代码end
          );
        }
    );

  }
}



  
