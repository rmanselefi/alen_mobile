import 'package:alen/models/pharmacy.dart';
import 'package:alen/providers/drug.dart';

class NewDrugs {
  String id;
  String name;
  String dosage;
  String madein;
  String quantity;
  String root;
  bool trending;
  String image;
  Category category;
  double price;
  Pharmacies pharmacies;

  NewDrugs(
      {this.trending,
        this.id,
        this.name,
        this.quantity,
        this.dosage,
        this.madein,
        this.root,
        this.pharmacies,
        this.image,
        this.category,
      this.price});
}
