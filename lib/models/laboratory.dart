class Laboratories {
  String Id;
  String name;
  double latitude;
  double longitude;
  String phone;
  String description;
  double distance;
  String image;
  String officehours;
  DateTime createdAt;
  List<dynamic> images;
  String email;

  Laboratories(
      {this.Id,
        this.name,
        this.phone,
        this.createdAt,
        this.latitude,
        this.description,
        this.longitude,
        this.distance,
        this.image,
        this.officehours,
        this.images,
        this.email});
}
