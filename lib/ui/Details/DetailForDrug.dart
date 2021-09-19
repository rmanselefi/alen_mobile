import 'package:alen/models/cart.dart';
import 'package:alen/models/drugs.dart';
import 'package:alen/providers/cart.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DetailForDrug extends StatefulWidget {
  final Drugs drug;
  final String id;
  final bool isPharma;

  DetailForDrug({this.drug, this.id, this.isPharma});
  @override
  _DetailForDrugState createState() => _DetailForDrugState();
}

class _DetailForDrugState extends State<DetailForDrug> {
  static const myCustomColors = AppColors();
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, false);
            }),
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
                      child: Image.network(widget.drug.image,
                          width: 200, height: 120, fit: BoxFit.fill),
                    ),

                    Container(
                        padding: EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                              widget.drug.name,
                              textAlign: TextAlign.center,
                              textScaleFactor: 2,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.03,
                          0,
                          MediaQuery.of(context).size.width * 0.03,
                          10),
                      child: ElevatedButton(
                        onPressed: () {
                          addToCart(context, "abcd");
                          print("Added");
                          //addProduct(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AddDrugs(
                          //           hospitalLabDiagnosis:
                          //           widget.pharmacy,
                          //           index: 0,
                          //         )));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(
                                myCustomColors.loginBackgroud),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: myCustomColors
                                            .loginBackgroud)))),
                        child: Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Add To Cart',
                                  textScaleFactor: 1.5,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Icon(
                                    Icons.add_shopping_cart,
                                    size: 30,
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                              "Category : " + widget.drug.category,
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
                                    widget.drug.dosage,
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
                                      widget.drug.madein,
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
                                    widget.drug.quantity,
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
                                      widget.drug.root,
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
                                    widget.drug.price.toString(),
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
                                        (widget.drug.trending) ? "Yes" : "No",
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
                                        value: widget.drug.trending,
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

  addToCart(BuildContext ctxt, String userId) async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    int amount=1;
    return showDialog(
        context: ctxt,
        builder: (context) {
          return StatefulBuilder(  // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
                // _setState = setState;
                return AlertDialog(
                  title: Text('Add ${widget.drug.name} to your cart?'),
                  content: SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 30,bottom: 10),
                                child:SizedBox(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width*0.8,
                                    child: Image.network(
                                      widget.drug.image,
                                      fit: BoxFit.fill,
                                    )
                                )),
                            Text("How much would you want?"),
                            Form(
                              key: _formKey,
                              child: Column(children: [
                                Container(
                                    child: Center(
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0, bottom: 0.0),
                                            width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                            child: TextFormField(
                                              autocorrect: true,
                                              maxLength: 10,
                                              maxLines: 1,
                                              keyboardType: TextInputType.number,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Amount is required!';
                                                }
                                                if (value == '') {
                                                  return 'Please provide how much you want';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                setState(() {
                                                  amount=num.parse(value).toInt();
                                                  print("on save text");
                                                  print("Amount : $amount");
                                                });
                                              },
                                              onChanged: (value) {
                                                setState(() {

                                                });
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Amount in number',
                                                labelText: 'Amount',
                                                labelStyle: TextStyle(
                                                    color: myCustomColors
                                                        .loginBackgroud),
                                                counterStyle: TextStyle(
                                                    color: Colors.white54),
                                                prefixIcon: Icon(
                                                  MdiIcons.numeric,
                                                  color: myCustomColors.loginBackgroud,
                                                ),
                                                hintStyle: TextStyle(
                                                    color: myCustomColors
                                                        .loginBackgroud),
                                                filled: true,
                                                fillColor: Colors.white,
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(40.0)),
                                                  borderSide: BorderSide(
                                                      color: myCustomColors
                                                          .loginBackgroud,
                                                      width: 2),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(40.0)),
                                                  borderSide: BorderSide(
                                                      color: Colors.green,
                                                      width: 2),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(40.0)),
                                                  borderSide: BorderSide(
                                                      color: Colors.green,
                                                      width: 2),
                                                ),
                                              ),
                                            )))),
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new ElevatedButton(
                        child: new Center(
                          child: Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.add_shopping_cart_rounded),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Add')
                                  ])),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              Navigator.of(context).pop();
                              if(amount!=0){
                                var cartProvider = Provider.of<CartProvider>(context, listen: false);
                                widget.isPharma?
                                cartProvider.addNewDrugToCart(widget.drug, userId, amount)
                                    :
                                cartProvider.addNewDrugToImporterCart(widget.drug, userId, amount);
                              }
                            }

                          }
                          );
                        })
                  ],
                );
              });
        });
  }
}
