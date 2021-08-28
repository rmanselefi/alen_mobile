import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:alen/ui/Edit/DiagnosisEdit.dart';
import 'package:alen/ui/Edit/HospitalEdit.dart';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AppColors.dart';
import 'LabEdit.dart';

class AddServices extends StatefulWidget {
  final HospitalLabDiagnosis hospitalLabDiagnosis;
  final int index;
  const AddServices({Key key, this.hospitalLabDiagnosis, this.index}) : super(key: key);

  @override
  _AddServicesState createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  static const myCustomColors = AppColors();

  List<HospitalServices> hospitalServices = HospitalServices.hospitalServices;

  List<int> indexes =[];

  // var hosProvider;
  // List<HospServices> hospServices;
  // List<HospServicesTypes> hospServicesType;
  String id;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   UserPreferences().getId().then((value) => id=value);
  //   hosProvider.getAllHospServiceTypes().then((value) => hospServicesType=value);
  //   hosProvider.getHospServicesByHospitalId('3nPWouBvXSjpDLwbXXER').then((value) => hospServices=value);
  //
  //   hosProvider.getAllHospServiceTypes().then((var result){
  //     setState(() {
  //       hospServicesType = result;
  //     });
  //   });
  // }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var hosProvider= Provider.of<HospitalProvider>(context, listen: false);
    // hosProvider= Provider.of<HospitalProvider>(context, listen: false);


    // UserPreferences().getId().then((value) => id=value);
    // hosProvider.getAllHospServiceTypes().then((value) setSt);

  //  hosProvider.getHospServicesByHospitalId(id).then((value) => hospServices=value);
  //   print('The size of the hosServiceType is ${hospServicesType.length}');
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
            title: Text("Select Services"),
          ),
          body: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //     width: MediaQuery.of(context).size.width*0.9,
                        //     child:  ListView.builder(
                        //         scrollDirection: Axis.vertical,
                        //         itemBuilder: (BuildContext ctxt, int index) {
                        //           return _buildSmallAdsListItem(
                        //               hospServicesType[index],
                        //               ctxt,index, (hospServicesType.contains(hospServices[index]))?true:false);
                        //         },
                        //         itemCount: hospServicesType.length,
                        //         physics: NeverScrollableScrollPhysics(),
                        //         shrinkWrap: true
                        //     )
                        // ),
                        FutureBuilder<List<HospServicesTypes>>(
                            future: hosProvider.getAllHospServiceTypes(),
                            builder: (context , hospServTypeSnapshot) {
                              if (hospServTypeSnapshot.connectionState ==
                                  ConnectionState.none &&
                                  hospServTypeSnapshot.hasData == null) {
                                return Container(
                                  height: 110,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              // print(
                              //     'project snapshot data is: ${hospServTypeSnapshot.data.length}');
                              if (hospServTypeSnapshot.data == null) {
                                return Container(
                                  height: 110,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              else {

                                return  Container(
                                    height: 110.0,
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.07,
                                        5,
                                        MediaQuery.of(context).size.width * 0.07,
                                        30),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext ctxt, int index) {
                                        return _buildSmallAdsListItem(
                                            hospServTypeSnapshot.data[index],
                                            ctxt, index, true
                                          //ctxt,index, (hospServTypeSnapshot.data.contains(hospServSnapshot.data[index]))?true:false
                                        );
                                      },
                                      itemCount: hospServTypeSnapshot.data.length,
                                    ));
                              }
                            }),
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
                                widget.hospitalLabDiagnosis.services.clear();
                                print("Printing");
                                indexes.forEach((element) {
                                  print(element);
                                  setState(() {
                                    widget.hospitalLabDiagnosis.services.add(hospitalServices.elementAt(element));
                                  });
                                });
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                switch(widget.index){
                                  case 0: Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HospitalEdit(
                                            hospital: widget.hospitalLabDiagnosis,
                                          )));
                                  break;
                                  case 1: Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DiagnosisEdit(
                                            diagnosis: widget.hospitalLabDiagnosis,
                                          )));
                                  break;
                                  case 2: Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LabEdit(
                                            lab: widget.hospitalLabDiagnosis,
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
  _buildSmallAdsListItem(var hospitalServces, BuildContext ctxt, int index, bool first) {
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
                      subtitle: Text(hospitalServces.description,
                        style: TextStyle(color: Colors.black54),
                        maxLines: 2,),
                      controlAffinity: ListTileControlAffinity.trailing,
                      secondary: CircleAvatar(
                          backgroundImage: NetworkImage(
                              hospitalServces.image
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



