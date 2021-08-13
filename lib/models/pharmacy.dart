class Pharmacies {
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

  Pharmacies(
      {this.Id,
      this.name,
      this.phone,
      this.createdAt,
      this.latitude,
      this.description,
      this.longitude,
      this.distance,
      this.image,
      this.officehours});
}
