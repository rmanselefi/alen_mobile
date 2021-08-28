import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/ServiceCategory/Category.dart';
import 'package:alen/ui/Services/PharmacistsServices.dart';
import 'package:flutter/material.dart';
import '../AppColors.dart';

class AddTypePharmacy extends StatefulWidget {
  final PharmacyServices pharmacyService;
  final ImporterPharmacy importerPharmacy;
  const AddTypePharmacy({Key key, this.pharmacyService, this.importerPharmacy}) : super(key: key);

  @override
  _AddTypePharmacyState createState() => _AddTypePharmacyState();
}

class _AddTypePharmacyState extends State<AddTypePharmacy> {
  static const myCustomColors = AppColors();

  List<Category> categories=[];



  void seter(){
    print("In setter");
    indexes.clear();
    // if(HospitalServices.hospitalServices.in widget.hospitalService){
    //   services.add(value);
    // }
    PharmacyServices.pharmacyServices.forEach((element) {
      if(element.name==widget.pharmacyService.name){
        //services.clear();
        int a=PharmacyServices.pharmacyServices.indexOf(element);
        switch(a){
          case 0: Category.categories.forEach((element) {
            categories.add(element);
          });
          break;
          case 1: Category.categories2.forEach((element) {
            categories.add(element);
          });
          break;
          default: Category.categories.forEach((element) {
            categories.add(element);
          });
          break;
        }

      }
    });
    print('----------');
    categories.forEach((element) {
      print(element.name);
    });
    print('----------');
  }
  List<int> indexes =[];


  int myIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seter();
  }
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
            title: Text("Select Types"),
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
                                      categories[index],
                                      ctxt,index, (widget.pharmacyService.categores.contains(categories[index]))?true:false);
                                },
                                itemCount: categories.length,
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
                                //widget.hospitalService.services.clear();

                                // myIndex=widget.hospital.services.indexOf(widget.hospitalService);
                                print("Printing");
                                print("The size of indexes is ${indexes.length}");
                                widget.pharmacyService.categores.clear();
                                indexes.forEach((element) {
                                  //print(element);
                                  print(categories.elementAt(element).name+" " + categories.elementAt(element).detail+""+categories.elementAt(element).imagePath);
                                  setState(() {
                                    widget.pharmacyService.categores.add(categories.elementAt(element));
                                  });
                                });
                                indexes.clear();
                                setState(() {
                                  widget.importerPharmacy.services.forEach((element) {
                                    if(element.name==widget.pharmacyService.name){
                                      widget.importerPharmacy.services.remove(element);
                                    }
                                  });
                                  widget.importerPharmacy.services.add(widget.pharmacyService);
                                });
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
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
  _buildSmallAdsListItem(Category category, BuildContext ctxt, int index, bool first) {
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
                          title: Text(category.name,
                            style: TextStyle(color: Colors.black),),
                          subtitle: Text(category.detail,
                            style: TextStyle(color: Colors.black54),
                            maxLines: 2,),
                          controlAffinity: ListTileControlAffinity.trailing,
                          secondary: CircleAvatar(
                              backgroundImage: AssetImage(
                                  category.imagePath
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



