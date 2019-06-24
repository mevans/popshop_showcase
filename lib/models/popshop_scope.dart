import 'package:flutter/material.dart';
import 'package:popshop/data/database_helper.dart';
import 'package:popshop/models/user.dart';
import 'package:popshop/screens/auth/auth_screen.dart';
import 'package:popshop/screens/communities_list/communities_list_page.dart';
import 'package:scoped_model/scoped_model.dart';

class PopshopScope extends Model {
  User user;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  PopshopScope({this.user});

  void login(User user, BuildContext context) async {
    this.user = user;
    await databaseHelper.saveUser(user);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => CommunitiesListPage()),
            (r) => false);
  }

  void logout(BuildContext context) async {
    this.user = null;
    await databaseHelper.deleteUsers();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (ctx) => AuthScreen(authType: AuthType.LOGIN,)),
            (r) => false);
  }

  static PopshopScope of(BuildContext context) =>
      ScopedModel.of<PopshopScope>(context);
}
