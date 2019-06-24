import 'package:popshop/models/community.dart';
import 'package:popshop/models/venue.dart';

class Event {
  String id;
  String slug;
  DateTime startDate;
  DateTime endDate;
  int totalDays;
  int totalSlots;
  int slotsLeft;
  String status;
  Pricing pricing;
  Venue venue;
  List<Community> communities;
  String coverImage;
  String coverThumbnail;
  DateTime modifiedAt;

  Event(
      {this.id,
      this.slug,
      this.startDate,
      this.endDate,
      this.totalDays,
      this.totalSlots,
      this.slotsLeft,
      this.status,
      this.pricing,
      this.venue,
      this.communities,
      this.coverImage,
      this.modifiedAt,
      this.coverThumbnail});

  Event.fromJson(Map<String, dynamic> json) {
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
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    if (json['vendors'] != null) {
      communities = new List<Community>();
      json['vendors'].forEach((v) {
        communities.add(new Community.fromJson(v));
      });
    }
    coverImage =
        json["cover_image"] != null ? json['cover_image']["image"] : "";
    coverThumbnail =
        json["cover_image"] != null ? json['cover_image']["thumbnail"] : "";
    modifiedAt = DateTime.parse(json['modified_at']);
  }
}

class Pricing {
  double perSlotPerDay;
  String perSlotPerDayDisplay;
  double serviceCost;
  String serviceCostDisplay;
  double cleaningCost;
  String cleaningCostDisplay;
  double securityDeposit;
  String securityDepositDisplay;
  String currency;

  Pricing(
      {this.perSlotPerDay,
      this.perSlotPerDayDisplay,
      this.serviceCost,
      this.serviceCostDisplay,
      this.cleaningCost,
      this.cleaningCostDisplay,
      this.securityDeposit,
      this.securityDepositDisplay,
      this.currency});

  Pricing.fromJson(Map<String, dynamic> json) {
    perSlotPerDay = json['per_slot_per_day'];
    perSlotPerDayDisplay = json['per_slot_per_day_display'];
    serviceCost = json['service_cost'];
    serviceCostDisplay = json['service_cost_display'];
    cleaningCost = json['cleaning_cost'];
    cleaningCostDisplay = json['cleaning_cost_display'];
    securityDeposit = json['security_deposit'];
    securityDepositDisplay = json['security_deposit_display'];
    currency = json['currency'];
  }
}
