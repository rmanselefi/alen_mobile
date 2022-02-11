import 'package:alen/models/hospital.dart';
import 'package:alen/models/pharmacy.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/pharmacy.dart';

class Importers implements Search, HospitalsLabsDiagnostics , ImportersPharmacies{

  Importers(
      {this.type,
        this.Id,
        this.locationName,
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
        this.email,
        this.searchType,
        this.hospitalsLabsDiagnostics,
        this.isPharma
      });

  @override
  String Id;

  @override
  bool isPharma;


  @override
  DateTime createdAt;

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
  String locationName;

  @override
  SearchType searchType;

  @override
  HospitalsLabsDiagnostics hospitalsLabsDiagnostics;
}
