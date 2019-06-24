class VendorProfile {
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
  List<String> photos;

  VendorProfile(
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
      this.photos});

  VendorProfile.fromJson(Map<String, dynamic> json) {
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
      photos = new List<String>();
      json['photos'].forEach((v) {
        photos.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['brand_name'] = this.brandName;
    data['category'] = this.category;
    data['about'] = this.about;
    data['logo'] = this.logo;
    data['logo_small'] = this.logoSmall;
    data['brand_slug'] = this.brandSlug;
    data['website_url'] = this.websiteUrl;
    data['twitter_url'] = this.twitterUrl;
    data['instagram_url'] = this.instagramUrl;
    data['facebook_url'] = this.facebookUrl;
    data['snapchat_url'] = this.snapchatUrl;
    data['linkedin_url'] = this.linkedinUrl;
    data['budget_points'] = this.budgetPoints;
    data['photos'] = this.photos;
    return data;
  }
}
