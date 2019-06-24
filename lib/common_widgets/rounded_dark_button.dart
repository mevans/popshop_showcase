import 'package:flutter/material.dart';

class RoundedDarkButton extends StatelessWidget {
  final double textSize;
  final String text;
  final VoidCallback onTap;
  final Widget child;

  const RoundedDarkButton(
      {Key key, this.textSize = 14, this.text, this.onTap, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff263238),
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Center(
              child: child == null ? Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400,
                fontSize: textSize),
              ) : child),
        ),
      ),
    );
  }
}
