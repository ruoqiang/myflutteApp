import 'package:flutter/material.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';

class UserBaseInfoPage extends StatefulWidget {
  @override
  _UserBaseInfoState createState() => _UserBaseInfoState();
}

class _UserBaseInfoState extends State<UserBaseInfoPage> {
  var _inputController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fixedAppbar('基础信息'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _headeText(),
            _headeLine(),
            _formBox(),
            _nextButton()
          ],
        ),
      ),
    );
  }
  Widget _headeText (){
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('基础信息',style: TextStyle(color: Color(0xff2D4ED1),fontSize: 14),),
          Container(
            margin: EdgeInsets.only(left: 52,right: 52),
            child: Text('车辆信息'),
          ),
          Text('证件照片'),
        ],
      ),
    );
  }
  Widget _headeLine (){
    return Container(
      margin: EdgeInsets.only(top: 20,bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/index_apply_icon_choose_blue.png',width: 20,),
          Container(
            margin: EdgeInsets.only(left: 2,right: 2),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            width: 80,
            height: 0,
            child: Text('', textAlign: TextAlign.center),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 20,
              height: 20,
              color: Colors.black12,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 2,right: 2),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            width: 80,
            height: 0,
            child: Text('', textAlign: TextAlign.center),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 20,
              height: 20,
              color: Colors.black12,
            ),
          )
        ],
      ),
    );
  }

  Widget _formBox () {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _formList(Text('申请人信息')),
          _formList(_labelAndInput('姓名','请输入姓名',_inputController)),
          _formList(_labelAndSexal('性别',_inputController)),

          _formList(_labelAndInput('身份证号','请输入身份证号',_inputController)),
          _formList(_labelAndInput('手机号','请输入手机号',_inputController)),
          _formList(_labelAndInputYzm('验证码','请输入验证码',_inputController)),
        ],
      ),
    );
  }
  Widget _formList(widgit) {
    return Container(
      color: Color(0xffffffff),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left:15,right: 15),
              height: 46,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black12),
                ),
              ),
              child: widgit,
            ),
          )
        ],
      ),
    );
  }
  // 有输入框的列
  Widget _labelAndInput(_lable,_phaceholder,_inputControl){
    return Row(children: <Widget>[
      Text(_lable),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 15),
          child: TextField(
            controller: _inputControl,
            decoration: InputDecoration(
              hintText: _phaceholder,
              border:InputBorder.none,
            ),
            style: TextStyle(fontSize: 14),
          ),
        ),
      )
    ],
    );
  }
//  带验证码，输入框的列
  Widget _labelAndInputYzm(_lable,_phaceholder,_inputControl){
    return Row(children: <Widget>[
      Text(_lable),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 15),
          child: TextField(
            controller: _inputControl,
            decoration: InputDecoration(
              hintText: _phaceholder,
              border:InputBorder.none,
            ),
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 10),
          height: 46,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border(
            left: BorderSide(width: 1.0, color: Colors.black12),
            ),
            ),
        child: Text('获取验证码',style: TextStyle(color: Color(0xff108EE9)),),
      )
    ],
    );
  }
//  带性别的列
  Widget _labelAndSexal(_lable,_inputControl){
    return Row(children: <Widget>[
      Text(_lable),
      Container(
        margin: EdgeInsets.only(left: 15,right: 25),
        child: GestureDetector(
          onTap: (){
            print('nan');
          },
          child: Row(
            children: <Widget>[
              Image.asset('images/index_apply_icon_choose.png',width: 16,),
              Text('男')
            ],
          ),
        ),
      ),
      Container(
        child: GestureDetector(
          onTap: (){
            print('女');
          },
          child: Row(
            children: <Widget>[
              Image.asset('images/index_apply_icon_choose_gray.png',width: 16,),
              Text('女')
            ],
          ),
        ),
      )
    ],
    );
  }

  //按钮
Widget _nextButton(){
  return Row(
    children: <Widget>[
      Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.only(left: 15,right: 15),
          height: 40,
          child: RaisedButton(
            color:Color(0xff2D4ED1) ,
            onPressed: (){
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) {
//                  return UserBaseInfoPage();
//                }),
//              );
            },
//            textColor: Color(0xff2D4ED1),
            child: Text("下一步",style: TextStyle(fontSize: 16,color: Colors.white),),
          ),
        ),
      )
    ],
  );
}
}
