import 'dart:io';

import 'package:flutter/material.dart';
import 'package:popshop/data/database_helper.dart';
import 'package:popshop/screens/auth/auth_screen.dart';
import 'package:popshop/screens/communities_list/communities_list_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stripe_api/stripe_api.dart';

import 'models/popshop_scope.dart';
import 'models/user.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..maxConnectionsPerHost = 50;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  User user = await DatabaseHelper().getUser();
  Stripe.init("pk_test_qaigL6NKntfGm5HhsPCSXur5");
  runApp(LoginApp(
    user: user,
  ));
}
//
//MaterialColor limeColor() {
//  return MaterialColor(0xFF4dffba, {
//    50: Color(0xFFE1F3F8),
//    100: Color(0xFFB4E0EC),
//    200: Color(0xFF82CCE0),
//    300: Color(0xFF4FB7D4),
//    400: Color(0xFF2AA7CA),
//    500: Color(0xFF0498C1),
//    600: Color(0xFF0390BB),
//    700: Color(0xFF0385B3),
//    800: Color(0xFF027BAB),
//    900: Color(0xFF016A9E)
//  });
//}

class LoginApp extends StatefulWidget {
  final User user;

  LoginApp({this.user});

  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (n) {
          n.disallowGlow();
        },
        child: ScopedModel<PopshopScope>(
          model: PopshopScope(user: widget.user),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'popshop',
            theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Color(0xff32c3ce),
                accentColor: Color(0xff32c3ce),
                fontFamily: "Muli"),
//            home: CommunitiesListPage()
            home: widget.user == null
                ? AuthScreen(
              authType: AuthType.LOGIN,
            )
                : CommunitiesListPage(),
          ),
        ),
      ),
    );
  }
}
