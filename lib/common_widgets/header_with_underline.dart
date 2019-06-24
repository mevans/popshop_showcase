import 'package:flutter/material.dart';

class HeaderWithUnderline extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final double lineMargin;
  final double lineWidth;
  final double lineHeight;

  HeaderWithUnderline(this.text,
      {this.lineMargin = 6,
        this.lineHeight = 1,
        this.lineWidth = 50,
        this.textStyle = const TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: "Montserrat",
            fontSize: 14,
            color: Color(0xff263238))});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          text,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
        Align(
          child: Container(
            margin: EdgeInsets.only(top: lineMargin),
            height: lineHeight,
            width: lineWidth,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
