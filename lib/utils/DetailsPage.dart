import 'package:alen/ui/Details/HospitalDetail.dart';
import 'package:flutter/material.dart';
import 'AppColors.dart';

class DetailsPage extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  String price;
  final String colName;
  final String serviceId;
  final String hospitalId;
  final Roles role;

  DetailsPage({
    Key key,
    this.name,
    this.imageUrl,
    this.description,
    this.price,
    this.colName,
    this.serviceId,
    this.hospitalId,
    this.role
  }) : super(key: key);

  static const myCustomColors = AppColors();
  static String prc;

  @override
  Widget build(BuildContext context) {
    prc=price;
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
                      child: (imageUrl==null)?Text("Image not available"):
                      Image.network(imageUrl,
                          width: 200, height: 120, fit: BoxFit.fill),
                    ),
                    Container(
                        padding: EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child:Text(
                              name??"Name",
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
                            description??"Description",
                            textDirection: TextDirection.ltr,
                            maxLines: 10,
                          ),
                        )
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
                                  price??"0",
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
}
