import 'package:alen/ui/Edit/EditServiceType.dart';
import 'package:flutter/material.dart';
import 'AppColors.dart';

class DetailsPage extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  final String price;
  final String colName;
  final String serviceId;
  final String hospitalId;

  DetailsPage({
    Key key,
     this.name,
     this.imageUrl,
     this.description,
    this.price,
    this.colName,
    this.serviceId,
    this.hospitalId
  }) : super(key: key);

  static const myCustomColors = AppColors();

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
            onPressed: () => Navigator.pop(context, false),
          ),
                  actions: [
                   IconButton(
                       onPressed: (){
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (ctxt) => EditServiceType(
                                   serviceId: serviceId,
                                   colName: colName,
                                   price: price,
                                   name: name,
                                   imageUrl: imageUrl,
                                   description: description,
                                   hospitalId: hospitalId,
                                   cont : context
                                 )));

                       },
                       icon: Icon(
                         Icons.edit
                       ))
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
                      child: Image.network(imageUrl,
                          width: 200, height: 120, fit: BoxFit.fill),
                    ),
                    Container(
                        padding: EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child:Text(
                              name,
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
                            description,
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

                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                              child: Text(
                                (price!=null)?price.toString():'0',
                                textDirection: TextDirection.ltr,
                                maxLines: 1,
                              ),

                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
