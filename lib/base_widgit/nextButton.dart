import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final String text;
  final void Function() ButtonClick;

  const NextButton({Key key, this.text, this.ButtonClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 40, bottom: 20),
            padding: EdgeInsets.only(left: 15, right: 15),
            height: 40,
            child: RaisedButton(
              color: Color(0xff2D4ED1),
              onPressed: () {
                ButtonClick();
//                goToNextPage();
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) {
//                  return UserBaseInfoPage();
//                }),
//              );
              },
//            textColor: Color(0xff2D4ED1),
              child: Text(
                text, style: TextStyle(fontSize: 16, color: Colors.white),),
            ),
          ),
        )
      ],
    );
  }


}
