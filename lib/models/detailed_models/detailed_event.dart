import 'package:popshop/models/detailed_models/detailed_community.dart';
import 'package:popshop/models/detailed_models/detailed_cover_image.dart';
import 'package:popshop/models/detailed_models/detailed_photo.dart';
import 'package:popshop/models/detailed_models/detailed_space.dart';
import 'package:popshop/models/event.dart';

class DetailedEvent {
  String id;
  String slug;
  DateTime startDate;
  DateTime endDate;
  int totalDays;
  int totalSlots;
  int slotsLeft;
  String status;
  Pricing pricing;
  DetailedSpace space;
  List<DetailedCommunity> vendors;
  DetailedCoverImage coverImage;
  DateTime modifiedAt;
  List<DetailedPhoto> photos;

  DetailedEvent({
    this.id,
    this.slug,
    this.startDate,
    this.endDate,
    this.totalDays,
    this.totalSlots,
    this.slotsLeft,
    this.status,
    this.pricing,
    this.space,
    this.vendors,
    this.coverImage,
    this.modifiedAt,
    this.photos,
  });

  DetailedEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    startDate = DateTime.parse(json['start_date']);
    endDate = DateTime.parse(json['end_date']);
    totalDays = json['total_days'];
    totalSlots = json['total_slots'];
    slotsLeft = json['slots_left'];
    status = json['status'];
    pricing =
        json['pricing'] != null ? new Pricing.fromJson(json['pricing']) : null;
    space = json['venue'] != null
        ? new DetailedSpace.fromJson(json['venue'])
        : null;
    if (json['vendors'] != null) {
      vendors = new List<DetailedCommunity>();
      json['vendors'].forEach((v) {
        vendors.add(new DetailedCommunity.fromJson(v));
      });
    }
    coverImage = json['cover_image'] != null
        ? new DetailedCoverImage.fromJson(json['cover_image'])
        : null;
    modifiedAt = DateTime.parse(json['modified_at']);
    if (json['photos'] != null) {
      photos = new List<DetailedPhoto>();
      json['photos'].forEach((v) {
        photos.add(new DetailedPhoto.fromJson(v));
      });
    }
  }
}
