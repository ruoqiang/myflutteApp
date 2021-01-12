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



class TestSelectDatePage extends StatefulWidget {
  @override
  _TestSelectDatePageState createState() => _TestSelectDatePageState();
}

class _TestSelectDatePageState extends State<TestSelectDatePage> {

  var date = '';
  var time = '';
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
  SelectDate() async {
    var result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      initialDatePickerMode: DatePickerMode.year,
    );
    var timeSelect = await SelectTime();
    var hour = timeSelect.hour;
    var minute = timeSelect.minute;
    print('period-------------------${result}');
    return result;
  }
  SelectTime () async{
    var result = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    result.toString();
    print('result-------------------${result.hourOfPeriod}'); //hourOfPeriod 12小时制的小时  in 12 hour format
    print('minute-------------------${result.minute}');
    print('hour-------------------${result.hour}'); //hour 24小时制的小时
    print('period-------------------${result.period}'); //period am 还是pm
//    if(result != null) {
////      setState(() {
////        time = (result.hourOfPeriod).toString();
////      });
//    }
    return time;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: fixedAppbar(title:'选择日期'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            NextButton(text: '选择日期',ButtonClick: SelectDate),
            NextButton(text: '选择时间',ButtonClick: SelectTime),
            Container(
              width: 200,
              height: 80,
              color: Colors.green,
              child: Text(date),
            ),
            Text(time),
          ],
        ),
      ),
    );
  }

}
