
import 'package:alen/ui/ServiceCategory/Category.dart';

class CategoryWithAmount {
  Category category;
  int amount;

  CategoryWithAmount(this.category, this.amount);

  String getTotalPrice(){
    return (category.price*amount).toStringAsFixed(2);
  }
  double getTotalPriceInDouble(){
    return category.price*amount;
  }

  static List<CategoryWithAmount> pharmacyCart = [

  ];

  static List<CategoryWithAmount> importCart = [

  ];


}
