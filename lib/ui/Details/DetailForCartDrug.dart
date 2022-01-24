import 'package:alen/models/cart.dart';
import 'package:alen/models/drugs.dart';
import 'package:alen/providers/cart.dart';
import 'package:alen/providers/language.dart';
import 'package:alen/ui/Cart/ImportCart.dart';
import 'package:alen/ui/Cart/ImportCart.dart';
import 'package:alen/ui/Cart/PharmacyCart.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailForCartDrug extends StatefulWidget {
  final CartDrug cart;
  final bool isPharma;
  final bool isOther;
  final BuildContext coontext;

  DetailForCartDrug({this.cart, this.isPharma, this.coontext, this.isOther});
  @override
  _DetailForCartDrugState createState() => _DetailForCartDrugState();
}

class _DetailForCartDrugState extends State<DetailForCartDrug> {
  static const myCustomColors = AppColors();
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return
    FutureBuilder<dynamic>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return CircularProgressIndicator();
          }
          print('project snapshot data is: ${snapshot.data}');
          if (snapshot.data == null) {
            return Container(
                child: Center(child: CircularProgressIndicator()));
          } else {
            var _myLanguage = snapshot.data.getString("lang");
            var languageProvider = Provider.of<LanguageProvider>(context, listen: true);
            languageProvider.langOPT = _myLanguage;
            return Scaffold(
              appBar: widget.isOther?
              AppBar(
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context, false);
                    }),
              ):AppBar(
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context, false);
                    }),
                actions: [
                  IconButton(
                    padding: EdgeInsets.only(right: 15),
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(widget.coontext);
                      if(widget.isPharma)
                      {
                        Provider.of<CartProvider>(context, listen
                            : false).deletePharmacyDrugToLocalCart(widget.cart);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PharmacyCart()
                            )
                        );
                      }
                      else {
                        var cartProvider = Provider.of<CartProvider>(context, listen: false);
                        cartProvider.deleteImporterDrugToLocalCart(widget.cart);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImportCart()
                            )
                        );}

                    },
                    icon: Icon(
                        Icons.remove_shopping_cart
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 200,
                              width: 350,
                              child: Image.network(widget.cart.drug.image,
                                  width: 200, height: 120, fit: BoxFit.contain,errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                    return Image.asset("assets/images/hos1.jpg",
                                      width: 200,
                                      height: 120,
                                      fit: BoxFit.cover,);
                                  }),
                            ),

                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child: Text(
                                      widget.cart.drug.name,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 2,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ))),
                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child: Text(
                                      "Category : " + widget.cart.drug.category,
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 1.7,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 30, top: 10),
                                          child: Text(
                                            'Dosage',
                                            textScaleFactor: 1.7,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 30, top: 15),
                                          child: Text(
                                            widget.cart.drug.dosage,
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            textScaleFactor: 1.7,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ]),
                                ),
                                Container(
                                    padding: EdgeInsets.only(right: 30),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                            EdgeInsets.only(right: 30, top: 10),
                                            child: Text(
                                              'Madein',
                                              textScaleFactor: 1.7,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                            EdgeInsets.only(right: 30, top: 15),
                                            child: Text(
                                              widget.cart.drug.madein,
                                              textAlign: TextAlign.left,
                                              maxLines: 3,
                                              textScaleFactor: 1.7,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ]))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 30, top: 10),
                                          child: Text(
                                            'Quantity',
                                            textScaleFactor: 1.7,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 20, top: 15),
                                          child: Text(
                                            widget.cart.drug.quantity,
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            textScaleFactor: 1.7,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ]),
                                ),
                                Container(
                                    padding: EdgeInsets.only(right: 50),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                            EdgeInsets.only(right: 30, top: 10),
                                            child: Text(
                                              'Root',
                                              textScaleFactor: 1.7,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                            EdgeInsets.only(right: 30, top: 15),
                                            child: Text(
                                              widget.cart.drug.root,
                                              textAlign: TextAlign.left,
                                              maxLines: 3,
                                              textScaleFactor: 1.7,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ]))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 30, top: 10),
                                          child: Text(
                                            'Price',
                                            textScaleFactor: 1.7,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 35, top: 15),
                                          child: Text(
                                            widget.cart.drug.price.toString(),
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            textScaleFactor: 1.7,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ]),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 35),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(right: 20, top: 10),
                                          child: Text(
                                            'Trending',
                                            textScaleFactor: 1.7,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding:
                                              EdgeInsets.only(right: 20, top: 15),
                                              child: Text(
                                                (widget.cart.drug.trending) ? "Yes" : "No",
                                                textAlign: TextAlign.left,
                                                maxLines: 3,
                                                textScaleFactor: 1.7,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                              EdgeInsets.only(right: 20, top: 15),
                                              child: Checkbox(
                                                value: widget.cart.drug.trending,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    // widget.drug.trending = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ]),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                  EdgeInsets.only(right: 20, top: 15),
                                  child: Text(
                                    "Amount in Cart : ",
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    textScaleFactor: 1.7,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Container(
                                    padding:
                                    EdgeInsets.only(right: 20, top: 15),
                                    child: Text(
                                      widget.cart.amount.toString(),
                                      textAlign: TextAlign.left,
                                      maxLines: 3,
                                      textScaleFactor: 1.7,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Container(
                                    padding:
                                    EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05, top: 15),
                                    width: MediaQuery.of(context).size.width*0.35,
                                    child: Text(
                                      "Ordered From : ",
                                      textAlign: TextAlign.left,
                                      maxLines: 3,
                                      textScaleFactor: 1.7,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    child: Container(
                                      padding:
                                      EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05, top: 15),
                                      width: MediaQuery.of(context).size.width*0.50,
                                      child: Text(
                                        widget.cart.importer.name,
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        textScaleFactor: 1.7,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            );
          }
        });
  }
}
