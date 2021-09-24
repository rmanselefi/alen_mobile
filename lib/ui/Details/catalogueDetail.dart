import 'dart:io';

import 'package:alen/models/company.dart';
import 'package:alen/providers/company.dart';
import 'package:alen/ui/Details/CatalogueSubDetail.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class CatalogueDetail extends StatefulWidget {
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

  CatalogueDetail({
    Key key,
    this.name,
    this.imageUrl,
    this.description,
    this.serviceId,
    this.catalogue,
    this.companyId, this.typeName, this.typeImageUrl, this.typeDescription, this.typeId
  }) : super(key: key);
  @override
  _CatalogueDetailState createState() => _CatalogueDetailState();
}

class _CatalogueDetailState extends State<CatalogueDetail> {

  static const myCustomColors = AppColors();
  static String prc;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var companyProvider = Provider.of<CompanyProvider>(context, listen: false);
    // final PageController controller = PageController(initialPage: 0);
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
                          width: 200, height: 120, fit: BoxFit.fill),
                    ),
                    widget.typeId =="4"?
                    Column(children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.03,
                            30,
                            MediaQuery.of(context).size.width * 0.03,
                            5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Sub-Catalogue',
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder<List<Catalogue>>(
                          future: companyProvider.getMySubServiceTypes(widget.companyId,"4"),
                          builder: (context, hospServSnapshot) {
                            if (hospServSnapshot.connectionState ==
                                ConnectionState.none &&
                                hospServSnapshot.hasData == null) {
                              return Container(
                                height: 110,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            print(
                                'project snapshot data is: ${hospServSnapshot.data}');
                            if (hospServSnapshot.data == null) {
                              return Container(
                                height: 110,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return Container(
                                  height: 110.0,
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width *
                                          0.07,
                                      5,
                                      MediaQuery.of(context).size.width *
                                          0.07,
                                      30),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      print(hospServSnapshot.data[index]);
                                      return _buildHopitalServicesListItem(
                                        hospServSnapshot.data[index],
                                        ctxt,
                                      );
                                    },
                                    itemCount: hospServSnapshot.data.length,
                                  ));
                            }
                          }),
                    ],)
                        : widget.typeId =="5"?
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.03,
                              30,
                              MediaQuery.of(context).size.width * 0.03,
                              5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Sub-Catalogue',
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder<List<Catalogue>>(
                            future: companyProvider.getMySubServiceTypes(widget.companyId, "5"),
                            builder: (context, hospServSnapshot) {
                              if (hospServSnapshot.connectionState ==
                                  ConnectionState.none &&
                                  hospServSnapshot.hasData == null) {
                                return Container(
                                  height: 110,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              print(
                                  'project snapshot data is: ${hospServSnapshot.data}');
                              if (hospServSnapshot.data == null) {
                                return Container(
                                  height: 110,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return Container(
                                    height: 110.0,
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.07,
                                        5,
                                        MediaQuery.of(context).size.width *
                                            0.07,
                                        30),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        print(hospServSnapshot.data[index]);
                                        return _buildHopitalServicesListItem(
                                          hospServSnapshot.data[index],
                                          ctxt,
                                        );
                                      },
                                      itemCount: hospServSnapshot.data.length,
                                    ));
                              }
                            }),
                      ],)
                        : Container(
                      height: 20,
                    ),
                    Container(
                        padding: EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child:Text(
                              widget.typeName??"Name",
                              textAlign: TextAlign.left,
                              textScaleFactor: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            )
                        )
                    ),
                    (widget.typeId!="4"&& widget.typeId!="5")
                        ?
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
                            })
                        :
                    StatefulBuilder(  // You need this, notice the parameters below:
                        builder: (BuildContext ctxt, StateSetter setState) {
                          return Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  widget.typeDescription??"Description",
                                  textDirection: TextDirection.ltr,
                                  maxLines: 10,
                                ),
                              )
                          );
                        })
                  ],
                ),
              )
            ],
          )),
    );
  }

  _buildHopitalServicesListItem(Catalogue hospitalServices, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) =>CatalogueSubDetail(
                      companyId: widget.companyId,
                      name: hospitalServices.name,
                      imageUrl: hospitalServices.image,
                      description: hospitalServices.description,
                      catalogue: hospitalServices.typeName,
                      typeName: hospitalServices.typeName,
                      typeDescription: hospitalServices.typeDescription,
                      typeImageUrl: widget.typeImageUrl,
                      typeId: widget.typeId ,
                      serviceId: hospitalServices.id
                  )));
        },
        child: Card(
            elevation: 0,
            color: myCustomColors.mainBackground,
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: Image.network(
                      hospitalServices.image,
                      fit: BoxFit.fitHeight,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
                Text(
                  hospitalServices.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }


}


