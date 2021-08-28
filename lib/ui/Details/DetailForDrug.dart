import 'package:alen/models/drugs.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';



class DetailForDrug extends StatefulWidget {


  final Drugs drug;

  DetailForDrug({
    this.drug,
  });
  @override
  _DetailForDrugState createState() => _DetailForDrugState();
}

class _DetailForDrugState extends State<DetailForDrug> {


  static const myCustomColors = AppColors();
  int amount=1;


  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: myCustomColors.mainBackground,
            appBarTheme: AppBarTheme(
              color: myCustomColors.loginBackgroud,
            )),
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context, false);
                }
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
                          child: Image.network(widget.drug.image,
                              width: 200, height: 120, fit: BoxFit.fill),
                        ),
                        Container(
                            padding: EdgeInsets.all(30),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child:Text(
                                  widget.drug.name,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 2,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(30),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child:Text(
                                  "Category : "+widget.drug.category,
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.7,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            )
                        ),
                        // Container(
                        //     padding: EdgeInsets.symmetric(horizontal: 20),
                        //     width: MediaQuery.of(context).size.width,
                        //     child: Center(
                        //       child: Text(
                        //         widget.drug.category_image,
                        //         textDirection: TextDirection.ltr,
                        //         maxLines: 10,
                        //       ),
                        //     )
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:EdgeInsets.only(left: 20),
                              child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Container(
                                      padding: EdgeInsets.only(left:30,top: 10),
                                      child:Text(
                                        'Dosage',
                                        textScaleFactor: 1.7,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:30,top: 15),
                                      child:Text(
                                        widget.drug.dosage,
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        textScaleFactor: 1.7,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                    ),
                                  ]),),
                            Container(
                                padding:EdgeInsets.only(right: 30),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      Container(
                                        padding: EdgeInsets.only(right:30,top: 10),
                                        child:Text(
                                          'Madein',
                                          textScaleFactor: 1.7,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right:30,top: 15),
                                        child:Text(
                                          widget.drug.madein,
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                          textScaleFactor: 1.7,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                      ),
                                    ])
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:EdgeInsets.only(left: 20),
                              child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Container(
                                      padding: EdgeInsets.only(left:30,top: 10),
                                      child:Text(
                                        'Quantity',
                                        textScaleFactor: 1.7,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:20,top: 15),
                                      child:Text(
                                        widget.drug.quantity,
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        textScaleFactor: 1.7,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                    ),
                                  ]),),
                            Container(
                                padding:EdgeInsets.only(right: 50),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      Container(
                                        padding: EdgeInsets.only(right:30,top: 10),
                                        child:Text(
                                          'Root',
                                          textScaleFactor: 1.7,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right:30,top: 15),
                                        child:Text(
                                          widget.drug.root,
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                          textScaleFactor: 1.7,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                      ),
                                    ])
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:EdgeInsets.only(left: 20),
                              child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Container(
                                      padding: EdgeInsets.only(left:30,top: 10),
                                      child:Text(
                                        'Price',
                                        textScaleFactor: 1.7,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:35,top: 15),
                                      child:Text(
                                        widget.drug.quantity.toString(),
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        textScaleFactor: 1.7,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                    ),
                                  ]),),
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
        ));
  }
}

