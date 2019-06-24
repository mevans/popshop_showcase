import 'package:popshop/models/neighborhood.dart';

class Venue {
  String id;
  String name;
  String slug;
  String about;
  String address;
  Neighborhood neighborhood;
  String mapImages;

  Venue(
      {this.id,
      this.name,
      this.slug,
      this.about,
      this.address,
      this.neighborhood,
      this.mapImages});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    about = json['about'];
    address = json['address'];
    neighborhood = json['neighborhood'] != null
        ? new Neighborhood.fromJson(json['neighborhood'])
        : null;
    mapImages = json['map_images'];
  }
}
