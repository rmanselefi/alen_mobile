class Diagnostics {
  String Id;
  String name;
  double latitude;
  double longitude;
  String dname;
  String officehours;
  String price;
  String procedureTime;
  String image;
  double distance;
  String phone;
  DateTime createdAt;
  String description;
  List<dynamic> images;
  String email;

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
      this.officehours,
        this.description,
      this.createdAt,
        this.images,this.phone,
        this.email
      });
}
