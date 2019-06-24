class DetailedCoverImage {
  String title;
  String image;
  String thumbnail;
  int height;
  int width;
  int sortOrder;
  String modifiedAt;

  DetailedCoverImage(
      {this.title,
      this.image,
      this.thumbnail,
      this.height,
      this.width,
      this.sortOrder,
      this.modifiedAt});

  DetailedCoverImage.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    height = json['height'];
    width = json['width'];
    sortOrder = json['sort_order'];
    modifiedAt = json['modified_at'];
  }
}
