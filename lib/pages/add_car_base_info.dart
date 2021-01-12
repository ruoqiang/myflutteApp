import 'package:flutter/material.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/common/http.dart';
import 'package:myflutterapp/pages/user_carinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBaseInfoPage extends StatefulWidget {
  @override
  _UserBaseInfoState createState() => _UserBaseInfoState();
}

class _UserBaseInfoState extends State<UserBaseInfoPage> {
  var _inputController;
//  var _nameController;
//  var _idNumberController;
//  var _mobileController;
//  var _inviteController;

  //输入框控制器
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idNumberController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _inviteController = TextEditingController();
  var sex = 1;
  var isSelf = false;
  TextEditingController _carOwnerNameController = TextEditingController();
  TextEditingController _carOwnerIDNumController = TextEditingController();
  TextEditingController _carOwnerPhoneController = TextEditingController();

  RegExp mobileExp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');

  switchSex(val) {
    setState(() {
      sex = val;
    });
  }
  switchSelf(val) {
    setState(() {
      isSelf = val;
    });
  }
  goToNextPage() async{
    print({'姓名': _nameController, '密码': _nameController.text});
    if(_nameController.text == ''){
      showToast("请输入姓名");
      return;
    }
    if(_idNumberController.text == ''){
      showToast("请输入身份证号");
      return;
    }
    if(_mobileController.text == ''){
      showToast("请输入手机号码");
      return;
    }
    if(mobileExp.hasMatch(_mobileController.text)==false) {
      showToast('请输入正确格式的手机号码');
      return;
    }

    if(isSelf == false){
      if(_carOwnerNameController.text == ''){
        showToast("请输入车主姓名");
        return;
      }
      if(_carOwnerIDNumController.text == ''){
        showToast("请输入车主身份证号");
        return;
      }
      if(_carOwnerPhoneController.text == ''){
        showToast("请输入车主手机号码");
        return;
      }
      if(mobileExp.hasMatch(_carOwnerPhoneController.text)==false) {
        showToast('请输入正确格式的车主手机号码');
        return;
      }
    }

    SharedPreferences  _prefs =  await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    var api = 'SubInfo/UserAndCar';
    var params = {
      'data': {
        'Step': 1,
        'CCustomerApply': {
          "Name": _nameController.text,
          "Sex": this.sex,
          "IDNumber": _idNumberController.text,
          "Phone": _mobileController.text,
          "Inviter": _inviteController.text,
          "IsOwnerApply": this.isSelf,
          "CarOwnerName":_carOwnerNameController.text,
          "CarOwnerIDNum": _carOwnerIDNumController.text,
          "CarOwnerPhone": _carOwnerPhoneController.text,
          "Relation": "11111"
        }
      },
      'token': token
    };
    print('dddddd：>>>>>>>>>>>>>-----------------------------------$params');
    await post('SubInfo/CheckStep',formData:params).then((val){
        print('dddddd：>>>>>>>>>>>>>-----------------------------------$val');
//        showToast('登录成功');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return UserCarInfoPage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fixedAppbar(title:'基础信息'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _headeText(),
            _headeLine(),
            _formBox(),
            _formIsSelfTitle(),
            _formIsSelfContent(),
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
          _formList(_labelAndInput('姓名','请输入姓名',_nameController)),
          _formList(_labelAndSexal('性别')),

          _formList(_labelAndInput('身份证号','请输入身份证号',_idNumberController)),
          _formList(_labelAndInput('手机号','请输入手机号',_mobileController)),
          _formList(_labelAndInput('邀请码','请输入邀请码',_inviteController)),
//          _formList(_labelAndInputYzm('验证码','请输入验证码',_inputController)),
        ],
      ),
    );
  }

  Widget _formIsSelfTitle(){
    return Container(
      margin: EdgeInsets.only(top: 15,bottom: 15),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _formList(_labelAndIsSelf('是否为申请人本人车辆')),
        ],
      ),
    );
  }

  Widget _formIsSelfContent () {
    return isSelf==false? Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _formList(Text('车主信息')),
          _formList(_labelAndInput('车主姓名','请输入车主姓名',_carOwnerNameController)),
          _formList(_labelAndInput('车主身份证号','请输入车主身份证号',_carOwnerIDNumController)),
          _formList(_labelAndInput('车主手机号','请输入车主手机号',_carOwnerPhoneController)),
        ],
      ),
    ): Container(width: 0,height: 0,);
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
  Widget _labelAndSexal(_lable){
    return Row(children: <Widget>[
      Text(_lable),
      Container(
        margin: EdgeInsets.only(left: 15,right: 25),
        child: GestureDetector(
          onTap: (){
            switchSex(1);
          },
          child: Row(
            children: <Widget>[
              sex==1 ? Image.asset('images/index_apply_icon_choose.png',width: 16,): Image.asset('images/index_apply_icon_choose_gray.png',width: 16,),
              Text('男')
            ],
          ),
        ),
      ),
      Container(
        child: GestureDetector(
          onTap: (){
            switchSex(0);
          },
          child: Row(
            children: <Widget>[
              sex==0 ? Image.asset('images/index_apply_icon_choose.png',width: 16,): Image.asset('images/index_apply_icon_choose_gray.png',width: 16,),
              Text('女')
            ],
          ),
        ),
      )
    ],
    );
  }
//  是否是本人
  Widget _labelAndIsSelf(_lable){
    return Row(children: <Widget>[
      Text(_lable),
      Container(
        margin: EdgeInsets.only(left: 15,right: 25),
        child: GestureDetector(
          onTap: (){
            switchSelf(true);
          },
          child: Row(
            children: <Widget>[
              isSelf ==true? Image.asset('images/index_apply_icon_choose.png',width: 16,): Image.asset('images/index_apply_icon_choose_gray.png',width: 16,),
              Text('是')
            ],
          ),
        ),
      ),
      Container(
        child: GestureDetector(
          onTap: (){
            switchSelf(false);
          },
          child: Row(
            children: <Widget>[
              isSelf==false ? Image.asset('images/index_apply_icon_choose.png',width: 16,): Image.asset('images/index_apply_icon_choose_gray.png',width: 16,),
              Text('否')
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
          margin: EdgeInsets.only(top: 40,bottom: 20),
          padding: EdgeInsets.only(left: 15,right: 15),
          height: 40,
          child: RaisedButton(
            color:Color(0xff2D4ED1) ,
            onPressed: (){
              goToNextPage();
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
