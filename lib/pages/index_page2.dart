import 'package:flutter/material.dart';
import 'package:myflutterapp/pages/select_user_type.dart';
import 'package:myflutterapp/pages/login.dart';
import 'package:myflutterapp/pages/my_page.dart';
import 'package:myflutterapp/pages/register.dart';
import 'package:myflutterapp/provide/currentMenuIndex.dart';
import 'package:provide/provide.dart';
import '../pages/home.dart';
//import '../pages/search.dart';
import '../pages/user_center.dart';
import '../pages/publish_goods_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/history_publish_order.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';
class IndexPage2 extends StatefulWidget {
//    final Widget child;

//    IndexPage2({Key key, this.child}) : super(key: key);

    IndexPage2({Key key}) : super(key: key);

    _IndexPageState createState() => _IndexPageState();
  }

changePage(index) {
  print('changePageFromChild---------------------------------------------------$index');
}
class _IndexPageState extends State<IndexPage2> {

//  changePageFromChild(index) {
//    Provide.value<CurrentMenuIndexProvide>(context)
//  }
  @override
  initState()  {
//
//    print('isNeedUpdated---------------------------------------------------$isNeedUpdated');
    // ignore: unrelated_type_equality_checks
//    AppUpgrade.appUpgrade(
//      context,
//      _checkAppInfo(),
//      //      iosAppId: 'id88888888',
//      onOk: () {
//        print('onOk');
//      },
//      downloadProgress: (count, total) {
//        print('count:$count,total:$total');
//      },
//      downloadStatusChange: (DownloadStatus status, {dynamic error}) {
//        print('status:$status,error:$error');
//      },
//    );
    isNeedUpdate();
    super.initState();
  }
  _AppUpgrade() {
    AppUpgrade.appUpgrade(
      context,
      _checkAppInfo(),
      //      iosAppId: 'id88888888',
      onOk: () {
        print('onOk');
      },
      downloadProgress: (count, total) {
        print('count:$count,total:$total');
      },
      downloadStatusChange: (DownloadStatus status, {dynamic error}) {
        print('status:$status,error:$error');
      },
    );
  }
  Future<AppUpgradeInfo> _checkAppInfo() async {
    //这里一般访问网络接口，将返回的数据解析成如下格式
    return Future.delayed(Duration(seconds: 1), () {
      return AppUpgradeInfo(
        title: '新版本V1.1.1',
        contents: [
          '1、支持立体声蓝牙耳机，同时改善配对性能',
          '2、提供屏幕虚拟键盘',
          '3、更简洁更流畅，使用起来更快',
          '4、修复一些软件在使用时自动退出bug',
          '5、新增加了分类查看功能'
        ],
        force: false,
          apkDownloadUrl: 'http://wechat.chepass.com/Content/dist/app-armeabi-v7a-release.apk',

      );
    });
  }

   isNeedUpdate () async {
    var appInfo = await FlutterUpgrade.appInfo;
    //  后台返回的版本号是带小数点的（2.8.1）所以去除小数点用于做对比                
    final serviceVersionCode = '1.0.3';
    var RserviceVersionCode = int.parse(serviceVersionCode.replaceAll('.','')); //String -> int
    //  当前App运行版本  
    int currentVersionCode = int.parse(appInfo.versionName.replaceAll('.','')); //String -> int
    //检查版本更新的版本号
    if (RserviceVersionCode > currentVersionCode) {
      print('检查版本更新的版本号--------------------------------------------------------检查版本更新的版本号');
      _AppUpgrade();
    }
  }
  int _currentIndex = 0;

    final bootomTabList = [
           BottomNavigationBarItem(
             icon:Icon(Icons.store_mall_directory ),
            label: '发布货源'
           ),
      BottomNavigationBarItem(
        icon: Icon(Icons.local_shipping),
        label: '历史货源清单',
      ),
            BottomNavigationBarItem(
             icon: Icon(Icons.person),
             label: '我的',
           ),
         ];

    @override
    Widget build(BuildContext context) {
      changePage(index) {
        print('changePage----------------------------:$index');
      setState(() { //不加setState部分菜单切换无效
        _currentIndex = index;
      });
      Provide.value<CurrentMenuIndexProvide>(context).changeIndex(index); //不加这部分菜单切换无效
      }
      ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: false);
//      _currentIndex =
//          Provide.value<CurrentMenuIndexProvide>(context).currentIndex;
      final pageList = [PublishGoodsPage(changePage:(index)=>changePage(index)),HistoryPublishOrderPage(),MyPage()]; //UserCenterPage HomePage(),
      return Provide<CurrentMenuIndexProvide>(

          builder: (context,child,val){
            return Scaffold(
//       appBar: AppBar(title: Text('老马货运',style: TextStyle(color:Color(0xffffffff)),)),
              backgroundColor: Color(0xffeff0f4),
              bottomNavigationBar: BottomNavigationBar(
                items: bootomTabList,
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                selectedItemColor: Colors.blue,
                unselectedItemColor:Colors.grey,
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                    Provide.value<CurrentMenuIndexProvide>(context).changeIndex(index);
                  });
                  var _rrcurrentIndex = Provide.value<CurrentMenuIndexProvide>(context).currentIndex;
                  print('_currentIndex333:$_rrcurrentIndex');
                },
              ),
              body: IndexedStack(
                index: _currentIndex,
                children: pageList,
              ),
            );
          });

  }
 
  
  }
