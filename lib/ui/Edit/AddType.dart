import 'package:alen/ui/Edit/DetailServiceEdit.dart';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/ServiceCategory/Service.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:flutter/material.dart';
import '../AppColors.dart';

class AddType extends StatefulWidget {
  final HospitalServices hospitalService;
  final HospitalLabDiagnosis hospitalLabDiagnosis;
  const AddType({Key key, this.hospitalService, this.hospitalLabDiagnosis}) : super(key: key);

  @override
  _AddTypeState createState() => _AddTypeState();
}

class _AddTypeState extends State<AddType> {
  static const myCustomColors = AppColors();

  List<Service> services=[];



  void seter(){
    print("In setter");
    indexes.clear();
    // if(HospitalServices.hospitalServices.in widget.hospitalService){
    //   services.add(value);
    // }
    HospitalServices.hospitalServices.forEach((element) {
      if(element.name==widget.hospitalService.name){
        //services.clear();
        int a=HospitalServices.hospitalServices.indexOf(element);
        switch(a){
          case 0: Service.services.forEach((element) {
            services.add(element);
          });
          break;
          case 1: Service.services2.forEach((element) {
            services.add(element);
          });
          break;
          case 2: Service.services3.forEach((element) {
            services.add(element);
          });
          break;
          case 3: Service.services4.forEach((element) {
            services.add(element);
          });
          break;
          case 4: Service.services5.forEach((element) {
            services.add(element);
          });
          break;
          default: Service.services.forEach((element) {
            services.add(element);
          });
          break;
        }

      }
    });
    print('----------');
    services.forEach((element) {
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
                                      services[index],
                                      ctxt,index, (widget.hospitalService.services.contains(services[index]))?true:false);
                                },
                                itemCount: services.length,
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
                                widget.hospitalService.services.clear();
                                indexes.forEach((element) {
                                  //print(element);
                                  print(services.elementAt(element).name+" " + services.elementAt(element).detail+""+services.elementAt(element).imagePath);
                                  setState(() {
                                    widget.hospitalService.services.add(services.elementAt(element));
                                  });
                                });
                                indexes.clear();
                                setState(() {
                                  widget.hospitalLabDiagnosis.services.forEach((element) {
                                    if(element.name==widget.hospitalService.name){
                                      widget.hospitalLabDiagnosis.services.remove(element);
                                    }
                                  });
                                 widget.hospitalLabDiagnosis.services.add(widget.hospitalService);
                                });
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailServiceEdit(
                                          hospitalLabDiagnosis: widget.hospitalLabDiagnosis,
                                          hospitalServices: widget.hospitalService,
                                        )));
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
  _buildSmallAdsListItem(Service hospitalServces, BuildContext ctxt, int index, bool first) {
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
                          title: Text(hospitalServces.name,
                            style: TextStyle(color: Colors.black),),
                          subtitle: Text(hospitalServces.detail,
                            style: TextStyle(color: Colors.black54),
                            maxLines: 2,),
                          controlAffinity: ListTileControlAffinity.trailing,
                          secondary: CircleAvatar(
                              backgroundImage: AssetImage(
                                  hospitalServces.imagePath
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



