class Community {
  String id;
  String slug;
  String brandName;
  String category;
  String about;
  String logoSmall;
  String websiteUrl;
  String brandThumbnail;
  String logo;

  Community(
      {this.id,
      this.slug,
      this.brandName,
      this.category,
      this.about,
      this.logoSmall,
      this.websiteUrl,
        this.brandThumbnail,
        this.logo});

  Community.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    brandName = json['brand_name'];
    category = json['category'];
    about = json['about'];
    logoSmall = json['logo_small'];
    websiteUrl = json['website_url'];
    brandThumbnail = json['brand_thumbnail'];
    logo = json["logo"];
  }
}
