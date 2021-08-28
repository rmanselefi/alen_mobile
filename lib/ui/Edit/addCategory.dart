import 'package:alen/ui/Edit/ImporterEdit.dart';
import 'package:alen/ui/Edit/PharmacyEdit.dart';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/Services/PharmacistsServices.dart';
import 'package:flutter/material.dart';

import '../AppColors.dart';

class AddCategories extends StatefulWidget {
  final ImporterPharmacy importerPharmacy;
  final int index;
  const AddCategories({Key key, this.importerPharmacy, this.index}) : super(key: key);

  @override
  _AddCategoriesState createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  static const myCustomColors = AppColors();

  List<PharmacyServices> pharmacyServices = PharmacyServices.pharmacyServices;

  List<int> indexes =[];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: myCustomColors.mainBackground),

        home: Scaffold(
          appBar: AppBar(
            backgroundColor: myCustomColors.loginBackgroud,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            title: Text("Select Categories"),
          ),
          body: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            child:  ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return _buildSmallAdsListItem(
                                      pharmacyServices[index],
                                      ctxt,index, (widget.importerPharmacy.services.contains(pharmacyServices[index]))?true:false);
                                },
                                itemCount: pharmacyServices.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true
                            )
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: 130,
                            height: 50,
                            child: ElevatedButton(
                              child: Text("Submit",
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      myCustomColors.loginButton),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(30.0),
                                          side: BorderSide(
                                              color:
                                              myCustomColors.loginButton)))),

                              onPressed: (){
                                widget.importerPharmacy.services.clear();
                                print("Printing");
                                indexes.forEach((element) {
                                  print(element);
                                  setState(() {
                                    widget.importerPharmacy.services.add(pharmacyServices.elementAt(element));
                                  });
                                });
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                switch(widget.index){
                                  case 0: Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PharmacyEdit(
                                            pharmacy: widget.importerPharmacy,
                                          )));
                                  break;
                                  case 1: Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImporterEdit(
                                            importer: widget.importerPharmacy,
                                          )));
                                  break;
                                  default: print("Nothing here:(");
                                  break;
                                }
                              },
                            )),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )

                ],
              )),
        ));
  }
  _buildSmallAdsListItem(PharmacyServices pharmacyService, BuildContext ctxt, int index, bool first) {
    // bool startingValue=true;
    double size= MediaQuery.of(context).size.width*0.9;
    bool startingValue = first;
    if(startingValue){
      indexes.add(index);
    }
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Center(
            child: Container(
              width: size,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: size,
                        child:CheckboxListTile(
                          title: Text(pharmacyService.name,
                            style: TextStyle(color: Colors.black),),
                          subtitle: Text(pharmacyService.detail,
                            style: TextStyle(color: Colors.black54),
                            maxLines: 2,),
                          controlAffinity: ListTileControlAffinity.trailing,
                          secondary: CircleAvatar(
                              backgroundImage: AssetImage(
                                  pharmacyService.imagePath
                              )),
                          checkColor: myCustomColors.mainBackground,
                          activeColor: myCustomColors.loginBackgroud,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal:10,
                              vertical: 10
                          ),
                          value: startingValue,
                          selected: startingValue,
                          onChanged: (value) {
                            setState(() {
                              startingValue = value;
                              // if(indexes.contains(index)){
                              //   indexes.remove(index);
                              // }else{
                              //   indexes.add(index);
                              // }
                              if(startingValue){
                                indexes.add(index);
                              }else{
                                indexes.remove(index);
                              }
                            });
                          },
                        ),
                      ),
                      // Container(
                      //   width: size*0.10,
                      //   child: Checkbox(
                      //       checkColor: myCustomColors.mainBackground,
                      //       activeColor: myCustomColors.loginBackgroud,
                      //       value: true,
                      //       onChanged: (bool? value) {
                      //         setState(() {
                      //           valuefirst = value!;
                      //         });
                      //       }
                      //   ),
                      // )
                    ],
                  ),
                  Divider()
                ],
              ),

            ),
          );});
  }
}



