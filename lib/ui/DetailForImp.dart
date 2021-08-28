import 'package:flutter/material.dart';
import 'AppColors.dart';

class DetailForImp extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String description;
  final double price;

  DetailForImp({
    Key key,
     this.name,
     this.imageUrl,
     this.description,
     this.price
  }) : super(key: key);
  @override
  _DetailForImpState createState() => _DetailForImpState();
}

class _DetailForImpState extends State<DetailForImp> {


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
                          child: Image.asset(widget.imageUrl,
                              width: 200, height: 120, fit: BoxFit.fill),
                        ),
                        Container(
                            padding: EdgeInsets.all(30),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child:Text(
                                  widget.name,
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
                                widget.description,
                                textDirection: TextDirection.ltr,
                                maxLines: 10,
                              ),
                            )
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
                                      padding: EdgeInsets.only(left:30,top: 15),
                                      child:Text(
                                        widget.price.toString(),
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

