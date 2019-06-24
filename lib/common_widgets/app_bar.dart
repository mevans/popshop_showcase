import 'package:flutter/material.dart';
import 'package:popshop/screens/menu/menu_page.dart';

class PopshopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  PopshopAppBar({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      backgroundColor: Color(0xff32c3ce),
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(
              builder: (ctx) => MenuPage(), fullscreenDialog: true,));
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
