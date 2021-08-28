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
        Pharmacy.pharmacies.elementAt(1).services.elementAt(1).name,
        Pharmacy.pharmacies.elementAt(1).services.elementAt(1).imagePath,
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
        Importer.importers.elementAt(3).services.elementAt(3).name,
        Importer.importers.elementAt(3).services.elementAt(3).imagePath,
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
        Pharmacy.pharmacies.elementAt(4).services.elementAt(4).name,
        Pharmacy.pharmacies.elementAt(4).services.elementAt(4).imagePath,
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
        Importer.importers.elementAt(2).services.elementAt(2).name,
        Importer.importers.elementAt(2).services.elementAt(2).imagePath,
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
        Pharmacy.pharmacies.elementAt(2).services.elementAt(2).name,
        Pharmacy.pharmacies.elementAt(2).services.elementAt(2).imagePath,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
      Pharmacy.pharmacies.elementAt(2),
        Pharmacy.pharmacies.elementAt(2).services.elementAt(2)
    ),

    Trending(
        Pharmacy.pharmacies.elementAt(3).services.elementAt(3).name,
        Pharmacy.pharmacies.elementAt(3).services.elementAt(3).imagePath,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        Pharmacy.pharmacies.elementAt(3),
        Pharmacy.pharmacies.elementAt(3).services.elementAt(3)
    ),
    Trending(
        Importer.importers.elementAt(1).services.elementAt(1).name,
        Importer.importers.elementAt(1).services.elementAt(1).imagePath,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        Importer.importers.elementAt(1),
        Importer.importers.elementAt(1).services.elementAt(1)
    ),
    Trending(
        Pharmacy.pharmacies.elementAt(0).services.elementAt(0).name,
        Pharmacy.pharmacies.elementAt(0).services.elementAt(0).imagePath,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        Pharmacy.pharmacies.elementAt(0),
        Pharmacy.pharmacies.elementAt(0).services.elementAt(0)
    ),
    Trending(
        Importer.importers.elementAt(4).services.elementAt(4).name,
        Importer.importers.elementAt(4).services.elementAt(4).imagePath,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        Importer.importers.elementAt(4),
        Importer.importers.elementAt(4).services.elementAt(4)
    ),
    Trending(
        Pharmacy.pharmacies.elementAt(3).services.elementAt(3).name,
        Pharmacy.pharmacies.elementAt(3).services.elementAt(3).imagePath,
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
            "sed do eiusmod tempor incididunt ut labore et dolore"
            "\ magna aliqua. Ut enim ad minim veniam, quis nostrud "
            "xercitation ullamco laboris nisi ut aliquip ex ea commodo "
            "consequat. Duis aute irure dolor in reprehenderit in voluptate"
            " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
            "sint occaecat cupidatat non proident, sunt in culpa qui officia "
            "deserunt mollit anim id est laborum.",
        Pharmacy.pharmacies.elementAt(3),
        Pharmacy.pharmacies.elementAt(3).services.elementAt(3)
    )
  ];
}
