import 'package:flutter/material.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/nextButton.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:myflutterapp/pages/index_page.dart';
import 'package:myflutterapp/pages/my_page.dart';
import 'package:myflutterapp/pages/user_carinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'car_list.dart';
import 'certification.dart';
import 'login.dart';



class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var currentVersion;
  getCurVersion () async {
    var appInfo = await FlutterUpgrade.appInfo;
    print('getCurVersion versionName--------------------------------------------------------${appInfo.versionName}');
    print('getCurVersion versionCode--------------------------------------------------------${appInfo.versionCode}');
    print('getCurVersion packageName--------------------------------------------------------${appInfo.packageName}');

    setState(() {
      currentVersion = appInfo.versionName;
    });
    //  后台返回的版本号是带小数点的（2.8.1）所以去除小数点用于做对比                
    final serviceVersionCode = '1.0.3';

    var RserviceVersionCode = int.parse(serviceVersionCode.replaceAll('.','')); //String -> int
    //  当前App运行版本  
    int currentVersionCode = int.parse(appInfo.versionName.replaceAll('.','')); //String -> int
    print('RserviceVersionCode--------------------------------------------------------${RserviceVersionCode}');
    print('currentVersionCode--------------------------------------------------------${currentVersionCode}');
    //检查版本更新的版本号
    if (RserviceVersionCode > currentVersionCode) {
      print('检查版本更新的版本号--------------------------------------------------------检查版本更新的版本号');

    }
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

  @override
 initState()  {
    getCurVersion();
    super.initState();
  }
  clear() async{
   SharedPreferences _prefs =  await SharedPreferences.getInstance();

   _prefs.setBool('isLogin', false);
   _prefs.setBool('isCertified', false);
   Navigator.pushAndRemoveUntil(
     context,
     MaterialPageRoute(builder: (context) {
     return IndexPage();
     }),(check) => false
   );

 }

  _getVersion() {
    print('_getVersion--------------------------------------------------------_getVersion');
    _AppUpgrade();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: fixedAppbar(title:'设置'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            currentVersionWidget(),
            getVersionWidget(),
            NextButton(text: '退出登录',ButtonClick: clear,),

          ],
        ),
      ),
    );
  }

  Widget currentVersionWidget () {
    return Container(
      margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            border: Border(bottom:BorderSide(width: 1,color: Colors.black12))
        ),
        padding: EdgeInsets.only(left: 7,right: 7,top:12,bottom: 12),
        child: Stack(
          children: [
            Row(
              children: [
                Image.asset('images/setting.png',width: ScreenUtil().setWidth(46), height:ScreenUtil().setWidth(46)),
                Container(child: Text('当前版本'),margin: EdgeInsets.only(left: 8),)
              ],
            ),
            Positioned(child: Text('$currentVersion'),right: 0,)
          ],
        )
    );

  }
  Widget getVersionWidget () {
    return GestureDetector(
      onTap: ()=> _getVersion(),
      child: Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              border: Border(bottom:BorderSide(width: 1,color: Colors.black12))
          ),
          padding: EdgeInsets.only(left: 7,right: 7,top:12,bottom: 12),
          child: Stack(
            children: [
              Row(
                children: [
                  Image.asset('images/setting.png',width: ScreenUtil().setWidth(46), height:ScreenUtil().setWidth(46)),
                  Container(child: Text('检查新版本'),margin: EdgeInsets.only(left: 8),)
                ],
              ),
              Positioned(child: Icon(Icons.keyboard_arrow_right),right: 0,)
            ],
          )
      ),
    );

  }
}
