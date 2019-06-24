import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:popshop/models/popshop_scope.dart';
import 'package:popshop/screens/communities_list/communities_list_page.dart';
import 'package:popshop/screens/events_list/events_list_page.dart';
import 'package:popshop/screens/spaces_list/spaces_page.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PopshopScope scope = PopshopScope.of(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Material(
            color: Color(0xff32c3ce),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: SafeArea(
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.8)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.circular(64)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.circular(64)),
                              contentPadding: EdgeInsets.only(
                                  left: 24, top: 16, bottom: 16, right: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(64),
                                  borderSide: BorderSide(color: Colors.white))),
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                              Border.all(color: Colors.white, width: 1.5)),
                          child: Icon(
                            Icons.clear,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 28, horizontal: 24),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
//                        "${scope.user.toJson()}",
//                        "${scope.user.vendorProfile.brandName}",// - user can also be spaceowner or service
                        "${scope.user.email}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.lightGreen),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Member Since 2015",
                            style:
                            TextStyle(fontSize: 10, color: Colors.black38),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color(0xff32c3ce), width: 1.5)),
                        child: Icon(
                          Icons.mail_outline,
                          color: Color(0xff32c3ce),
                        ),
                      ),
                      onTap: () {},
                      borderRadius: BorderRadius.circular(100),
                    ),
                    Positioned(
                      top: -5,
                      right: -5,
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: Color(0xff32c3ce), shape: BoxShape.circle),
                        child: Center(
                            child: Text(
                              "3",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => CommunitiesListPage()),
                      (r) => false);
            },
            child: Padding(
              padding: EdgeInsets.all(28),
              child: Text(
                "COMMUNITY",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Divider(
            height: 0,
          ),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => EventListPage()),
                      (r) => false);
            },
            child: Padding(
              padding: EdgeInsets.all(28),
              child: Text(
                "EVENTS",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Divider(
            height: 0,
          ),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => SpacesPage()),
                      (r) => false);
            },
            child: Padding(
              padding: EdgeInsets.all(28),
              child: Text(
                "SPACES",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Divider(
            height: 0,
          ),
          InkWell(
            onTap: () => PopshopScope.of(context).logout(context),
            child: Padding(
              padding: EdgeInsets.all(28),
              child: Text(
                "LOGOUT",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
