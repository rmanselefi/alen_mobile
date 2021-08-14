import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:alen/ui/Services/PharmacistsServices.dart';

import '../MyImagesList.dart';

class Diagnosis implements HospitalLabDiagnosis{

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
  List<HospitalServices> services;

  @override
  String title;

  Diagnosis(
      this.title,this.name, this.detail, this.imagesList, this.officeHours, this.services, this.info, this.location, this.phone);

  static List<Diagnosis> diagnosises = [
    Diagnosis(
      "Diagnosis",
        "Diagnosis 1",
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
        HospitalServices.hospitalServices,
        "I work on this this",
        "Some location",
        "0900000000"
    ),
    Diagnosis(
        "Diagnosis",
        "Diagnosis 2",
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
        HospitalServices.hospitalServices,
        "I work on this this",
        "Some location",
        "0900000001"
    ),
    Diagnosis(
        "Diagnosis",
        "Diagnosis 3",
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
        HospitalServices.hospitalServices,
        "I work on this this",
        "Some location",
        "0900000002"
    ),
    Diagnosis(
        "Diagnosis",
        "Diagnosis 4",
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
        HospitalServices.hospitalServices,
        "I work on this this",
        "Some location",
        "0900000003"
    ),
    Diagnosis(
        "Diagnosis",
        "Diagnosis 5",
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
        HospitalServices.hospitalServices,
        "I work on this this",
        "Some location",
        "0900000004"
    ),
  ];
}
