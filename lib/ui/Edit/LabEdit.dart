import 'package:alen/ui/Details/LabDetail.dart';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/Services/HospitalServices.dart';
import 'package:alen/ui/serviceAdder/LaboratoryServieAdder.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../AppColors.dart';
import 'DetailServiceEdit.dart';
import 'MultiImageDemo.dart';

class LabEdit extends StatefulWidget {
  final HospitalLabDiagnosis lab;
  const LabEdit({Key key, this.lab,}) : super(key: key);

  @override
  _LabEditState createState() => _LabEditState();
}

class _LabEditState extends State<LabEdit> {

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
    void handleClick(int item) {
      switch (item) {
        case 0:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultipleImageDemo(hospital: widget.lab,)//(hospital: widget.hospital,)
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
        home: Scaffold(
          appBar: AppBar(
            title: Text(widget.lab.title),
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 15),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LabDetail(
                            lab: widget.lab,
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
                        accountName: Text("User Name"),
                        accountEmail: Text("abhishekm977@gmail.com"),
                        currentAccountPicture: CircleAvatar(
                          //backgroundColor: myCustomColors.loginButton,
                          // child: Text(
                          //   "A",
                          //   style: TextStyle(
                          //       fontSize: 40.0, color: myCustomColors.loginBackgroud),
                          // ),
                          backgroundImage: AssetImage('assets/images/alen_no_name.png'),
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
                        Swiper(
                          itemCount: widget.lab.imagesList.length,
                          layout: SwiperLayout.STACK,
                          scrollDirection: Axis.horizontal,
                          autoplay: true,
                          pagination: SwiperPagination(
                            alignment: Alignment.bottomCenter,
                          ),
                          itemBuilder: (context, index) {
                            return Image.asset(
                              widget.lab.imagesList[index],
                              fit: BoxFit.cover,
                            );
                          },
                          itemHeight: MediaQuery.of(context).size.width * 0.40,
                          itemWidth: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.03,
                              40,
                              MediaQuery.of(context).size.width * 0.03,
                              10),
                          child: ElevatedButton(
                            onPressed: (){
                              //addProduct(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddServices(hospitalLabDiagnosis: widget.lab,index: 0,)
                                  ));
                            },
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
                            child: Container(
                                height: 50,
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Add Service',
                                      textScaleFactor: 1.5,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.add,
                                        size: 30,
                                      ),
                                    )
                                  ],)
                            ),
                          ),
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
                              // SizedBox(width: 10,),
                              // IconButton(
                              //     onPressed: (){
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => AddServices(hospitalLabDiagnosis: widget.lab,index: 2,)
                              //           ));
                              //     },
                              //     icon: Icon(
                              //       Icons.add,
                              //       size: 30,
                              //     )
                              // )
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
                        Container(
                            height: 110.0,//TODO make this width
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.07,
                                5,
                                MediaQuery.of(context).size.width * 0.07,
                                30),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return _buildHopitalServicesListItem(
                                    widget.lab.services[index], ctxt);
                              },
                              itemCount: widget.lab.services.length,
                            )),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.only(top:10,bottom: 30),
                                child:Text(
                                  widget.lab.name,
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
                                      _messageControler.text = widget.lab.detail;
                                      editMessageDescription(context, "Description", widget.lab.detail);
                                    },
                                    icon: Icon(
                                        Icons.edit_outlined
                                    ))),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                width: MediaQuery.of(context).size.width*0.85,
                                child: Center(
                                  child: Text(
                                    widget.lab.detail,
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
                                            _messageControler.text = widget.lab.officeHours;
                                            _firstTime= widget.lab.officeHours.split("-").first;
                                            _secondTime=widget.lab.officeHours.split("-").last;
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
                                      widget.lab.officeHours,
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
                                            _messageControler.text = widget.lab.info;
                                            editMessageInfoLocName(context, "Additional Information", widget.lab.info,2);
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
                                      widget.lab.info,
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
                                            _messageControler.text = widget.lab.location;
                                            editMessageInfoLocName(context, "Location", widget.lab.location, 3);
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
                                      widget.lab.location,
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
                                            _messageControler.text = widget.lab.phone;
                                            editMessagePhone(context, "Phone", widget.lab.phone);
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
                                          widget.lab.phone,
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
        ));
  }
  final _messageControler = TextEditingController();

  _buildHopitalServicesListItem(HospitalServices hospitalServices, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                // builder: (context) => ListInServices()
                  builder: (context) => DetailServiceEdit(hospitalServices:hospitalServices, hospitalLabDiagnosis: widget.lab,)
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
                    child: Image.asset(
                      hospitalServices.imagePath,
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

  editMessageDescription(BuildContext context, String title, String message){
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
                                                      widget.lab.detail=value;
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
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LabEdit(lab: widget.lab)));
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
                            widget.lab.phone=fullPhone;
                          });
                        }
                        if (_formKey.currentState.validate()) {

                          _formKey.currentState.save();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LabEdit(lab: widget.lab)));
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
                            widget.lab.officeHours=("$_firstTime - $_secondTime");
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LabEdit(lab: widget.lab)));

                          }
                          );
                        })
                  ],
                );
              });
        });
  }

  editMessageInfoLocName(BuildContext context, String title, String message, int code){
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
                                                  maxLines: 3,
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
                                                      switch(code){
                                                        case 1: {
                                                          widget.lab.name=value;
                                                          print(widget.lab.name);
                                                          print(value);

                                                        }
                                                        break;
                                                        case 2: {
                                                          widget.lab.info=value;
                                                          print(widget.lab.info);
                                                          print(value);
                                                        }
                                                        break;
                                                        case 3: {
                                                          widget.lab.location=value;
                                                          print(widget.lab.location);
                                                          print(value);
                                                        }
                                                        break;

                                                        default: {
                                                          //statements;
                                                        }
                                                        break;
                                                      }
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
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LabEdit(lab: widget.lab)));
                          }
                        }),
                  ],
                );
              });
        });
  }
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

