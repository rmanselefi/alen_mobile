import 'package:alen/providers/language.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatalogueSubDetail extends StatefulWidget {
  final String name;
  final String imageUrl;
  String description;
  final String serviceId;
  final String typeName;
  final String typeImageUrl;
  final String typeDescription;
  final String typeId;
  final String catalogue;
  final String companyId;

  CatalogueSubDetail({
    Key key,
    this.name,
    this.imageUrl,
    this.description,
    this.serviceId,
    this.catalogue,
    this.companyId, this.typeName, this.typeImageUrl, this.typeDescription, this.typeId
  }) : super(key: key);
  @override
  _CatalogueSubDetailState createState() => _CatalogueSubDetailState();
}

class _CatalogueSubDetailState extends State<CatalogueSubDetail> {

  static const myCustomColors = AppColors();
  static String prc;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);
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
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                ),
                // actions: [
                //   IconButton(
                //       onPressed: (){
                //         nameController.text =
                //             widget.name;
                //         descriptionController.text =
                //             widget.description;
                //         addHomeCareServices(context);
                //       },
                //       icon: Icon(
                //           Icons.edit
                //       ))
                // ],
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
                                  width: 200, height: 120, fit: BoxFit.fill,errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
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
                            StatefulBuilder(  // You need this, notice the parameters below:
                                builder: (BuildContext ctxt, StateSetter setState) {
                                  return Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      width: MediaQuery.of(context).size.width*0.7,
                                      child: Center(
                                        child: Text(
                                          widget.description??"Description",
                                          textDirection: TextDirection.ltr,
                                          maxLines: 10,
                                        ),
                                      )
                                  );
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),

                                    child:Text(
                                      "Catalogue : ",
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
                                          widget.typeName??"",
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


