import 'package:alen/ui/Cart/CategoryWithAmount.dart';
import 'package:alen/ui/Cart/PharmacyCart.dart';
import 'package:alen/ui/ServiceCategory/Category.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';



class DetailForPha extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String description;
  final double price;

  DetailForPha({
     this.name,
     this.imageUrl,
     this.description,
     this.price
  }) ;
  @override
  _DetailForPhaState createState() => _DetailForPhaState();
}

class _DetailForPhaState extends State<DetailForPha> {


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
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 15),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PharmacyCart()
                      )
                  );
                },
                icon: Icon(
                    Icons.shopping_cart
                ),
              )
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
                            Container(
                                padding:EdgeInsets.only(right: 30),
                                child:Column(
                                    children:[
                                      Container(
                                        padding: EdgeInsets.only(right:30,top: 10),
                                        child:Text(
                                          'Add to cart',
                                          textScaleFactor: 1.5,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(right:30,),
                                          child:IconButton(
                                            onPressed: (){
                                              getPresreption(context, widget.imageUrl, widget.name);
                                            },
                                            icon: Icon(
                                              Icons.add_shopping_cart_rounded,
                                            ),
                                          )
                                      ),
                                    ]))
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
  getPresreption(BuildContext ctxt,String image, String name) async {
    int amount=1;
    return showDialog(
        context: ctxt,
        builder: (context) {
      return StatefulBuilder(  // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            // _setState = setState;
            return AlertDialog(
            title: Text('Add $name to your cart?'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 30,bottom: 10),
                    child:SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Image.asset(
                          image,
                          fit: BoxFit.fill,
                        )
                    )),
                Text("How much would you want?"),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    width:200,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                          width: 3.0,
                          color: myCustomColors.loginBackgroud
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(50.0) //                 <--- border radius here
                      ),
                    ),
                    //
                    child: new Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 15),
                                height: 40,
                                width: 30,
                                color: Colors.blue,
                                child: GestureDetector(
                                  onTap: (){
                                    setState((){
                                      amount++;
                                    }
                                    );
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                )
                            ),
                            Container(
                                height: 55,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(
                                      width: 3.0,
                                      color: myCustomColors.loginBackgroud
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(50.0) //                 <--- border radius here
                                  ),
                                ),
                                child: Center(child:
                                Text(
                                  amount.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                )
                                )
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 10,bottom: 25),
                                height: 30,
                                width: 30,
                                color: Colors.blue,
                                child: GestureDetector(
                                  onTap: (){
                                    setState((){
                                      if(amount!=0){
                                        amount--;
                                      }
                                    }
                                    );
                                  },
                                  child: Icon(
                                    Icons.minimize_rounded,
                                    color: Colors.white,
                                  ),
                                )
                            ),
                          ],
                        )
                    )
                )
              ],
            ),
            actions: <Widget>[
              new ElevatedButton(
                  child: new Center(
                    child: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add_shopping_cart_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Add')
                            ])),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                      if(amount!=0){
                        CategoryWithAmount.pharmacyCart.add(
                            CategoryWithAmount(
                                Category(
                                    name,
                                    image,
                                    widget.description,
                                    widget.price
                                ),
                                amount
                            )
                        );
                      }
                    }
                    );
                  })
            ],
          );
        });
        });
  }
}

