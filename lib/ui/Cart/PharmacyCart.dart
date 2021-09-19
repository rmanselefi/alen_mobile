import 'package:alen/models/cart.dart';
import 'package:alen/providers/cart.dart';
import 'package:alen/ui/Details/DetailForCartDrug.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PharmacyCart extends StatefulWidget {

  @override
  _PharmacyCartState createState() => _PharmacyCartState();
}

class _PharmacyCartState extends State<PharmacyCart> {

  static const myCustomColors = AppColors();
  var cartProvider;
  @override
  Widget build(BuildContext coontext) {
    cartProvider = Provider.of<CartProvider>(coontext);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: myCustomColors.loginBackgroud,
            title: Text("Pharmacy Cart"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(coontext, false),
            )),
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
              Container(
                  child: FutureBuilder<List<Cart>>(
                      future: cartProvider.getMyPharmaCartDrugs(""),//TODO add the user id after login
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none &&
                            snapshot.hasData == null) {
                          return Container(
                              height: MediaQuery.of(context).size.height,
                              child:
                              Center(child: CircularProgressIndicator()));
                        }
                        if (snapshot.data == null) {
                          return Container(
                            height: MediaQuery.of(context).size.height,
                              child:
                              Center(child: CircularProgressIndicator()));
                        } else {
                          return snapshot.data.length==0?Container(
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: Text(
                                "No items available."
                              ),
                            ),
                          )
                              :
                          Column(
                            children: [
                              Container(
                                child: Center(
                                  child:StatefulBuilder(  // You need this, notice the parameters below:
                                      builder: (BuildContext context, StateSetter setState) {
                                        return Text(
                                          // "Total price : "+totalPrice.toStringAsFixed(2),
                                          "Total price : "+CartProvider.totalPrice.toStringAsFixed(2),
                                          textScaleFactor: 2.5,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: myCustomColors.loginBackgroud
                                          ),
                                          maxLines: 3,
                                        );
                                      }),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 30,
                                    horizontal: 15
                                ),
                              ),
                              GridView.builder(
                                gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 2 / 3.7,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  add(
                                      snapshot.data[index].amount,
                                      num.parse(snapshot.data[index].drug.price)
                                  );
                                  return _buildCategoriesListItem(
                                      snapshot.data[index], ctxt, "",coontext);
                                },
                                itemCount: snapshot.data.length,
                              )
                            ],
                          );
                        }
                      })),
            ])));
  }
  _buildCategoriesListItem(var category, BuildContext ctxt, String id, BuildContext coontext) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailForCartDrug(
                      cart: category,
                      id: id,
                      isPharma: true,
                    coontext: coontext,
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
                height: 150,
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.network(category.drug.image,
                      width: 150, height: 150, fit: BoxFit.fill),
                ),
              ),
            ),
            Text(
              category.drug.name,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "price : "+category.getTotalPrice().toString(),
              maxLines: 2,
              // style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: 120,
              height: 25,
              child: ElevatedButton(
                  onPressed: (){
                    Provider.of<CartProvider>(context, listen: false).deleteDrugFromCart(category);
                    Navigator.pop(coontext);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PharmacyCart()
                        )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Remove "
                      ),
                      Icon(
                          Icons.remove_shopping_cart
                      )
                    ],
                  )
              ),
            )
          ],
        ));
  }

  num totalPrice=0;
  void add(num price, num amount){
    num product=price*amount;
    totalPrice+=product;
    print("Total price: $totalPrice");
  }
}

