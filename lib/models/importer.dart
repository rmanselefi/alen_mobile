import 'package:alen/models/pharmacy.dart';

class Importers implements ImportersPharmacies{

  Importers(
      {this.Id,
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
}
