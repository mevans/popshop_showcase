import 'dart:async';

import 'package:latlong/latlong.dart';
import 'package:popshop/models/community.dart';
import 'package:popshop/models/detailed_models/detailed_community.dart';
import 'package:popshop/models/detailed_models/detailed_event.dart';
import 'package:popshop/models/detailed_models/detailed_space.dart';
import 'package:popshop/models/event.dart';
import 'package:popshop/models/space.dart';
import 'package:popshop/models/user.dart';
import 'package:popshop/utils/network_util.dart';

class RestDatasource {
  NetworkUtil _netUtil = NetworkUtil();
  static final baseURL = "https://www.popshop.com/popshopapiv1/";
  static final loginURL = baseURL + "auth/login";

  Future<User> login(String email, String password) {
    print("Logging in with $email $password");
    return _netUtil.post(loginURL,
        body: {"email": email, "password": password}).then((dynamic res) {
      print("res: $res");
      if (res["error"] != null) {
        throw Exception(res["error"]);
      }
      if (res["errors"] != null) {
        throw Exception(res["errors"][0]["message"]);
      }
      return User.fromJson(res);
    });
  }

  Future<User> signup(String brandName, String email, String password) {
    return _netUtil.post("${baseURL}auth/register", body: {
      "brand_name": brandName,
      "email": email,
      "password": password,
    }).then((dynamic res) {
      if (res["error"] != null) {
        throw Exception(res["error"]);
      }
      if (res["errors"] != null) {
        throw Exception(res["errors"][0]["message"]);
      }
      return User.fromJson(res);
    });
  }

  Future<User> getCurrentUser(String token) {
    return _netUtil.get(baseURL + "me",
        headers: {"Authorization": "Token $token"}).then((dynamic res) {
      print(res);
      if (res["error"] != null) {
        throw Exception(res["error"]);
      }
      if (res["errors"] != null) {
        throw Exception(res["errors"][0]["message"]);
      }
      return User.fromJson(res)
        ..authToken = token;
    });
  }

  Future<List<Space>> getSpaces({int page, String search}) async {
    List<Space> spaces = [];
    var r =
    await _netUtil.get("${baseURL}venue_list?page=$page&search=$search");
    var parsed = r["results"] as List;
    parsed.forEach((d) {
      spaces.add(Space.fromJson(d));
    });
    return spaces;
  }

  Future<List<Community>> getCommunities({int page, String category}) async {
    List<Community> communities = [];
    var r = await _netUtil.get(
        "${baseURL}vendor_list?page=$page${category != "All Brands"
            ? "&category=$category"
            : ""}");
    var parsed = r["results"] as List;
    parsed.forEach((d) {
      communities.add(Community.fromJson(d));
    });
    return communities;
  }

  Future<List<Event>> getEvents() async {
    List<Event> events = [];
    var r = await _netUtil.get("${baseURL}events");
    var parsed = r["results"] as List;
    parsed.forEach((d) {
      Event newEvent = Event.fromJson(d);
      events.add(newEvent);
//      print(events.length);
    });
//    print(events.length);
    return events;
  }

  Future<LatLng> coordinatesFromAddress(String address) async {
    var r = await _netUtil.get(
        "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=AIzaSyB68DCbonYpNKG5qcVQqyE1L_SSk9wYhdk");
    Map<String, dynamic> m = Map<String, dynamic>.from(r);
    LatLng latLng = LatLng(
        m["results"][0]["geometry"]["location"]["lat"] as double,
        m["results"][0]["geometry"]["location"]["lng"] as double);
    return latLng;
  }

  Future<DetailedEvent> getDetailedEvent({String id}) async {
    var r = await _netUtil.get("${baseURL}events/$id");
    return DetailedEvent.fromJson(r);
  }

  Future<DetailedCommunity> getDetailedCommunity({String id}) async {
    var r = await _netUtil.get("${baseURL}vendors/$id");
    return DetailedCommunity.fromJson(r);
  }

  Future<DetailedSpace> getDetailedSpace({String id}) async {
    var r = await _netUtil.get("${baseURL}venues/$id");
    return DetailedSpace.fromJson(r);
  }

  Future<List<DetailedEvent>> getUpcomingEvents({String id}) async {
    List<DetailedEvent> events = [];
    var r = await _netUtil.get("${baseURL}events?kind=upcoming&venue_id=$id");
//    print(r);
//    List<dynamic> l = r["results"];
//    print(l);
    r["results"].forEach((s) {
//      print(s);
      events.add(DetailedEvent.fromJson(s));
    });
    return events;
  }
}
