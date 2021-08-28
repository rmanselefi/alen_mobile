import 'package:alen/models/diagnostic.dart';
import 'package:alen/providers/auth.dart';
import 'package:alen/providers/diagnostic.dart';
import 'package:alen/providers/drug.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:alen/ui/Details/DiagnosisDetail.dart';
import 'package:alen/ui/Forms/LoginForm.dart';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../AppColors.dart';
import 'AddService.dart';
import 'DetailServiceEdit.dart';
import 'MultiImageDemo.dart';

class DiagnosisEdit extends StatefulWidget {
  final HospitalLabDiagnosis diagnosis;
  const DiagnosisEdit({Key key, this.diagnosis,}) : super(key: key);

  @override
  _DiagnosisEditState createState() => _DiagnosisEditState();
}

class _DiagnosisEditState extends State<DiagnosisEdit> {

  final List<String> imageList = [
    'assets/images/hos1.jpg',
    'assets/images/hos2.jpg',
    'assets/images/hos3.jpg',
    'assets/images/hos1.jpg',
    'assets/images/hos2.jpg',
  ];

  static const myCustomColors = AppColors();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);
    var diagnosisProider = Provider.of<DiagnosticProvider>(context, listen: false);
    var drugProvider = Provider.of<DrugProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var hosProvider = Provider.of<HospitalProvider>(context, listen: false);
    String pharmacyId;
    UserPreferences().getId().then((value) => pharmacyId=value);
    print(pharmacyId);
    void handleClick(int item) {
      switch (item) {
        case 0:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultipleImageDemo(hospital: widget.diagnosis,)//(hospital: widget.hospital,)
              ));
          break;
        default:
          break;
      }
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: myCustomColors.mainBackground,
            appBarTheme: AppBarTheme(
              color: myCustomColors.loginBackgroud,
            )),
        home: FutureBuilder<Diagnostics>(
            future: diagnosisProider.fetchDiagnostics(pharmacyId),
            builder: (context , snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.none &&
                  snapshot.hasData == null) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              print(
                  'project snapshot data is: ${snapshot.data}');
              if (snapshot.data == null) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else {
                return  Scaffold(
                  appBar: AppBar(
                    title: Text(widget.diagnosis.title),
                    actions: [
                      IconButton(
                        padding: EdgeInsets.only(right: 15),
                        onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DiagnosisDetail(
                                    diagnosis: widget.diagnosis,
                                  )));
                        },
                        icon: Icon(
                            Icons.done_all_outlined
                        ),
                      ),
                    ],
                  ),
                  drawer: Drawer(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children:<Widget>[
                        Expanded(
                          // width: MediaQuery.of(context).size.width,
                          child:ListView(
                            // Important: Remove any padding from the ListView.
                            padding: EdgeInsets.zero,
                            children: <Widget>[
                              //new Container(child: new DrawerHeader(child: new CircleAvatar()),color: myCustomColors.loginBackgroud,),
                              UserAccountsDrawerHeader(
                                decoration: BoxDecoration(color: myCustomColors.loginBackgroud),
                                accountName: Text(snapshot.data.name),
                                accountEmail: Text(snapshot.data.email),
                                currentAccountPicture: CircleAvatar(
                                  //backgroundColor: myCustomColors.loginButton,
                                  // child: Text(
                                  //   "A",
                                  //   style: TextStyle(
                                  //       fontSize: 40.0, color: myCustomColors.loginBackgroud),
                                  // ),
                                  backgroundImage: NetworkImage(snapshot.data.image),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.contacts),
                                title: Text("Contact Us"),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.rate_review),
                                title: Text("Rate Us"),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.lock),
                                title: Text("Privacy Policy"),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.shield),
                                title: Text("Terms & Conditions"),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.flag),
                                title: Text("Transactions"),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.credit_card_rounded),
                                title: Text("Credit"),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.logout),
                                title: Text("Log Out"),
                                onTap: () {
                                  authProvider.signOut();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => LoginForm(),
                                    ),
                                        (route) => false,
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.add),
                                title: Text("Add Images"),
                                onTap: (){
                                  handleClick(0);
                                },
                              ),
                              Divider(),
                            ],

                          ),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: Icon(MdiIcons.telegram),
                            ),
                            IconButton(
                              onPressed: (){},
                              icon: Icon(MdiIcons.gmail),
                            ),
                            IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.facebook_outlined),
                            ),
                          ],
                        )
                      ],


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
                                (snapshot.data.images== null || snapshot.data.images.length==0)
                                    ? Container(
                                  height: 80,
                                  child: Center(
                                    child: Text(
                                      "No Images Available",
                                    ),
                                  ),
                                ):
                                Swiper(
                                  itemCount: snapshot.data.images.length,
                                  layout: SwiperLayout.STACK,
                                  scrollDirection: Axis.horizontal,
                                  autoplay: true,
                                  pagination: SwiperPagination(
                                    alignment: Alignment.bottomCenter,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      snapshot.data.images[index],
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  itemHeight: MediaQuery.of(context).size.width * 0.40,
                                  itemWidth: MediaQuery.of(context).size.width,
                                ),
                                // Container(
                                //     padding: EdgeInsets.only(left:30,top: 30),
                                //     width: MediaQuery.of(context).size.width,
                                //     child:Text(
                                //       'Services',
                                //       textScaleFactor: 1.5,
                                //       textAlign: TextAlign.left,
                                //       overflow: TextOverflow.ellipsis,
                                //       style: const TextStyle(fontWeight: FontWeight.bold),
                                //     )
                                //
                                // ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.03,
                                      30,
                                      MediaQuery.of(context).size.width * 0.03,
                                      5),
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Services',
                                        textScaleFactor: 1.5,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10,),
                                      IconButton(
                                          onPressed: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AddServices(hospitalLabDiagnosis: widget.diagnosis,index: 1,)
                                                ));
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            size: 30,
                                          )
                                      )
                                      // GestureDetector(
                                      //     onTap: (){
                                      //       Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) => SeeAllServices()
                                      //           ));
                                      //     },
                                      //   child: Text(
                                      //     'See All',
                                      //     textScaleFactor: 1.3,
                                      //     textAlign: TextAlign.left,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     style: const TextStyle(fontWeight: FontWeight.bold,
                                      //     color: Colors.blueAccent),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                                FutureBuilder<List<HospServicesTypes>>(
                                    future: hosProvider.getAllHospServiceTypes(),
                                    builder: (context , hospServSnapshot) {
                                      if (hospServSnapshot.connectionState ==
                                          ConnectionState.none &&
                                          hospServSnapshot.hasData == null) {
                                        return Container(
                                          height: 110,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }
                                      print(
                                          'project snapshot data is: ${hospServSnapshot.data}');
                                      if (hospServSnapshot.data == null) {
                                        return Container(
                                          height: 110,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }
                                      else {
                                        return Container(
                                            height: 110.0,
                                            margin: EdgeInsets.fromLTRB(
                                                MediaQuery.of(context).size.width * 0.07,
                                                5,
                                                MediaQuery.of(context).size.width * 0.07,
                                                30),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (BuildContext ctxt, int index) {
                                                return _buildHopitalServicesListItem(
                                                    hospServSnapshot.data[index], ctxt);
                                              },
                                              itemCount: hospServSnapshot.data.length,
                                            ));
                                      }
                                    }),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(top:10,bottom: 30),
                                        child:Text(
                                          widget.diagnosis.name,
                                          textAlign: TextAlign.left,
                                          textScaleFactor: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        )
                                    ),
                                    // Container(
                                    //     padding: EdgeInsets.only(top:10,bottom: 30, left: 10),
                                    //     child:IconButton(
                                    //         onPressed: (){
                                    //           print(widget.hospital.name);
                                    //           _messageControler.text = widget.hospital.name;
                                    //           editMessageInfoLocName(context, "Name", widget.hospital.name, 1);
                                    //         },
                                    //         icon: Icon(
                                    //             Icons.edit_outlined
                                    //         )))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(top:10,bottom: 30),
                                        child:IconButton(
                                            onPressed: (){
                                              _messageControler.text = widget.diagnosis.detail;
                                           //   editMessageDescription(context, "Description", widget.diagnosis.detail);
                                            },
                                            icon: Icon(
                                                Icons.edit_outlined
                                            ))),
                                    Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                        width: MediaQuery.of(context).size.width*0.85,
                                        child: Center(
                                          child: Text(
                                            widget.diagnosis.detail,
                                            textDirection: TextDirection.ltr,
                                            maxLines: 15,
                                          ),
                                        )
                                    ),


                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        children:[
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(top: 10),
                                                child: IconButton(
                                                  onPressed: (){
                                                    _messageControler.text = widget.diagnosis.officeHours;
                                                    _firstTime= widget.diagnosis.officeHours.split("-").first;
                                                    _secondTime=widget.diagnosis.officeHours.split("-").last;
                                                    editMessageOfficeHours(context, "Office hours", _firstTime, _secondTime);
                                                  },
                                                  icon: Icon(
                                                      Icons.edit_outlined
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(top: 10),
                                                child:Text(
                                                  'Office Hours',
                                                  textScaleFactor: 1.5,
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                              ),

                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left:30,top: 10),
                                            width: 150,
                                            child:Text(
                                              widget.diagnosis.officeHours,
                                              textAlign: TextAlign.left,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                          ),
                                        ]),
                                    Column(
                                        children:[
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(top: 10),
                                                child: IconButton(
                                                  onPressed: (){
                                                    _messageControler.text = widget.diagnosis.info;
                                                    //editMessageInfoLocName(context, "Additional Information", widget.diagnosis.info,2);
                                                  },
                                                  icon: Icon(
                                                      Icons.edit_outlined
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(top: 10, right: 20),
                                                child:Text(
                                                  'Information',
                                                  textScaleFactor: 1.5,
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                              ),

                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(right:30,top: 10),
                                            width: 150,
                                            child:Text(
                                              widget.diagnosis.info,
                                              maxLines: 3,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                          ),
                                        ])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        children:[
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(top: 10),
                                                child: IconButton(
                                                  onPressed: (){
                                                    _messageControler.text = widget.diagnosis.location;
                                                    //editMessageInfoLocName(context, "Location", widget.diagnosis.location, 3);
                                                  },
                                                  icon: Icon(
                                                      Icons.edit_outlined
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(top: 10),
                                                child:Text(
                                                  'Location',
                                                  textScaleFactor: 1.5,
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                              ),

                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left:30,top: 10),
                                            width: 120,
                                            child:Text(
                                              widget.diagnosis.location,
                                              textAlign: TextAlign.left,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                          ),
                                        ]),
                                    Column(
                                        children:[
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(top: 10),
                                                child: IconButton(
                                                  onPressed: (){
                                                    _messageControler.text = widget.diagnosis.phone;
                                                    editMessagePhone(context, "Phone", widget.diagnosis.phone);
                                                  },//0967417519
                                                  icon: Icon(
                                                      Icons.edit_outlined
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(top: 10, right: 25),
                                                child:Text(
                                                  'Phone No.',
                                                  textScaleFactor: 1.5,
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left:20,right: 50, top: 10),
                                                width: 120,
                                                child:Text(
                                                  widget.diagnosis.phone,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                ),

                                              ),
                                            ],
                                          )
                                        ])
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
                );
              }
            }),
       );
  }
  final _messageControler = TextEditingController();

  _buildHopitalServicesListItem(var hospitalServices, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                // builder: (context) => ListInServices()
                  builder: (context) => DetailServiceEdit(hospitalServices:hospitalServices, hospitalLabDiagnosis: widget.diagnosis,)
              ));
        },
        child: Card(
            elevation: 0,
            color: myCustomColors.mainBackground,
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150.0),
                  ),
                  // // c
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: Image.network(
                      hospitalServices.image,
                      fit: BoxFit.fitHeight,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
                Text(
                  hospitalServices.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }

  editMessageDescription(BuildContext context, String title, String message, String diagnosticId){
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(  // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit $title?'),
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
                                                width: MediaQuery.of(context).size.width * 0.90,
                                                child: TextFormField(
                                                  controller: _messageControler,
                                                  autocorrect: true,
                                                  maxLines: 15,
                                                  keyboardType: TextInputType.name,
                                                  validator: (String value){
                                                    if (value==null){
                                                      return '$title is required!';
                                                    }
                                                    if (value==''){
                                                      return '$title is required!';
                                                    }
                                                    if (value.length<4){
                                                      return "Has to be at least 4 letters";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (String value){
                                                    setState(() {
                                                      widget.diagnosis.detail=value;
                                                      FirebaseFirestore.instance.collection('diagnostics')
                                                          .doc(diagnosticId)
                                                          .update({'description': widget.diagnosis.detail})
                                                          .then((value) => print("Detail Updated"))
                                                          .catchError((error) => print("Failed to update user: $error"));
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: '$title',
                                                    hintText: title,
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
                            Navigator.of(context).pop();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => HospitalEdit(hospital: widget.hospital)));
                          }
                        }),
                  ],
                );
              });
        });
  }

  editMessagePhone(BuildContext context, String title, String message){
    int _phone;
    String _countryCode;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(  // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit $title?'),
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
                                                padding: EdgeInsets.only(top:40.0,bottom: 40.0),
                                                width: MediaQuery.of(context).size.width * 0.9,
                                                child: TextFormField(
                                                  controller: _messageControler,
                                                  autocorrect: true,
                                                  maxLength: 10,
                                                  maxLines: 1,
                                                  keyboardType: TextInputType.phone,
                                                  validator: (value){
                                                    if (value==null){
                                                      return 'Phone number is required!';
                                                    }
                                                    if (value==''){
                                                      return 'Please provide you Phone number';
                                                    }
                                                    if (value.length<9){
                                                      return 'Please provide you complete Phone number';
                                                    }
                                                    if (!RegExp(r"^[0-9]+").hasMatch(value)){
                                                      return "Incorrect give a valid phone number";
                                                    }
                                                    if(value.substring(0,2)=="09"){
                                                      if(value.length!=10){
                                                        return 'Please complete your phone';
                                                      }
                                                    }

                                                    if(value.substring(0,1)=="9"){
                                                      if(value.length==10){
                                                        return 'You have longer phone number or start with "09"';
                                                      }
                                                      if(value.length!=9){
                                                        return 'Please provide you complete Phone number';
                                                      }
                                                    }
                                                    if (value.length==10){
                                                      if(value.substring(0,2)!="09"){
                                                        return 'Please give the right phone number';
                                                      }
                                                    }
                                                    if (value.length==9){
                                                      if(value.substring(0,1)!="9"){
                                                        return 'Please give the right phone number';
                                                      }
                                                    }

                                                    return null;
                                                  },
                                                  onSaved: (value){
                                                    setState(() {
                                                      _countryCode==null?
                                                      _countryCode="+251":_countryCode=_countryCode;
                                                      String temp0Checker =value.substring(0,1);
                                                      temp0Checker=="0"?
                                                      _phone= int.tryParse(value.substring(1,10)):
                                                      temp0Checker=="9"?
                                                      _phone= int.tryParse(value.substring(0,9)):
                                                      _phone= int.tryParse(value);

                                                      print("on save text");

                                                    });
                                                  },
                                                  onChanged: (value){
                                                    setState(() {
                                                      // _countryCode==null?
                                                      // _countryCode="+251":_countryCode=_countryCode;
                                                      // print("on change text");
                                                      // String temp0Checker =value.substring(1,9);
                                                      // temp0Checker=="0"?
                                                      // _phone= int.tryParse(value.substring(1,10)):
                                                      // temp0Checker=="9"?
                                                      // _phone= int.tryParse(value.substring(0,9)):
                                                      // _phone= int.tryParse(value);
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: '900000000',
                                                    labelText: 'Phone Number',
                                                    labelStyle: TextStyle(color: myCustomColors.loginBackgroud),
                                                    counterStyle: TextStyle(color: Colors.white54),
                                                    prefixIcon: CountryCodePicker(
                                                      onChanged: (value){
                                                        setState(() {
                                                          _countryCode= value.dialCode;
                                                          _countryCode==null?
                                                          _countryCode="+251":_countryCode=_countryCode;
                                                        });
                                                      },
                                                      backgroundColor: Colors.white,
                                                      initialSelection: 'ET',
                                                      favorite: ['+251','ET'],
                                                      showCountryOnly: false,
                                                      showOnlyCountryWhenClosed: false,
                                                      alignLeft: false,
                                                    ),

                                                    hintStyle: TextStyle(color: myCustomColors.loginBackgroud),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                      borderSide: BorderSide(
                                                          color: myCustomColors.loginButton,
                                                          width: 2
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.green, width: 2),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.green, width: 2),
                                                    ),
                                                  ),
                                                )
                                            ))),
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
                        _formKey.currentState.validate();
                        _formKey.currentState.save();
                        if (_formKey.currentState.validate()) {
                          String fullPhone;
                          _countryCode==null?
                          fullPhone= "+251" +_phone.toString()
                              :fullPhone= _countryCode.toString() +_phone.toString();
                          setState((){
                            //widget.hospital.phone=fullPhone;
                            FirebaseFirestore.instance.collection('hospital')
                                .doc('3nPWouBvXSjpDLwbXXER')
                                .update({'phone': fullPhone})
                                .then((value) => print("Detail Updated"))
                                .catchError((error) => print("Failed to update user: $error"));
                          });
                        }
                        if (_formKey.currentState.validate()) {

                          _formKey.currentState.save();
                          Navigator.of(context).pop();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => HospitalEdit(hospital: widget.hospital)));
                        }

                      },)
                  ],
                );
              });
        });
  }

  editMessageOfficeHours(BuildContext context, String title, String first, String last){
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(  // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit $title?'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding : EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          width: MediaQuery.of(context).size.width*0.85,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                children: [
                                  Text(
                                      "Opened at"
                                  ),
                                  Text(
                                      first
                                  ),
                                  ElevatedButton(
                                    onPressed: (){
                                      _start();
                                      setState(
                                              (){
                                            first=_firstTime;
                                          }
                                      );
                                    },
                                    child: Text(
                                        "Edit"
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                      "Closed at"
                                  ),
                                  Text(
                                    last,
                                  ),
                                  ElevatedButton(
                                    onPressed: (){
                                      _end();
                                      setState(
                                              (){
                                            last=_secondTime;

                                          }

                                      );
                                    },
                                    child: Text(
                                        "Edit"
                                    ),
                                  )
                                ],
                              ),
                            ],
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
                                    Icon(Icons.done),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Save')
                                  ])),
                        ),
                        onPressed: () {
                          setState(() {
                            //widget.hospital.officeHours=("$_firstTime - $_secondTime");
                            FirebaseFirestore.instance.collection('hospital')
                                .doc('3nPWouBvXSjpDLwbXXER')
                                .update({'officehours': "$_firstTime - $_secondTime"})
                                .then((value) => print("Detail Updated"))
                                .catchError((error) => print("Failed to update user: $error"));
                            Navigator.of(context).pop();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => HospitalEdit(hospital: widget.hospital)));
                          }
                          );
                        })
                  ],
                );
              });
        });
  }

  // editMessageInfoLocName(BuildContext context, String title, String message, int code){
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(  // You need this, notice the parameters below:
  //             builder: (BuildContext context, StateSetter setState) {
  //               return AlertDialog(
  //                 title: Text('Edit $title?'),
  //                 content: SingleChildScrollView(
  //                   child: Stack(
  //                     children: <Widget>[
  //                       Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           Form(
  //                             key: _formKey,
  //                             child: Column(
  //                                 children:[
  //                                   Container(
  //                                       child: Center(
  //                                           child: Container(
  //                                               padding: EdgeInsets.fromLTRB(10,5,10,25),
  //                                               width: MediaQuery.of(context).size.width * 0.90,
  //                                               child: TextFormField(
  //                                                 controller: _messageControler,
  //                                                 autocorrect: true,
  //                                                 maxLines: 3,
  //                                                 keyboardType: TextInputType.name,
  //                                                 validator: (String value){
  //                                                   if (value==null){
  //                                                     return '$title is required!';
  //                                                   }
  //                                                   if (value==''){
  //                                                     return '$title is required!';
  //                                                   }
  //                                                   if (value.length<4){
  //                                                     return "Has to be at least 4 letters";
  //                                                   }
  //                                                   return null;
  //                                                 },
  //                                                 onSaved: (String value){
  //                                                   setState(() {
  //                                                     switch(code){
  //                                                       case 1: {
  //                                                         widget.hospital.name=value;
  //                                                         print(widget.hospital.name);
  //                                                         print(value);
  //
  //                                                       }
  //                                                       break;
  //                                                       case 2: {
  //                                                         widget.hospital.info=value;
  //                                                         print(widget.hospital.info);
  //                                                         print(value);
  //                                                       }
  //                                                       break;
  //                                                       case 3: {
  //                                                         widget.hospital.location=value;
  //                                                         print(widget.hospital.location);
  //                                                         print(value);
  //                                                       }
  //                                                       break;
  //
  //                                                       default: {
  //                                                         //statements;
  //                                                       }
  //                                                       break;
  //                                                     }
  //                                                   });
  //                                                 },
  //                                                 decoration: InputDecoration(
  //                                                   labelText: '$title',
  //                                                   hintText: title,
  //                                                   labelStyle: TextStyle(color: myCustomColors.loginBackgroud),
  //                                                   prefixIcon: Icon(
  //                                                     Icons.edit,
  //                                                     color: myCustomColors.loginBackgroud,
  //                                                   ),
  //                                                   counterStyle: TextStyle(color: Colors.white54),
  //                                                   hintStyle: TextStyle(color: myCustomColors.loginBackgroud),
  //                                                   filled: true,
  //                                                   fillColor: Colors.white,
  //                                                   enabledBorder: OutlineInputBorder(
  //                                                     borderRadius: BorderRadius.all(
  //                                                         Radius.circular(40.0)),
  //                                                     borderSide: BorderSide(
  //                                                         color: Colors.green, width: 2),
  //                                                   ),
  //                                                   border: OutlineInputBorder(
  //                                                     borderRadius: const BorderRadius.all(
  //                                                       const Radius.circular(40.0),
  //                                                     ),
  //                                                     borderSide: BorderSide(
  //                                                         color: Colors.green, width: 2),
  //                                                   ),
  //                                                   focusedBorder: OutlineInputBorder(
  //                                                     borderRadius: BorderRadius.all(
  //                                                         Radius.circular(40.0)),
  //                                                     borderSide: BorderSide(
  //                                                         color: Colors.green, width: 2),
  //                                                   ),
  //                                                 ),
  //                                               )))),
  //                                 ]
  //                             ),
  //                           ),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 actions: [
  //                   new ElevatedButton(
  //                       child: new Center(
  //                         child: Container(
  //                             child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 mainAxisSize: MainAxisSize.max,
  //                                 children: [
  //                                   Icon(Icons.done),
  //                                   SizedBox(
  //                                     width: 10,
  //                                   ),
  //                                   Text('Save')
  //                                 ])),
  //                       ),
  //                       onPressed: () {
  //                         if (_formKey.currentState.validate()) {
  //                           _formKey.currentState.save();
  //                           Navigator.of(context).pop();
  //                           Navigator.of(context).pop();
  //                           Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                   builder: (context) => HospitalEdit(hospital: widget.hospital)));
  //                         }
  //                       }),
  //                 ],
  //               );
  //             });
  //       });
  // }
  String _firstTime="";
  String _secondTime="";
  Future<void> _start() async {
    final TimeOfDay result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _firstTime = result.format(context);
      });
    }
  }
  Future<void> _end() async {
    final TimeOfDay result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _secondTime = result.format(context);
      });
    }
  }
}

