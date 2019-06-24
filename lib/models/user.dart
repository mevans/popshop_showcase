//class User {
//  User(this._token, this._id,);
//
//  User.map(dynamic obj) {
//    print(obj);
//    this._token = obj["auth_token"];
//    this._id = obj["id"];
//  }
//
//  String _id;
//  String _token;
//
// //id: 694c8239-ad09-4950-b2e6-6f3762146e98, first_name: , last_name: , email: sean@popshop.com, vendor_profile: null,
// //last_login: 2019-01-28T20:39:18.730742Z, is_shopkeeper: true, stripe_connected: false,
// //auth_token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2F1dGhlbnRpY2F0aW9uX2lkIjoiNjk0YzgyMzktYWQwOS00OTUwLWIyZTYtNmYzNzYyMTQ2ZTk4In0.prXFsfVeEs1OLFLKC2RRuvm0_zXjgogqxwUD8lsEMx4}
//
//  String get token => _token;
//
//  String get id => _id;
//
//
//  Map<String, dynamic> toMap() {
//    var map = Map<String, dynamic>();
//    map["token"] = _token;
//    map["id"] = _id;
//    return map;
//  }
//
//    User.fromMap(Map<String, dynamic> map) {
//    this._token = map["token"];
//    this._id = map["id"];
//  }
//}
import 'package:popshop/models/vendor_profile.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  VendorProfile vendorProfile;
  String lastLogin;
  bool isShopkeeper;
  bool stripeConnected;
  String authToken;

  User({this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.vendorProfile,
    this.lastLogin,
    this.isShopkeeper,
    this.stripeConnected,
    this.authToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    vendorProfile = json['vendor_profile'] != null
        ? new VendorProfile.fromJson(json['vendor_profile'])
        : null;
    lastLogin = json['last_login'];
    isShopkeeper = json['is_shopkeeper'];
    stripeConnected = json['stripe_connected'];
    authToken = json['auth_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    if (this.vendorProfile != null) {
      data['vendor_profile'] = this.vendorProfile.toJson();
    }
    data['last_login'] = this.lastLogin.toString();
    data['is_shopkeeper'] = this.isShopkeeper;
    data['stripe_connected'] = this.stripeConnected;
    data['auth_token'] = this.authToken;
    return data;
  }
}