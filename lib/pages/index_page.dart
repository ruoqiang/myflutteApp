import 'package:flutter/material.dart';
import 'package:myflutterapp/pages/login.dart';
import 'package:myflutterapp/pages/register.dart';
import '../pages/home.dart';
import '../pages/search.dart';
import '../pages/shopping_cart.dart';
import '../pages/user_center.dart';


class IndexPage extends StatefulWidget {
    final Widget child;
  
    IndexPage({Key key, this.child}) : super(key: key);
  
    _IndexPageState createState() => _IndexPageState();
  }
  
class _IndexPageState extends State<IndexPage> {

    int _currentIndex = 0;

    final bootomTabList = [
           BottomNavigationBarItem(
             icon:Icon(
               Icons.home,
               color:Colors.blue,
             ),
             title:Text(
               '首页',
               style:TextStyle(color:Colors.blue)
             )
           ),
           BottomNavigationBarItem(
             icon:Icon(
               Icons.store_mall_directory,
               color:Colors.blue,
             ),
             title:Text(
               '商城',
               style:TextStyle(color:Colors.blue)
             )
           ),
           BottomNavigationBarItem(
             icon:Icon(
               Icons.message,
               color:Colors.blue,
             ),
             title:Text(
               '消息',
               style:TextStyle(color:Colors.blue)
             )
           ),BottomNavigationBarItem(
             icon:Icon(
               Icons.person,
               color:Colors.blue,
             ),
             title:Text(
               '我的',
               style:TextStyle(color:Colors.blue)
             )
           ),
         ];

    final pageList = [RegisterPage(),SearchPage(),ShopCart(),UserCenterPage()];
    @override
    Widget build(BuildContext context) {
//      setState(() {
//        _currentIndex = 1;
//      });
     return Scaffold(
//       appBar: AppBar(title: Text('百姓生活+',style: TextStyle(color:Color(0xffffffff)),)),
       backgroundColor: Color(0xfff2f2f2),
       bottomNavigationBar: BottomNavigationBar(
          items: bootomTabList,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
       ),
      body: IndexedStack(
        index: _currentIndex,
        children: pageList,
      ),
     );
  }
 
  
  }
