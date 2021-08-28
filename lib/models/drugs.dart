import 'package:alen/models/pharmacy.dart';

class Drugs {
  String id;
  String name;
  String dosage;
  String madein;
  String quantity;
  String root;
  bool trending;
  String image;
  String category;
  String category_image;
  Pharmacies pharmacies;
  num price;

  Drugs(
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
      this.category_image, this.price});
}
