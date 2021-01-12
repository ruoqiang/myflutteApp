import 'package:flutter/material.dart';

import 'package:myflutterapp/pages/my_page.dart';
import 'package:myflutterapp/provide/currentMenuIndex.dart';
import 'package:provide/provide.dart';

import '../pages/publish_goods_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/history_publish_order.dart';

class IndexPage extends StatefulWidget {
  final Widget child;

  IndexPage({Key key, this.child}) : super(key: key);

  _IndexPageState createState() => _IndexPageState();
}

int _currentIndex;

final PageController _controller = PageController(
  initialPage: _currentIndex,
);

class _IndexPageState extends State<IndexPage> {
  final bootomTabList = [
    BottomNavigationBarItem(
        icon: Icon(Icons.store_mall_directory), label: '发布货源'),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_shipping),
      label: '历史货源清单',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: '我的',
    ),
  ];

//    final pageList = [HomePage(),SearchGoodsPage(),OrderPage(),MyPage()]; //UserCenterPage
  //UserCenterPage
  @override
  Widget build(BuildContext context) {
    changePage(index) {
      print('changePage----------------------------:$index');
//      _controller.jumpToPage(index);
//      setState(() { //不加setState部分菜单切换无效
//        _currentIndex = index;
//      });
//      Provide.value<CurrentMenuIndexProvide>(context).changeIndex(index); //不加这部分菜单切换无效
    }
    _currentIndex =
        Provide.value<CurrentMenuIndexProvide>(context).currentIndex;
    print('_currentIndex----:$_currentIndex');

    final pageList = [
      PublishGoodsPage(changePage:(index)=>changePage(index)),
      HistoryPublishOrderPage(),
      MyPage()
    ];
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
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
              unselectedItemColor: Colors.grey,
              onTap: (int index) {
                _controller.jumpToPage(index);
                setState(() {
                  _currentIndex = index;
                  Provide.value<CurrentMenuIndexProvide>(context).changeIndex(index);
                });
                print('_currentIndex----:$_currentIndex');
              },
            ),
            body: PageView(
              //IndexedStack替换为
              controller: _controller,
              children: pageList,
              physics: NeverScrollableScrollPhysics(),
            ),
          );
        });
  }


}
