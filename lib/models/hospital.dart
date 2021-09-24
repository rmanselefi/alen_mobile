import 'package:alen/providers/pharmacy.dart';

class Hospitals implements HospitalsLabsDiagnostics{


  Hospitals(
      {this.Id,
        this.type,
        this.locationName,
        this.name,
        this.phone,
        this.createdAt,
        this.latitude,
        this.description,
        this.longitude,
        this.distance,
        this.image,
        this.services,this.trending,this.officehours, this.email, this.images,this.creditedDate,this.shopCredit});

  @override
  String Id;

  @override
  DateTime createdAt;

  @override
  DateTime creditedDate;

  @override
  String description;

  @override
  double distance;

  @override
  String email;

  @override
  String image;

  @override
  List images;

  @override
  double latitude;

  @override
  double longitude;

  @override
  String name;

  @override
  String officehours;

  @override
  String phone;

  @override
  List services;

  @override
  String shopCredit;

  @override
  bool trending;

  @override
  Type type;

  @override
  String locationName;
}

abstract class HospitalsLabsDiagnostics{
  String email;
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
  List<dynamic> images;
  DateTime creditedDate;
  String shopCredit;
  String locationName;
  Type type;

  HospitalsLabsDiagnostics(
      this.email,
      this.Id,
  this.locationName,
      this.name,
      this.latitude,
      this.longitude,
      this.phone,
      this.description,
      this.distance,
      this.image,
      this.createdAt,
      this.officehours,
      this.trending,
      this.services,
      this.images,
      this.creditedDate,
      this.type,
      this.shopCredit);
}
