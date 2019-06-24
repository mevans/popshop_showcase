import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String url;
  final String tag;
  final String title;

  FullScreenImage(this.url, {this.tag, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(title ?? ""),
      ),
      body: Hero(
        tag: tag ?? "",
        child: Align(
          child: Image.network(url),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
