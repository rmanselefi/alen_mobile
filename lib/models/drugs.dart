import 'package:alen/models/hospital.dart';
import 'package:alen/models/pharmacy.dart';
import 'package:alen/providers/pharmacy.dart';

class Drugs implements HospitalsLabsDiagnostics {
  String id;
  String itemId;
  String name;
  String dosage;
  String madein;
  String quantity;
  String root;
  bool trending;
  String image;
  String category;
  String category_image;
  ImportersPharmacies pharmacies;
  String price;
  Type type;

  Drugs(
      {this.trending,
        this.type,
        this.id,
        this.itemId,
        this.name,
        this.quantity,
        this.dosage,
        this.madein,
        this.root,
        this.pharmacies,
        this.image,
        this.description,
        this.locationName,
        this.category,
        this.category_image, this.price});

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
  List images;

  @override
  double latitude;

  @override
  double longitude;

  @override
  String officehours;

  @override
  String phone;

  @override
  List services;

  @override
  String shopCredit;

  @override
  String locationName;
}

abstract class everything{
  Type type;
}
