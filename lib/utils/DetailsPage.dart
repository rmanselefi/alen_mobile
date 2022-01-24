import 'package:alen/providers/language.dart';
import 'package:alen/ui/Details/HospitalDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppColors.dart';

class DetailsPage extends StatefulWidget {
  String name;
  String imageUrl;
  String description;
  String additionalDescription;
  String price;
  String colName;
  String serviceId;
  String hospitalId;
  Roles role;
  static String Price;
  static String addDesc;
  BuildContext editDetailContext;
  BuildContext editPageContext;
  DetailsPage({Key key, this.name, this.imageUrl,
    this.price,
    this.description, this.additionalDescription,
    this.colName, this.serviceId, this.hospitalId,
    this.editPageContext,
    this.role, this.editDetailContext}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  static const myCustomColors = AppColors();
  static String prc;
  static String description="";
  @override
  Widget build(BuildContext detailPageContext) {
    prc=DetailsPage.Price;
    description=DetailsPage.addDesc;
    // final PageController controller = PageController(initialPage: 0);
    return FutureBuilder<dynamic>(
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
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                ),
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
                              child: (widget.imageUrl==null)?Text("Image not available"):
                              Image.network(widget.imageUrl,
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
                                    child:Text(
                                      widget.name??"Name",
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    )
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    widget.description??"Description",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 10,
                                  ),
                                )
                            ),

                            (DetailsPage.addDesc!=null&&DetailsPage.addDesc!="")?
                            Column(children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Additional Description",
                                  textScaleFactor: 1.2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      description??"",
                                      textDirection: TextDirection.ltr,
                                      maxLines: 10,
                                    ),
                                  )
                              ),
                            ],):SizedBox(
                              height: 5,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),

                                    child:Text(
                                      "Price : ",
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 1.2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    )

                                ),

                                StatefulBuilder(  // You need this, notice the parameters below:
                                    builder: (BuildContext ctxt, StateSetter setState) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                                        child: Text(
                                          prc??"0",
                                          textDirection: TextDirection.ltr,
                                          maxLines: 1,
                                        ),
                                      );
                                    })
                              ],
                            ),
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

