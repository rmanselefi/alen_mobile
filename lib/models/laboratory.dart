import 'package:alen/providers/hospital.dart';

import 'hospital.dart';
import 'package:alen/providers/pharmacy.dart';

class Laboratories implements Search, HospitalsLabsDiagnostics{


  Laboratories(
      {this.Id,
        this.name,
        this.phone,
        this.type,
        this.locationName,
        this.createdAt,
        this.latitude,
        this.description,
        this.longitude,
        this.distance,
        this.image,
        this.officehours,
        this.images,
        this.searchType,
        this.hospitalsLabsDiagnostics,
        this.email});

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

  @override
  SearchType searchType;

  @override
  HospitalsLabsDiagnostics hospitalsLabsDiagnostics;
}
