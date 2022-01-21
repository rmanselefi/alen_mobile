import 'hospital.dart';
import 'package:alen/providers/pharmacy.dart';

class EmergencyMS implements HospitalsLabsDiagnostics{

  String dname;
  String price;
  String procedureTime;

  EmergencyMS(
      {this.latitude,
        this.locationName,
        this.image,
        this.distance,
        this.longitude,
        this.Id,
        this.name,
        this.type,
        this.price,
        this.dname,
        this.procedureTime,
        this.officehours,
        this.description,
        this.createdAt,
        this.images,this.phone,
        this.email
      });

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