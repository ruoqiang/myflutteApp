import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/nextButton.dart';
import 'package:flutter_my_picker/flutter_my_picker.dart';
import 'package:flutter_my_picker/common/date.dart';


class TestSelectDate2Page extends StatefulWidget {
  @override
  _TestSelectDate2PageState createState() => _TestSelectDate2PageState();
}

class _TestSelectDate2PageState extends State<TestSelectDate2Page> {


  DateTime date;
  String dateStr;
  @override
 initState()  {
    super.initState();
    DateTime _date = new DateTime.now();
    print(MyDate.format('yyyy-MM-dd HH:mm:ss', _date));
    setState(() {
      date = _date;
      dateStr = MyDate.format('yyyy-MM-dd HH:mm:ss', _date);
    });
  }

  _change(formatString) {
    return (_date) {
      setState(() {
        date = _date;
        dateStr = MyDate.format(formatString, _date);
      });
    };
  }

showPicker() {
    print('showPicker---------------------------');
  MyPicker.showPicker(
    context: context,
    current: date,
    mode: MyPickerMode.date,
    onChange: _change('yyyy-MM-dd'),
  );
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: fixedAppbar(title:'选择日期'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            NextButton(text: '选择日期',ButtonClick: showPicker),
            Container(
              width: 200,
              height: 80,
              color: Colors.green,
              child: Text(date.toString()),
            ),
            NextButton(text:'日期时间选择器',ButtonClick: () {
              MyPicker.showDateTimePicker(
                context: context,
//                background: Colors.black,
//                color: Colors.white,
                current: date,
                magnification: 1.2,
                squeeze: 1.45,
                offAxisFraction: 0.2,
                onChange: _change('yyyy-MM-dd HH:mm'),
              );
            }),
            Text(
              '当前时间： ${dateStr ?? MyDate.format('yyyy-MM-dd HH:mm:ss', date)}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}
