import 'package:alen/models/pharmacy.dart';

class Drugs {
  String id;
  String itemId;
  String name;
  String dosage;
  String madein;
  String quantity;
  String root;
  bool trending;
  String image;
  String category;
  String category_image;
  ImportersPharmacies pharmacies;
  String price;

  Drugs(
      {this.trending,
        this.id,
        this.itemId,
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
