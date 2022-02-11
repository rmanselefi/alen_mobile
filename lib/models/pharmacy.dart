import 'package:alen/models/hospital.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/pharmacy.dart';

class Pharmacies implements Search, HospitalsLabsDiagnostics , ImportersPharmacies{
  @override
  String Id;

  @override
  DateTime createdAt;

  @override
  String description;

  @override
  String locationName;

  @override
  double distance;

  @override
  String email;

  @override
  String image;

  @override
  List images;
  @override
  List drugs;
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

  Pharmacies(
      {this.type,this.Id,
        this.createdAt,
        this.description,
        this.distance,
        this.locationName,
        this.email,
        this.image,
        this.images,
        this.latitude,
        this.longitude,
        this.name,
        this.officehours,
        this.phone,
        this.drugs,
        this.isPharma,
        this.searchType,
        this.hospitalsLabsDiagnostics
      });

  @override
  bool isPharma;

  @override
  Type type;

  @override
  DateTime creditedDate;

  @override
  List services;

  @override
  String shopCredit;

  @override
  bool trending;

  @override
  SearchType searchType;

  @override
  HospitalsLabsDiagnostics hospitalsLabsDiagnostics;
}
abstract class ImportersPharmacies{
  Type type;
  String Id;
  String name;
  double latitude;
  double longitude;
  String phone;
  String locationName;
  String description;
  double distance;
  String image;
  String officehours;
  DateTime createdAt;
  List<dynamic> images;
  bool isPharma;
  String email;

  ImportersPharmacies(
      this.type,
      this.Id,
      this.name,
      this.latitude,
      this.longitude,
      this.phone,
      this.description,
      this.distance,
  this.locationName,
      this.image,
      this.officehours,
      this.createdAt,
      this.images,
      this.isPharma,
      this.email);
}