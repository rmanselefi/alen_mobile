import 'package:alen/ui/Pages/Importer.dart';
import 'package:alen/ui/Pages/Pharmacy.dart';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/Services/PharmacistsServices.dart';

class Trending {
  String name;
  String imagePath;
  String detail;
  ImporterPharmacy importerPharmacy;
  PharmacyServices category;

  Trending(this.name, this.imagePath, this.detail, this.importerPharmacy, this.category);

  static List<Trending> trendings = [
    Trending(
        "Trending 1",
        'assets/images/hos1.jpg',
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
      Pharmacy.pharmacies.elementAt(1),
        Pharmacy.pharmacies.elementAt(1).services.elementAt(1)
    ),
    Trending(
        "Trending 2",
        'assets/images/hos2.jpg',
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        Importer.importers.elementAt(3),
        Importer.importers.elementAt(3).services.elementAt(3)
    ),
    Trending(
        "Trending 3",
        'assets/images/hos3.jpg',
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        Pharmacy.pharmacies.elementAt(4),
        Pharmacy.pharmacies.elementAt(4).services.elementAt(4)
    ),
    Trending(
        "Trending 4",
        'assets/images/hos1.jpg',
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        Importer.importers.elementAt(2),
        Importer.importers.elementAt(2).services.elementAt(2)
    ),
    Trending(
        "Trending 5",
        'assets/images/hos2.jpg',
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
      Pharmacy.pharmacies.elementAt(4),
        Pharmacy.pharmacies.elementAt(4).services.elementAt(4)
    )
  ];
}
