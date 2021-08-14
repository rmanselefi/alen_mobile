import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/Services/PharmacistsServices.dart';

import '../MyImagesList.dart';

class Pharmacy implements ImporterPharmacy{

  @override
  String detail;

  @override
  List<String> imagesList;

  @override
  String info;

  @override
  String location;

  @override
  String name;

  @override
  String officeHours;

  @override
  String phone;

  @override
  List<PharmacyServices> services;

  @override
  String title;

  Pharmacy(
      this.phone,this.title,this.name, this.detail, this.imagesList, this.officeHours, this.services, this.info, this.location);

  static List<Pharmacy> pharmacies = [
    Pharmacy(
      "0900000000",
      "Pharmacy",
      "Pharmacy 1",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
          "sed do eiusmod tempor incididunt ut labore et dolore"
          "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
          "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
          "consequat. Duis aute irure dolor in reprehenderit in voluptate"
          " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
          "sint occaecat cupidatat non proident, sunt in culpa qui officia "
          "deserunt mollit anim id est laborum.",
      MyImagesList.imageList,
      '10:45-9:00',
        PharmacyServices.pharmacyServices,
        "I work on this this",
       "Some location",
    ),
    Pharmacy(
      "0900000001",
      "Pharmacy",
      "Pharmacy 2",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
          "sed do eiusmod tempor incididunt ut labore et dolore"
          "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
          "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
          "consequat. Duis aute irure dolor in reprehenderit in voluptate"
          " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
          "sint occaecat cupidatat non proident, sunt in culpa qui officia "
          "deserunt mollit anim id est laborum.",
      MyImagesList.imageList,
      '10:45-9:00',
      PharmacyServices.pharmacyServices,
      "I work on this this",
      "Some location",
    ),
    Pharmacy(
      "0900000002",
      "Pharmacy",
      "Pharmacy 3",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
          "sed do eiusmod tempor incididunt ut labore et dolore"
          "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
          "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
          "consequat. Duis aute irure dolor in reprehenderit in voluptate"
          " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
          "sint occaecat cupidatat non proident, sunt in culpa qui officia "
          "deserunt mollit anim id est laborum.",
      MyImagesList.imageList,
      '10:45-9:00',
      PharmacyServices.pharmacyServices,
      "I work on this this",
      "Some location",
    ),
    Pharmacy(
      "0900000003",
      "Pharmacy",
      "Pharmacy 4",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
          "sed do eiusmod tempor incididunt ut labore et dolore"
          "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
          "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
          "consequat. Duis aute irure dolor in reprehenderit in voluptate"
          " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
          "sint occaecat cupidatat non proident, sunt in culpa qui officia "
          "deserunt mollit anim id est laborum.",
      MyImagesList.imageList,
      '10:45-9:00',
      PharmacyServices.pharmacyServices,
      "I work on this this",
      "Some location",
    ),
    Pharmacy(
      "0900000004",
      "Pharmacy",
      "Pharmacy 5",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
          "sed do eiusmod tempor incididunt ut labore et dolore"
          "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
          "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
          "consequat. Duis aute irure dolor in reprehenderit in voluptate"
          " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
          "sint occaecat cupidatat non proident, sunt in culpa qui officia "
          "deserunt mollit anim id est laborum.",
      MyImagesList.imageList,
      '10:45-9:00',
      PharmacyServices.pharmacyServices,
      "I work on this this",
      "Some location",
    ),
  ];
}
