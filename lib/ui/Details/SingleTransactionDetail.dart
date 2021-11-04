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

class SingleTransactionDetail extends StatefulWidget {
  BatchOfCart batchOfCart;
  SingleTransactionDetail({
    Key key, this.batchOfCart}) : super(key: key);


  @override
  _SingleTransactionDetailState createState() => _SingleTransactionDetailState();
}
class _SingleTransactionDetailState extends State<SingleTransactionDetail> {
  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext coontext) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    return LoaderOverlay(
      child: FutureBuilder<dynamic>(
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
        title: widget.batchOfCart.isPharma?Text("Pharmacy Cart"):Text("Importer Cart"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(coontext, false),
        ),
      ),
      body:  SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
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
                                    widget.batchOfCart.drugList[index], widget.batchOfCart.isPharma, ctxt, coontext);
                              },
                              itemCount: widget.batchOfCart.drugList.length,
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Center(
                              child:Text(
                                "Total price : "+widget.batchOfCart.getTotalPrice().toStringAsFixed(2),
                                textScaleFactor: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ),
                        )


                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
    }
    })
    );
  }
  _buildCategoriesListItem(CartDrug cartItem, bool isPharma,  BuildContext ctxt, BuildContext coontext) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailForCartDrug(
                      cart: cartItem,
                      isPharma: isPharma,
                      isOther: true,
                      coontext: coontext
                  )));
        },
        child: Container(
            // padding: EdgeInsets.only(bottom: 5),
            child : Column(
              children: <Widget>[
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(cartItem.drug.image),
                  ),
                  title: Text(cartItem.drug.name),
                  subtitle: Text("Price : ${(num.parse(cartItem.drug.price) * cartItem.amount).toStringAsFixed(2)} Birr"),
                ),
                Divider()
              ],
            )
        )
    );
  }
}


