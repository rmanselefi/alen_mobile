class Diagnostics {
  String Id;
  String name;
  double latitude;
  double longitude;
  String dname;
  String workingHours;
  String price;
  String procedureTime;
  String image;
  double distance;
  DateTime createdAt;
  Diagnostics(
      {this.latitude,
      this.image,
      this.distance,
      this.longitude,
      this.Id,
      this.name,
      this.price,
      this.dname,
      this.procedureTime,
      this.workingHours,
      this.createdAt});
}
