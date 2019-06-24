class Neighborhood {
  String id;
  String name;
  String city;
  String about;
  String modifiedAt;

  Neighborhood({this.id, this.name, this.city, this.about, this.modifiedAt});

  Neighborhood.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    about = json['about'];
    modifiedAt = json['modified_at'];
  }
}