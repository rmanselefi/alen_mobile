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

import 'SingleTransactionDetail.dart';

class TransactionDetail extends StatefulWidget {
  TransactionDetail({Key key, this.userId}) : super(key: key);
  final String userId;

  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}
class _TransactionDetailState extends State<TransactionDetail> {
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
        title: Text("Transactions"),
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

                    FutureBuilder<List<BatchOfCart>>(
                        future: cartProvider.getAllTransactions(widget.userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.none &&
                              snapshot.hasData == null) {
                            return Container(
                                height: MediaQuery.of(coontext).size.height,
                                child: Center(
                                    child:
                                    CircularProgressIndicator()));
                          }
                          print(
                              '------------------------------project snapshot data is: ${snapshot.data}');
                          if (snapshot.data == null) {
                            return Container(
                                height: MediaQuery.of(coontext).size.height,
                                child: Center(
                                    child:
                                    CircularProgressIndicator()));
                          } else {
                            if(snapshot.data.length==0){
                              return Container(
                                height: MediaQuery.of(coontext).size.height,
                                child: Center(
                                  child: Text(
                                      "You have not performed any transaction yet."
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
  _buildCategoriesListItem(BatchOfCart batchOfCart, BuildContext ctxt, BuildContext coontext) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => SingleTransactionDetail(
                    batchOfCart: batchOfCart,
                  )));
        },
        child: Container(
            // padding: EdgeInsets.only(bottom: 5),
            child : Column(
              children: <Widget>[
                ListTile(
                  title: Container(
                      width: MediaQuery.of(coontext).size.width*0.7,
                      child: Text(
                        batchOfCart.batchTimeStamp.toString(),
                        overflow: TextOverflow.fade,
                      )
                  ),
                  subtitle: Container(
                      width: MediaQuery.of(coontext).size.width*0.7,
                      child: Text(
                        // "${batchOfCart.drugList.first.amount}",
                        "${batchOfCart.getTotalPrice().toStringAsFixed(2)} Birr",
                        overflow: TextOverflow.fade,
                      )
                  ),
                  trailing: batchOfCart.delivered?Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "✓ Delivered",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: myCustomColors.loginBackgroud
                        ),
                      ),
                    ],
                  ):Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.pending_actions,
                        color: myCustomColors.loginButton,
                      ),
                      Text(
                        " Pending",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: myCustomColors.loginButton
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}


