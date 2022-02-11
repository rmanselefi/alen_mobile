import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hospitals implements Search, HospitalsLabsDiagnostics{

  List<Hospitals> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;

      return Hospitals(
          type: Type.Hospital,
          Id: snapshot.id,
          name: dataMap['name'],
          locationName: dataMap['location_name'],
          phone: dataMap['phone'],
          image: dataMap['image'],
          latitude: dataMap['location'].latitude,
          longitude: dataMap['location'].longitude,
          description: dataMap['description'],
          services: dataMap['services'],
          officehours: dataMap['officehours'],
          email: dataMap['email'],
          images: dataMap['images']
      );
    }).toList();
  }

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
        this.searchType,
        this.hospitalsLabsDiagnostics,
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

  @override
  SearchType searchType;

  @override
  HospitalsLabsDiagnostics hospitalsLabsDiagnostics;

}

abstract class HospitalsLabsDiagnostics implements Search{
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
      this.shopCredit,);
}
