import 'package:flutter/material.dart';

class Switcher extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onPressed;
  final String value;

  Switcher(this.items, {this.onPressed, this.value});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items.map((s) {
          bool selected = s == value;
          bool first = items.first == s;
          bool last = items.last == s;
          return InkWell(
            onTap: () => onPressed(s),
            borderRadius: first
                ? BorderRadius.only(
                topLeft: Radius.circular(100),
                bottomLeft: Radius.circular(100))
                : (last
                ? BorderRadius.only(
                topRight: Radius.circular(100),
                bottomRight: Radius.circular(100))
                : null),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: selected ? Color(0xff263238) : null,
                  border: Border.all(
                      color: selected ? Color(0xff263238) : Color(0xffd9d9d9)),
                  borderRadius: first
                      ? BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100))
                      : (last
                          ? BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100))
                          : null)),
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 200),
                style: TextStyle(
                    color: selected ? Colors.white : Color(0xff8c8e8f),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500),
                child: Text(
                  s,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
