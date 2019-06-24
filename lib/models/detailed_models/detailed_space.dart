import 'package:popshop/models/detailed_models/detailed_photo.dart';
import 'package:popshop/models/neighborhood.dart';

class DetailedSpace {
  String id;
  String name;
  String slug;
  String about;
  int totalAreaSqFt;
  List<String> idealFor;
  List<String> amenities;
  double pricePerDay;
  int minDays;
  double pricePerWeek;
  double pricePerMonth;
  double serviceCost;
  double cleaningCost;
  double securityDeposit;
  String address;
  Neighborhood neighborhood;
  int totalSlots;
  List<DetailedPhoto> photos;
  String floorPlanImage;
  String modifiedAt;
  bool isPublished;
  bool isCrowdsource;
  int totalRevenueCents;
  Null totalRevenueCentsYtd;
  Null totalRevenueCentsMonth;
  Null totalRevenueCentsWeek;

  DetailedSpace(
      {this.id,
      this.name,
      this.slug,
      this.about,
      this.totalAreaSqFt,
      this.idealFor,
      this.amenities,
      this.pricePerDay,
      this.minDays,
      this.pricePerWeek,
      this.pricePerMonth,
      this.serviceCost,
      this.cleaningCost,
      this.securityDeposit,
      this.address,
      this.neighborhood,
      this.totalSlots,
      this.photos,
      this.floorPlanImage,
      this.modifiedAt,
      this.isPublished,
      this.isCrowdsource,
      this.totalRevenueCents,
      this.totalRevenueCentsYtd,
      this.totalRevenueCentsMonth,
      this.totalRevenueCentsWeek});

  DetailedSpace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    about = json['about'];
    totalAreaSqFt = json['total_area_sq_ft'];
    if (json["ideal_for"] != null) {
      idealFor = new List<String>();
      json["ideal_for"].forEach((v) {
        idealFor.add(v);
      });
    }
    if (json['amenities'] != null) {
      amenities = new List<String>();
      json['amenities'].forEach((v) {
        amenities.add(v);
      });
    }
    pricePerDay = double.parse(json['price_per_day'] ?? "0");
    minDays = json["min_days"] ?? 0;
    pricePerWeek = double.parse(json['price_per_week'] ?? "0");
    pricePerMonth = double.parse(json['price_per_month'] ?? "0");
    serviceCost = double.parse(json['service_cost'] ?? "0");
    cleaningCost = double.parse(json['cleaning_cost'] ?? "0");
    securityDeposit = double.parse(json['security_deposit'] ?? "0");
    address = json['address'];
    neighborhood = json['neighborhood'] != null
        ? new Neighborhood.fromJson(json['neighborhood'])
        : null;
    totalSlots = json['total_slots'];
    if (json['photos'] != null) {
      photos = new List<DetailedPhoto>();
      json['photos'].forEach((v) {
        photos.add(new DetailedPhoto.fromJson(v));
      });
    }
    floorPlanImage = json['floor_plan_image'];
    modifiedAt = json['modified_at'];
    isPublished = json['is_published'];
    isCrowdsource = json['is_crowdsource'];
    totalRevenueCents = json['total_revenue_cents'];
    totalRevenueCentsYtd = json['total_revenue_cents_ytd'];
    totalRevenueCentsMonth = json['total_revenue_cents_month'];
    totalRevenueCentsWeek = json['total_revenue_cents_week'];
  }
}
