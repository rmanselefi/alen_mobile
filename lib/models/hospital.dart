import 'package:alen/ui/Services/HospitalServices.dart';

class Hospitals {
  String Id;
  String name;
  double latitude;
  double longitude;
  String phone;
  String description;
  double distance;
  String image;
  DateTime createdAt;
  String officehours;
  bool trending;
  List<dynamic> services;

  Hospitals(
      {this.Id,
      this.name,
      this.phone,
      this.createdAt,
      this.latitude,
      this.description,
      this.longitude,
      this.distance,
      this.image,
      this.services,this.trending,this.officehours});
}
