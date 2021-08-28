import 'package:alen/ui/ServiceCategory/Service.dart';
import '../MyImagesList.dart';

class HospitalServices {
  String name;
  String imagePath;
  String detail;
  List<Service> services;

  HospitalServices(this.name, this.imagePath, this.detail, this.services);

  static List<HospitalServices> hospitalServices = [
    HospitalServices(
        "ENT",
        MyImagesList.HopSer1.elementAt(0),
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        // Service.services
      []
    ),
    HospitalServices(
        "Surgery",
        MyImagesList.HopSer2.elementAt(0),
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        // Service.services2
      []
    ),
    HospitalServices(
        "Dental",
        MyImagesList.HopSer3.elementAt(0),
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        // Service.services3
      []
    ),
    HospitalServices(
        "Internal Medicine",
        MyImagesList.HopSer4.elementAt(0),
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        // Service.services4
      []
    ),
    HospitalServices(
        "Psycytry",
        MyImagesList.HopSer5.elementAt(0),
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        // Service.services5
      []
    )
  ];
}
