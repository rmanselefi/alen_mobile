import 'package:alen/models/hospital.dart';

class Pharmacies implements ImportersPharmacies{
  @override
  String Id;

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
      {this.Id,
        this.createdAt,
        this.description,
        this.distance,
        this.email,
        this.image,
        this.images,
        this.latitude,
        this.longitude,
        this.name,
        this.officehours,
        this.phone,this.drugs, this.isPharma});

  @override
  bool isPharma;
}
abstract class ImportersPharmacies{
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
  bool isPharma;
  String email;

  ImportersPharmacies(
      this.Id,
      this.name,
      this.latitude,
      this.longitude,
      this.phone,
      this.description,
      this.distance,
      this.image,
      this.officehours,
      this.createdAt,
      this.images,
      this.isPharma,
      this.email);
}