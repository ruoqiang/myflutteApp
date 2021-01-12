import 'package:flutter/material.dart';
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


  @override
 initState()  {
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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: fixedAppbar(title:'我的'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            NextButton(text: '退出登录',ButtonClick: clear,)
          ],
        ),
      ),
    );
  }

}
