import 'package:flutter/material.dart';

class ImageOverlayBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          decoration:
          BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
