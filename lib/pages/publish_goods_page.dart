import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/base_widgit/fixedAppbar.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/pages/serach_goods_detail_page.dart';
import 'package:myflutterapp/provide/count.dart';
import '../base_widgit/appbar.dart';

class SearchGoodsPage extends StatefulWidget {
  @override
  _SearchGoodsPageState createState() => _SearchGoodsPageState();
}

class _SearchGoodsPageState extends State<SearchGoodsPage> {
  EasyRefreshController _controller;
  int _count = 10;

  String _mySelection1 = '全国';

  changeFn1(newVal) {
    print('changeFn1,,d的回调$newVal');
    setState(() {
      _mySelection1 = newVal;
    });
  }

  String _mySelection2 = '上海';

  changeFn2(newVal) {
    setState(() {
      _mySelection2 = newVal;
    });
  }

  String _mySelection3 = '智能排序';
  String _mySelection4 = '筛选';

  changeFn4(newVal) {
    setState(() {
      _mySelection4 = newVal;
    });
  }

  @override
  void initState() {
    print('SearchGoodsPage-----执行了');
    super.initState();
    _controller = EasyRefreshController();
  }

  _gotoDetal() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return SearchGoodsDetailPage(id: '22');
      }),
    );
  }

  changedSort() {}

  @override
  Widget build(BuildContext context) {
    print('SearchGoodsPage---build--执行了');
    return Scaffold(
      appBar: fixedAppbar(title: '发布货源'),
      body: Container(
        child: Column(
            children: <Widget>[
//              MyAppBar(title:'找货源',isHasBackBtn:false),

              Container(
//                margin: EdgeInsets.only(bottom: 10),
                child: _selectedBox(context),
              ),
              Expanded(
                  child:
                  EasyRefresh(
                      controller: _controller,
//                      firstRefresh: true,
                      header: ClassicalHeader(
                        refreshText: "下拉刷新",
                        refreshReadyText: "松开后开始刷新",
                        refreshingText: "正在刷新...",
                        refreshedText: "刷新完成",
                        bgColor: Colors.transparent,
                        textColor: Colors.black87,
                      ),
                      footer: ClassicalFooter(
                        loadText: "上拉加载更多",
                        loadReadyText: "松开后开始加载",
                        loadingText: "正在加载...",
                        loadedText: "加载完成",
                        noMoreText: "没有更多内容了",
                        bgColor: Colors.transparent,
                        textColor: Colors.black87,
                      ),
                      onRefresh: () async {
                        await Future.delayed(Duration(seconds: 2), () {
                          print('onRefresh');
                          setState(() {
                            _count = 10;
                          });
                          _controller.resetLoadState();
                        });
                        print('---------到底了，上拉开始');
                        print('---------$_count');
                      },
                      onLoad: () async {
                        await Future.delayed(Duration(seconds: 2), () {
                          print('onLoad');
                          setState(() {
                            _count += 10;
                          });
                          print('----------onLoad');
                          print('---------$_count');
                          _controller.finishLoad(noMore: _count >= 40);
                        });
                      },
                      child: ListView(
                        padding: EdgeInsets.only(top: 15),
                        scrollDirection: Axis.vertical, //垂直列表
                        children: List.generate(_count, (index) {
                          return Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                _ListTop(),
                                _listBottom()
                              ],
                            ),
                          );
                        }),
                      )
                  )

              ),
            ]
        ),

      ),
    );
  }

  Widget _ListTop() {
    return Container(
      child: InkWell(
        onTap: () {
          showToast('进入货源详情', backgroundColor: Colors.pink,
              time: 1);
          Future.delayed(Duration(seconds: 2), () {
            _gotoDetal();
          });
        },
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 3),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(
                          50)),
                      child: Image.asset(
                        'images/user_img01.png', width: ScreenUtil().setWidth(
                          96),
                        height: ScreenUtil().setWidth(96),),
                    ),
                    Text('张三', style: TextStyle(fontSize: ScreenUtil().setWidth(
                        28)),)
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: ScreenUtil().setWidth(630),
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(20),
                        bottom: ScreenUtil().setWidth(10),
                        left: ScreenUtil().setWidth(20)),
                    margin: EdgeInsets.only(top: ScreenUtil().setWidth(10),
                      right: ScreenUtil().setWidth(10),
                      bottom: ScreenUtil().setWidth(10),),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(
                          width: 1, color: Colors.black12)),
                    ),
                    child: Column(
                      children: [
                        Row(children: [
                          Image.asset('images/icon_addres_start.png',
                              width: ScreenUtil().setWidth(40),
                              height: ScreenUtil().setWidth(40)),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: ScreenUtil().setWidth(10),),
                            width: ScreenUtil().setWidth(300),
                            child: Text('上海市闵行区顾戴路上海市闵行区顾戴路上海市闵行区顾戴路',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setWidth(28)),),
                          )
                        ],),
                        Container(
                          margin: EdgeInsets.only(
                            top: ScreenUtil().setWidth(30),),
                          child: Row(children: [
                            Image.asset('images/icon_addres_end.png',
                                width: ScreenUtil().setWidth(40),
                                height: ScreenUtil().setWidth(40)),
                            Container(
                              width: ScreenUtil().setWidth(300),
                              child: Text('上海市闵行区顾戴路上海市闵行区顾戴路上海市闵行区顾戴路',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: ScreenUtil().setWidth(28)),),
                            )
                          ],),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10, top: 25,
                    child: SizedBox(
                        width: 80,
                        height: 32,
                        child:
                        FittedBox(
                          fit: BoxFit.fitHeight,
                          child: FlatButton(
                            child: Text('货源详情', style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(36))),
                            color: Colors.pink,
                            onPressed: () {
                              showToast('进入货源详情', backgroundColor: Colors.pink,
                                  time: 1);
                              Future.delayed(Duration(seconds: 2), () {
                                _gotoDetal();
                              });
                            },),
                        )
                    ),
                  )
                ],
              )
            ],
          ),
      ),
    );
  }

  Widget _listBottom() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(100), bottom: ScreenUtil().setWidth(10)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 3),
            child: Row(children: [
              Icon(Icons.alarm, size: 14,),
              Container(
//              width: ScreenUtil().setWidth(300),
                constraints: BoxConstraints(
                    maxWidth: ScreenUtil().setWidth(300)),
                child: Text('货物类型货物类型货物类型货物类型',
                  style: TextStyle(fontSize: ScreenUtil().setWidth(24)),
                  overflow: TextOverflow.ellipsis,),
              ),
              Container(
                width: ScreenUtil().setWidth(300),
                child: Text('2020-12-23 10:00:00 ',
                  style: TextStyle(fontSize: ScreenUtil().setWidth(24)),
                  overflow: TextOverflow.ellipsis,),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(top: 3),
            child: Row(children: [
              Icon(Icons.child_friendly, size: 14,),
              Container(
//              width: ScreenUtil().setWidth(300),
                constraints: BoxConstraints(
                    maxWidth: ScreenUtil().setWidth(300)),
                child: Text('货物类型:',
                  style: TextStyle(fontSize: ScreenUtil().setWidth(24)),
                  overflow: TextOverflow.ellipsis,),
              ),
              Container(
                width: ScreenUtil().setWidth(300),
                child: Text('服装、饮料   5吨',
                  style: TextStyle(fontSize: ScreenUtil().setWidth(24)),
                  overflow: TextOverflow.ellipsis,),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.only(top: 3),
            child: Row(children: [
              Icon(Icons.airport_shuttle, size: 14,),
              Container(
//              width: ScreenUtil().setWidth(300),
                constraints: BoxConstraints(
                    maxWidth: ScreenUtil().setWidth(300)),
                child: Text('车辆需求:',
                  style: TextStyle(fontSize: ScreenUtil().setWidth(24)),
                  overflow: TextOverflow.ellipsis,),
              ),
              Container(
                width: ScreenUtil().setWidth(300),
                child: Text('5米 平板车   20吨',
                  style: TextStyle(fontSize: ScreenUtil().setWidth(24)),
                  overflow: TextOverflow.ellipsis,),
              ),
            ]),
          ),
        ],
      ),
    );
  }


//Widget _goodsList() {
//  return Container(
////    child: ,
//  );
//}

//下拉部分
  Widget _selectedBox(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
//            _selectedItem('送：','全国'),
//            _selectedItem('达：','全国'),
//            _selectedItem('','智能排序'),
//            _selectedItem('','筛选'),
          _selectedItem2([
            '全国',
            '北京',
            '上海',
            '安徽',
            '河南',
            '湖北',
            '湖南',
            '江苏',
            '山东',
            '广东',
            '江西',
            '四川',
            '云南',
            '贵州',
            '广西',
            '陕西',
            '内蒙',
            '山西',
            '新疆',
            '西藏',
            '黑龙江'
          ], _mySelection1, changeFn: changeFn1),
          _selectedItem2([
            '上海',
            '北京',
            '安徽',
            '河南',
            '湖北',
            '湖南',
            '江苏',
            '山东',
            '广东',
            '江西',
            '四川',
            '云南',
            '贵州',
            '广西',
            '陕西',
            '内蒙',
            '山西',
            '新疆',
            '西藏',
            '黑龙江'
          ], _mySelection2, changeFn: changeFn2),
          _selectedItem2(['智能排序'], _mySelection3),
          _selectedItem2(
              ['筛选', '接单时间', '发布时间'], _mySelection4, changeFn: changeFn4),
        ],
      ),
    );
  }

  _selectedItem2(lists, selected, {changeFn}) {
    List<DropdownMenuItem<String>> ListsItems = [];

    lists.forEach((item) {
      ListsItems.add(DropdownMenuItem(
          value: item, child: Text(item, overflow: TextOverflow.ellipsis,)));
    });
//    ListsItems.add(DropdownMenuItem(value: '价格降序价格降序', child: Text('价格降序价格降序')));
//    ListsItems.add(DropdownMenuItem(value: '价格降序', child: Text('价格降序')));
//    ListsItems.add(DropdownMenuItem(value: '价格升序', child: Text('价格升序')));
    return Container(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selected,
          items: ListsItems,
          onChanged: (newVal) {
//            setState(() {
//              selected = newVal;
//            });
//            print(selected);
            changeFn(newVal);
          },
        ),
      ),
    );
  }

  Widget _selectedItem(prx, s) {
    var selectedValue = '666';

    return Container(

      child: Row(
        children: [
          Container(
            child: Text(selectedValue),
          ),
          Text(s),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.keyboard_arrow_down),
          )
        ],
      ),
    );
  }




}

