import 'package:alen/ui/DetailsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../AppColors.dart';

class EditServiceType extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
   String price;
  final String colName;
  final String serviceId;
  final String hospitalId;
  final BuildContext cont;

  EditServiceType({
    Key key,
    this.name,
    this.imageUrl,
    this.description,
    this.price,
    this.colName,
    this.serviceId,
    this.hospitalId, this.cont
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
              )
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
                            IconButton(
                                onPressed: (){
                                  _messageControler.text = price.toString();
                                  editPrice(context, price.toString());
                                },
                                icon: Icon(
                                  Icons.edit_outlined
                                )
                            ),
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
                                      price,
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
        ));
  }
  bool isLoading = false;
  Future<int> updateServiceTypePrice(String hospitalId, num price,String id, String formerPrice) async{
    isLoading = true;
    var curr;
    try {
      var docs = await FirebaseFirestore.instance
          .collection('hospital')
          .where('id', isEqualTo: hospitalId)
          .get();
      print('found found hospital');
      if (docs.docs.isNotEmpty) {
        var data = docs.docs[0].data();
        var servicesList=data.containsKey('services')?data['services']:[];
        for (var i = 0; i < servicesList.length; i++) {
          print('found found forloop with id : $i');
          print('found found current id : ${servicesList[i]['service_id']}');
          print('found found my id : $id');
          String servicesData =await servicesList[i]['service_id'];
          print("ServiceTypeId:$servicesData");
          if(servicesList[i]['service_id']==id){

              FirebaseFirestore.instance.collection('hospital')
                  .doc(hospitalId)
                  .update({'services': FieldValue.arrayRemove([{'service_id': id,'price': formerPrice}])})
                  .then((value) => print("Price deleted"))
                  .catchError((error) => print("Failed to update Price: $error"));
              FirebaseFirestore.instance.collection('hospital')
                  .doc(hospitalId)
                  .update({'services': FieldValue.arrayUnion([{'service_id': id, 'price' : price.toStringAsFixed(2)}])})
                  .then((value) => print("Price added"))
                  .catchError((error) => print("Failed to update Price: $error"));
            return 1;
          }
        }
      }
      return 0;
    } catch (error) {
      isLoading = false;
      print("Category . . . . . . :$error");
      return 0;
    }
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _messageControler = TextEditingController();
  editPrice(BuildContext EditPageContext, String message){
    return showDialog(
        context: EditPageContext,
        builder: (context) {
          return StatefulBuilder(  // You need this, notice the parameters below:
              builder: (BuildContext ctxt, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit Price?'),
                  content: SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                  children:[
                                    Container(
                                        child: Center(
                                            child: Container(
                                                padding: EdgeInsets.fromLTRB(10,5,10,25),
                                                width: MediaQuery.of(ctxt).size.width * 0.90,
                                                child: TextFormField(
                                                  controller: _messageControler,
                                                  autocorrect: true,
                                                  maxLines: 15,
                                                  keyboardType: TextInputType.number,
                                                  validator: (String value){
                                                    if (value==null){
                                                      return 'Price is required!';
                                                    }
                                                    if (value==''){
                                                      return 'Price is required!';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (String value){
                                                    setState(() {

                                                    //   FirebaseFirestore.instance.collection('hospital')
                                                    //       .doc(serviceId)
                                                    //       .update({'price': num.tryParse(value)})
                                                    //       .then((value) => print("Price Updated"))
                                                    //       .catchError((error) => print("Failed to update Price: $error"));
                                                      updateServiceTypePrice(hospitalId, num.tryParse(value),serviceId, price);
                                                      price=value;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: 'Price',
                                                    hintText: 'Price',
                                                    labelStyle: TextStyle(color: myCustomColors.loginBackgroud),
                                                    prefixIcon: Icon(
                                                      Icons.edit,
                                                      color: myCustomColors.loginBackgroud,
                                                    ),
                                                    counterStyle: TextStyle(color: Colors.white54),
                                                    hintStyle: TextStyle(color: myCustomColors.loginBackgroud),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(40.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.green, width: 2),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius: const BorderRadius.all(
                                                        const Radius.circular(40.0),
                                                      ),
                                                      borderSide: BorderSide(
                                                          color: Colors.green, width: 2),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(40.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.green, width: 2),
                                                    ),
                                                  ),
                                                )))),
                                  ]
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  actions: [
                    new ElevatedButton(
                        child: new Center(
                          child: Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(Icons.done),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Save')
                                  ])),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Navigator.of(ctxt).pop();
                            // Navigator.of(context).pop();
                            // Navigator.of(EditPageContext).pop();
                            // Navigator.of(cont).pop();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (ctxt) => DetailsPage(
                            //             serviceId: serviceId,
                            //             colName: colName,
                            //             price: price,
                            //             name: name,
                            //             imageUrl: imageUrl,
                            //             description: description,
                            //             hospitalId: hospitalId,
                            //         )));
                            
                          }
                        }),
                  ],
                );
              });
        });
  }
  void notify(BuildContext context){
    final snackBar = SnackBar(content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.done, color: Colors.green,
        ),
        Text('Price Updated successfully!')
      ],
    ));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
