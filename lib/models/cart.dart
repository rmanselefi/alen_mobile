import 'package:alen/models/drugs.dart';
import 'package:alen/models/newDrug.dart';
import 'package:alen/models/pharmacy.dart';

class UserCart{
  String userId;
  List<Map<String, NewDrugs>> importerCart;
  List<Map<String, NewDrugs>> pharmacyCart;

  UserCart({this.userId, this.pharmacyCart, this.importerCart});

}

class Cart{
  String id;
  Drugs drug;
  int amount;

  Cart({this.id, this.drug, this.amount});

  String getTotalPrice(){
    return (double.parse(drug.price)*amount).toStringAsFixed(2);
  }
  double getTotalPriceInDouble(){
    return double.parse(drug.price)*amount;
  }
}