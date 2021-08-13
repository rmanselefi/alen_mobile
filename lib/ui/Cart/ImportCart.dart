
import 'package:alen/ui/Cart/CategoryWithAmount.dart';
import 'package:alen/ui/Details/DetailForImp.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';


class ImportCart extends StatefulWidget {

  @override
  _ImportCartState createState() => _ImportCartState();
}

class _ImportCartState extends State<ImportCart> {

  static const myCustomColors = AppColors();
  static List<CategoryWithAmount> importerCart = CategoryWithAmount.importCart;
  double totalPrice=0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: myCustomColors.mainBackground),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: myCustomColors.loginBackgroud,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context, false),
              ),
              title: Text(
                  "Importer Cart"
              ),
            ),
            body: SingleChildScrollView(
                child: Stack(
                    children: <Widget>[
                      Container(
                          child: importerCart.length == 0
                              ?  Container(
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.4),
                              child:Center(
                                child: Text(
                                  "No Items Available in your Importer cart.",
                                ),
                              ))
                              : Column(
                            children: [
                              Container(

                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Total Price : ",
                                        textScaleFactor: 2,
                                        style: TextStyle(
                                            color: myCustomColors.loginButton,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        _calculateTotalAmount().toStringAsFixed(2),
                                        textScaleFactor: 2,
                                        style: TextStyle(
                                            color: myCustomColors.loginButton,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              GridView.builder(
                                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: (MediaQuery.of(context).orientation == Orientation.portrait) ? 2/3.5 : 2/3.2,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return _buildCategoriesListItem(
                                      importerCart[index], ctxt, index);
                                },
                                itemCount: importerCart.length,
                              )
                            ],
                          )
                      ),
                    ]))
        )
    );
  }
  _buildCategoriesListItem(CategoryWithAmount category, BuildContext ctxt,int index) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailForImp(
                    name: category.category.name,
                    description: category.category.detail,
                    imageUrl: category.category.imagePath,
                    price: category.category.price,
                  )));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              clipBehavior: Clip.hardEdge,
              child: Container(
                width: 150,
                height: 180,
                child: SizedBox(
                  height: 180,
                  width: 150,
                  child: Image.asset(category.category.imagePath,
                      width: 150, height: 180, fit: BoxFit.fill),
                ),
              ),
            ),
            Text(
              category.category.name,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                child:Text(
                  "Amount : ",
                  maxLines: 2,
                  textScaleFactor: 1.1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
            ),
            Container(
                child:Text(
                  category.amount.toString(),
                  maxLines: 2,
                  textScaleFactor: 1.1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
            ),
          ],
        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    child:Text(
                      "Price : ",
                      maxLines: 2,
                      textScaleFactor: 1.1,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                ),
                Container(
                    child:Text(
                      (category.category.price*category.amount).toString(),
                      maxLines: 2,
                      textScaleFactor: 1.1,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                ),
              ],
            ),
            Container(
              width: 120,
                child:ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      myCustomColors.loginButton),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(
                        color: Colors.white
                      ))),
                onPressed: (){
                  removeFromCart(context,category,index);
                  // Navigator.pop(context);
                  // print("Poped");
                  //   CategoryWithAmount.pharmacyCart.removeAt(index);
                  // print("Removed");
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       // builder: (context) => ListInServices()
                  //         builder: (context) => ImportCart()
                  //     ));
                  // print("Rendered");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart_rounded
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Remove"
                    )
                  ],
                )
            ))
          ],
        )
    );
  }
  double _calculateTotalAmount(){
    totalPrice=0;
    importerCart.forEach((element) {
      totalPrice+=element.getTotalPriceInDouble();
    });
    return totalPrice;
  }
  CalculatePrice() {}
  removeFromCart(BuildContext ctxt,CategoryWithAmount categoryWithAmount, int index) async {
    int amount=1;
    return showDialog(
        context: ctxt,
        builder: (context) {
          return StatefulBuilder(  // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
                // _setState = setState;
                return AlertDialog(
                  title: Text('Are you sure you want to remove ${categoryWithAmount.category.name} from your cart?'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 30,bottom: 10),
                          child:SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Image.asset(
                                categoryWithAmount.category.imagePath,
                                fit: BoxFit.fill,
                              )
                          )),
                      Row(
                        children: [
                          Text("Amount : "),
                          Text(categoryWithAmount.amount.toString())
                        ],
                      ),
                      Row(
                        children: [
                          Text("Price : "),
                          Text(
                            categoryWithAmount.getTotalPrice()
                          )
                        ],
                      )
                    ],
                  ),
                  actions: <Widget>[
                    new ElevatedButton(
                        child: new Center(
                          child: Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.remove_shopping_cart_rounded),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Remove')
                                  ])),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            print(index);

                            CategoryWithAmount.importCart.remove(categoryWithAmount);
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      // builder: (context) => ListInServices()
                                        builder: (context) => ImportCart()
                                    ));
                            // Navigator.pop(context);
                            // if(amount!=0){
                            //   CategoryWithAmount.pharmacyCart.add(
                            //       CategoryWithAmount(
                            //           Category(
                            //               name,
                            //               image,
                            //               widget.description,
                            //               widget.price
                            //           ),
                            //           amount
                            //       )
                            //   );
                            // }
                          }
                          );
                        })
                  ],
                );
              });
        });
  }
}
