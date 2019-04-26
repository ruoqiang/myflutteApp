import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/count.dart';
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
//    final currentCounter = Provide.value<Counter>(context);
    return SingleChildScrollView (
      child: Container(
          child:Column(
            children: <Widget>[
              Text('search'),
              SizedBox.fromSize(
//              width: 200.0,
//              height: 300.0,
                child: const Card(child: Text('Hello World!')),
              ),
              Container(
                color: Colors.black,
                child: Transform(
                  alignment: Alignment.topRight,
                  transform: Matrix4.skewX(0.1)..rotateZ(-45),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: const Color(0xFFE8581C),
                    child: const Text('Apartment for rent!_____________'),
                  ),
                ),
              ),
              Container(
                child: SizedBox(
                  width: 250,
                  height: 450,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 250,
                        height: 250,
                        color: Colors.pinkAccent,
                        child: Text('ddd'),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        padding: EdgeInsets.all(5.0),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.black.withAlpha(0),
                              Colors.black12,
                              Colors.lightBlue
                            ],
                          ),
                        ),
                        child: Text(
                          "Foreground Text",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      Positioned(
                        left: 55.0,
                        right: 35.0,
                        top: 25.0,
                        child: new Text(
                          'Whatever is worth doing is worth doing well. ๑•ิ.•ั๑',
                          style: new TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'serif',
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints.expand(
                          height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 200.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.teal.shade700,
                        alignment: Alignment.center,
                        child: Text('Hello World', style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white)),
                        foregroundDecoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://www.example.com/images/frame.png'),
                            centerSlice: Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                          ),
                        ),
                        transform: Matrix4.rotationZ(0.1),
                      ),
                    ],
                  ),
                ),
              ),
        RaisedButton(
          onPressed: Provide.value<Counter>(context).increment,
          child: Text("浮动按钮"),
          color: Colors.red,
          textColor: Colors.white,
          splashColor: Colors.black,

        ),
              Provide<Counter>(
                builder: (context, child, counter) => Text('${counter.value}'),
              ),
            ],
          )

      ),
    );
  }
}
