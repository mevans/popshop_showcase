import 'package:popshop/models/neighborhood.dart';

class Space {
  final String id;
  final String name;
  final String thumbnailTall;
  final String about;
  final String address;

  final Neighborhood neighborhood;
  final int totalAreaSqFt;

  Space({
    this.id,
    this.name,
    this.thumbnailTall,
    this.about,
    this.address,
    this.neighborhood,
    this.totalAreaSqFt,
  });

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbnailTall: json['thumbnail_tall'] as String,
      about: json["about"] as String,
      address: json["address"] as String,
      neighborhood:
      Neighborhood.fromJson(json["neighborhood"] as Map<String, dynamic>),
      totalAreaSqFt: json["total_area_sq_ft"],
    );
  }
}
