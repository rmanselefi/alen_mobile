
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
    CategoryWithAmount(
        Category.categories.first,
      4
    ),
    CategoryWithAmount(
        Category.categories.elementAt(1),
        2
    ),
    CategoryWithAmount(
        Category.categories2.elementAt(3),
        7
    ),
    CategoryWithAmount(
        Category.categories2.elementAt(2),
        1
    ),
    CategoryWithAmount(
        Category.categories.last,
        9
    ),

  ];

  static List<CategoryWithAmount> importCart = [
    CategoryWithAmount(
        Category.categories2.first,
        1300
    ),
    CategoryWithAmount(
        Category.categories2.elementAt(1),
        220
    ),
    CategoryWithAmount(
        Category.categories.elementAt(3),
        1000
    ),
    CategoryWithAmount(
        Category.categories.elementAt(2),
        5000
    ),
    CategoryWithAmount(
        Category.categories2.last,
        10000
    ),
    CategoryWithAmount(
        Category.categories.last,
        5000
    ),
  ];


}
