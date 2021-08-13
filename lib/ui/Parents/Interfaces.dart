import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:alen/ui/Services/PharmacistsServices.dart';

abstract class ImporterPharmacy {
  String title;
  String name;
  String detail;
  List<String> imagesList;
  String officeHours;
  List<PharmacyServices> services;
  String info;
  String location;
  String phone;

  ImporterPharmacy(
      this.phone,this.title,this.name, this.detail, this.imagesList, this.officeHours, this.services, this.info, this.location);
}
abstract class HospitalLabDiagnosis {
  String title;
  String name;
  String detail;
  List<String> imagesList;
  String officeHours;
  List<HospitalServices> services;
  String info;
  String location;
  String phone;

  HospitalLabDiagnosis(
      this.phone,this.title,this.name, this.detail, this.imagesList, this.officeHours, this.services, this.info, this.location);
}