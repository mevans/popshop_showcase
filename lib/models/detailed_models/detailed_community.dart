import 'package:popshop/models/detailed_models/detailed_photo.dart';

class DetailedCommunity {
  String id;
  String slug;
  String brandName;
  String category;
  String about;
  String logo;
  String logoSmall;
  String brandSlug;
  String websiteUrl;
  String twitterUrl;
  String instagramUrl;
  String facebookUrl;
  String snapchatUrl;
  String linkedinUrl;
  String budgetPoints;
  List<DetailedPhoto> photos;
  String brandThumbnail;

  DetailedCommunity(
      {this.id,
      this.slug,
      this.brandName,
      this.category,
      this.about,
      this.logo,
      this.logoSmall,
      this.brandSlug,
      this.websiteUrl,
      this.twitterUrl,
      this.instagramUrl,
      this.facebookUrl,
      this.snapchatUrl,
      this.linkedinUrl,
      this.budgetPoints,
      this.photos,
      this.brandThumbnail});

  DetailedCommunity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    brandName = json['brand_name'];
    category = json['category'];
    about = json['about'];
    logo = json['logo'];
    logoSmall = json['logo_small'];
    brandSlug = json['brand_slug'];
    websiteUrl = json['website_url'];
    twitterUrl = json['twitter_url'];
    instagramUrl = json['instagram_url'];
    facebookUrl = json['facebook_url'];
    snapchatUrl = json['snapchat_url'];
    linkedinUrl = json['linkedin_url'];
    budgetPoints = json['budget_points'];
    if (json['photos'] != null) {
      photos = new List<DetailedPhoto>();
      json['photos'].forEach((v) {
        photos.add(new DetailedPhoto.fromJson(v));
      });
    }
    brandThumbnail = json['brand_thumbnail'];
  }
}
