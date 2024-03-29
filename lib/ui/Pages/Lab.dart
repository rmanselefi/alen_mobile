import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import '../MyImagesList.dart';

class Lab implements HospitalLabDiagnosis{

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

  Lab(
      this.title,this.name, this.detail, this.imagesList, this.officeHours, this.services, this.info, this.location, this.phone);

  static List<Lab> labs = [
    Lab(
        "Lab",
        "Lab 1",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        MyImagesList.labsImages,
        '10:45-9:00',
        HospitalServices.hospitalServices,
        "I work on this this",
        "Some location",
        "0900000000"
    ),
    Lab(
        "Lab",
        "Lab 2",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        MyImagesList.labsImages2,
        '10:45-9:00',
        HospitalServices.hospitalServices,
        "I work on this this",
        "Some location",
        "0900000001"
    ),
    Lab(
        "Lab",
        "Lab 3",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        MyImagesList.labsImages3,
        '10:45-9:00',
        HospitalServices.hospitalServices,
        "I work on this this",
        "Some location",
        "0900000002"
    ),
    Lab(
        "Lab",
        "Lab 4",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        MyImagesList.labsImages4,
        '10:45-9:00',
        HospitalServices.hospitalServices,
        "I work on this this",
        "Some location",
        "0900000003"
    ),
    Lab(
        "Lab",
        "Lab 5",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        MyImagesList.labsImages5,
        '10:45-9:00',
        HospitalServices.hospitalServices,
        "I work on this this",
        "Some location",
        "0900000004"
    ),
  ];
}
