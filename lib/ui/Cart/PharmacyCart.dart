import 'package:alen/providers/cart.dart';
import 'package:alen/providers/language.dart';
import 'package:alen/ui/Details/DetailForCartDrug.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PharmacyCart extends StatefulWidget {
  const PharmacyCart({Key key}) : super(key: key);

  @override
  _PharmacyCartState createState() => _PharmacyCartState();
}
class _PharmacyCartState extends State<PharmacyCart> {
  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext coontext) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    return LoaderOverlay(
      child:
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
      appBar: AppBar(
        backgroundColor: myCustomColors.loginBackgroud,
        title: Text("Pharmacy Cart"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(coontext, false),
        ),
      ),
      body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    FutureBuilder<List<CartDrug>>(
                        future: cartProvider.getPharmacyDrugFromLocalCart() ,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.none &&
                              snapshot.hasData == null) {
                            return CircularProgressIndicator();
                          }
                          print(
                              'project snapshot data is: ${snapshot.data}');
                          if (snapshot.data == null) {
                            return Container(
                                child: Center(
                                    child:
                                    CircularProgressIndicator()));
                          } else {
                            if(snapshot.data.length==0){
                              return Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.45  ),
                                child: Center(
                                  child: Text(
                                      "You have no item in your Pharmacy cart"
                                  ),
                                ),
                              );
                            }
                            else{
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    // width: 190.0,
                                      margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                      child:ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return _buildCategoriesListItem(
                                              snapshot.data[index], ctxt, coontext);
                                        },
                                        itemCount: snapshot.data.length,
                                      )),
                                  FutureBuilder<num>(
                                      future: cartProvider.getPharmacyTotalPayment() ,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.none &&
                                            snapshot.hasData == null) {
                                          return CircularProgressIndicator();
                                        }
                                        print(
                                            'project snapshot data is: ${snapshot.data}');
                                        if (snapshot.data == null) {
                                          return Container(
                                              child: Center(
                                                  child:
                                                  CircularProgressIndicator()));
                                        } else {
                                          return Container(
                                            padding: EdgeInsets.symmetric(horizontal: 40),
                                            child: Center(
                                                child:Text(
                                                  "Total price : "+snapshot.data.toString(),
                                                  textScaleFactor: 2,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                            ),
                                          );
                                        }
                                      }),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.1,
                                        20,
                                        MediaQuery.of(context).size.width * 0.1,
                                        30),
                                    child: ElevatedButton(
                                      onPressed: () async {

                                        var prefs = await SharedPreferences.getInstance();
                                        String userId = prefs.getString('user_id');
                                        num result = await cartProvider.finalizePharmacyCart(userId);

                                        var snackBar;
                                        result==1? snackBar = SnackBar(
                                          content: const Text('✓ Successfully ordered.'),
                                          backgroundColor: myCustomColors.loginBackgroud,
                                        ):result==2?snackBar = SnackBar(
                                          content: const Text('Your order has already been registered.'),
                                          backgroundColor: myCustomColors.loginButton,
                                        ):snackBar = SnackBar(
                                          content: const Text('Order Failed! Please check your internet connection.'),
                                          backgroundColor: myCustomColors.loginButton,
                                        );

                                        ScaffoldMessenger.of(coontext).showSnackBar(snackBar);
                                        // addToCart(context, "abcd");
                                        // print("Added");
                                        // //addProduct(context);
                                        // // Navigator.push(
                                        // //     context,
                                        // //     MaterialPageRoute(
                                        // //         builder: (context) => AddDrugs(
                                        // //           hospitalLabDiagnosis:
                                        // //           widget.pharmacy,
                                        // //           index: 0,
                                        // //         )));
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
                                                'Buy all cart Items',
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

                                ],
                              );
                            }
                          }
                        }),
                  ],
                ),
              )
            ],
          )),
    );
    }
    }),
    );
  }
  _buildCategoriesListItem(CartDrug cartItem, BuildContext ctxt, BuildContext coontext) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailForCartDrug(
                      cart: cartItem,
                      isPharma: true,
                      isOther: false,
                      coontext: coontext
                  )));
        },
        child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child : Column(
              children: <Widget>[
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(cartItem.drug.image),
                  ),
                  title: Text(cartItem.drug.name),
                  subtitle: Text("Price : ${(num.parse(cartItem.drug.price) * cartItem.amount).toStringAsFixed(2)} Birr"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_forever_rounded),
                    onPressed: (){
                      var cartProvider = Provider.of<CartProvider>(ctxt, listen: false);
                      cartProvider.deletePharmacyDrugToLocalCart(cartItem);
                      Navigator.pop(coontext);
                      Navigator.push(
                          ctxt,
                          MaterialPageRoute(
                              builder: (context) => PharmacyCart(
                              )));
                    },
                  ),
                ),
                Divider()
              ],
            )
        )
    );
  }
}


