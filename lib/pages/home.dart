import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:myflutterapp/pages/login.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent='正在获取数据';
  List<Map> navigatorList = [];
  List<Map> slideList = [];

  @override
  void initState() {
    super.initState();
    getHttp().then((val){
      setState(() {
        homePageContent = val.toString();
        var data = json.decode(homePageContent); //json.decode反序列化，把json字符串转为对象
        // var data = data['data'];
        print(data);
        navigatorList = (data['data']['category'] as List).cast(); //转化为可以通过属性调用的对象
        slideList = (data['data']['slides'] as List).cast(); //转化为可以通过属性调用的对象
        print(navigatorList);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      
      child:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            navigatorList.length >0 ?TopNavigator(navigatorList: navigatorList) :new Text(''),
            TopNavigatorlist(navigatorList: navigatorList),
            SlideList(slideList: slideList,),
            new Text('ddd'),
            new Text('ddddsswed'),
            RaisedButton(child: Text('跳转到登录',style: TextStyle(color: Colors.deepPurple),),onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new LoginPage()),
              );
            },),
          ],
        ),
      )
    );
  }

  Future getHttp() async{
    try{
      Response response;
      Dio dio = Dio();
      dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");

      var formData = {'lon':'115.02932','lat':'35.76189'};
      response = await dio.post("http://test.baixingliangfan.cn/baixing/wxmini/homePageContent", data: formData);
      
      var result = response;//json.decode(response.toString());

      return result.data;

    }catch(e){
      return print(e);
    }
  }


}
// 导航组件
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      height: 200.0,
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItem(context, item);
        }).toList(),
      ),
    );
  }

  Widget _gridViewItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: 45.0,
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }
}

class TopNavigatorlist extends StatelessWidget {
  final List navigatorList;

  TopNavigatorlist({Key key, this.navigatorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 500.0,
      padding: EdgeInsets.all(3.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: navigatorList.length,
        itemBuilder: (context,index) {
          return _gridViewItem(navigatorList[index]);
        },
      )
    );
  }
 Widget _gridViewItem(item) { //如果第一个参数加了上下文BuildContext context，调用的时候也要加。。不加的话，都不加
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: 45.0,
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }
}

class SlideList extends StatelessWidget {
  final List slideList;

  SlideList({Key key, this.slideList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 500.0,
      padding: EdgeInsets.all(3.0),
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(slideList[index]['image'], fit: BoxFit.fill,
          );
        },
        itemCount: slideList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}
