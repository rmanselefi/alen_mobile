
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/pharmacy.dart';

class TrendingSearchable {
  String id;
  String itemId;
  String title;
  String image;
  String description;
  SearchType searchType;
  Type type;


  TrendingSearchable({this.id, this.title, this.itemId, this.description, this.image, this.searchType, this.type});
}
