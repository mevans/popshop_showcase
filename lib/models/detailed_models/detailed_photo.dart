class DetailedPhoto {
  String venue;
  String title;
  String image;
  String thumbnail;
  String thumbnailWide;
  String thumbnailTall;
  String src;
  int w;
  int h;
  int height;
  int width;
  int sortOrder;
  String modifiedAt;

  DetailedPhoto(
      {this.venue,
      this.title,
      this.image,
      this.thumbnail,
      this.thumbnailWide,
      this.thumbnailTall,
      this.src,
      this.w,
      this.h,
      this.height,
      this.width,
      this.sortOrder,
      this.modifiedAt});

  DetailedPhoto.fromJson(Map<String, dynamic> json) {
    venue = json['venue'];
    title = json['title'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    thumbnailWide = json['thumbnail_wide'];
    thumbnailTall = json['thumbnail_tall'];
    src = json['src'];
    w = json['w'];
    h = json['h'];
    height = json['height'];
    width = json['width'];
    sortOrder = json['sort_order'];
    modifiedAt = json['modified_at'];
  }
}
