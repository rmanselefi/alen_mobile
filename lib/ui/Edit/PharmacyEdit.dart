import 'dart:io';

import 'package:alen/models/pharmacy.dart';
import 'package:alen/providers/auth.dart';
import 'package:alen/providers/drug.dart';
import 'package:alen/providers/pharmacy.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:alen/ui/Details/PharmacyDetail.dart';
import 'package:alen/ui/Edit/DetailCategoryEdit.dart';
import 'package:alen/ui/MyImagesList.dart';
import 'package:alen/ui/Parents/Interfaces.dart';
import 'package:alen/ui/ServiceCategory/Category.dart';
import 'package:alen/ui/Services/PharmacistsServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../AppColors.dart';
import 'MultiImagePharmacy.dart';

class PharmacyEdit extends StatefulWidget {
  final ImporterPharmacy pharmacy;
  const PharmacyEdit({Key key, this.pharmacy,}) : super(key: key);

  @override
  _PharmacyEditState createState() => _PharmacyEditState();
}

class _PharmacyEditState extends State<PharmacyEdit> {

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
    var pharmacyProvider = Provider.of<PharmacyProvider>(context, listen: false);
    var drugProvider = Provider.of<DrugProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    String pharmacyId;
    UserPreferences().getId().then((value) => pharmacyId=value);
    print(pharmacyId);
    // final PageController controller = PageController(initialPage: 0);
    void handleClick(int item) {
      switch (item) {
        case 0:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiImagePharmacy(importerPharmacy: widget.pharmacy,)//(hospital: widget.hospital,)
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
        home: FutureBuilder<Pharmacies>(
            future: pharmacyProvider.fetchPharmacy(pharmacyId),
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
                return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.pharmacy.title),
                    actions: [
                      IconButton(
                        padding: EdgeInsets.only(right: 15),
                        onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PharamacyDetail(
                                    pharmacy: widget.pharmacy,
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
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.03,
                                      40,
                                      MediaQuery.of(context).size.width * 0.03,
                                      10),
                                  child: ElevatedButton(
                                    onPressed: (){
                                      //addProduct(context);
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
                                              'Add Product',
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
                                          'Categories',
                                          textScaleFactor: 1.5,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 10,),

                                      ]
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
                                            widget.pharmacy.services[index], ctxt);
                                      },
                                      itemCount: widget.pharmacy.services.length,
                                    )),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(top:10,bottom: 30),
                                        child:Text(
                                          snapshot.data.name,
                                          textAlign: TextAlign.left,
                                          textScaleFactor: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        )
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(top:10,bottom: 30),
                                        child:IconButton(
                                            onPressed: (){
                                              _messageControler.text = snapshot.data.description;
                                              editMessageDescription(context, "Description", snapshot.data.description, pharmacyId);
                                            },
                                            icon: Icon(
                                                Icons.edit_outlined
                                            ))),
                                    Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                        width: MediaQuery.of(context).size.width*0.85,
                                        child: Center(
                                          child: Text(
                                            snapshot.data.description,
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
                                                    _messageControler.text = widget.pharmacy.officeHours;
                                                    _firstTime= widget.pharmacy.officeHours.split("-").first;
                                                    _secondTime=widget.pharmacy.officeHours.split("-").last;
                                                    editMessageOfficeHours(context, "Office hours", _firstTime, _secondTime, pharmacyId);
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
                                              snapshot.data.officehours,
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
                                                    _messageControler.text = widget.pharmacy.info;
                                                    editMessageInfoLocName(context, "Additional Information", widget.pharmacy.info,2);
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
                                              'widget.hospital.info',
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
                                                    _messageControler.text = snapshot.data.longitude.toString();
                                                    editMessageInfoLocName(context, "Location", snapshot.data.longitude.toString() , 3);
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
                                              "${snapshot.data.latitude.toStringAsFixed(4)+" - "+snapshot.data.longitude.toStringAsFixed(4)}",
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
                                                    _messageControler.text = snapshot.data.phone;
                                                    editMessagePhone(context, "Phone", snapshot.data.phone, pharmacyId);
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
                                                  snapshot.data.phone,
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

  _buildHopitalServicesListItem(PharmacyServices pharmacyServices, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                // builder: (context) => ListInServices()
                  builder: (context) => DetailCategoryEdit(pharmacyServices:pharmacyServices, importerPharmacy: widget.pharmacy,)
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
                      pharmacyServices.imagePath,
                      fit: BoxFit.fitHeight,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
                Text(
                  pharmacyServices.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }

  // editMessageDescription(BuildContext context, String title, String message){
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
  //                                                 maxLines: 15,
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
  //                                                     widget.pharmacy.detail=value;
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
  //                                   builder: (context) => PharmacyEdit(pharmacy: widget.pharmacy)));
  //                         }
  //                       }),
  //                 ],
  //               );
  //             });
  //       });
  // }
  //
  //
  // List<String> PopulateCategoryList(){
  //   List<String> categoryList= [];
  //   PharmacyServices.pharmacyServices.forEach((element) {
  //     categoryList.add(element.name);
  //   });
  //   return categoryList;
  // }
  // void Switcher(Category category, String text){
  //   PharmacyServices.pharmacyServices.forEach((element) {
  //     if(element.name==text){
  //       element.categores.add(category);
  //       widget.pharmacy.services.add(element);
  //     }
  //   });
  //
  // }

  String _category;
  String _name;
  String _detail;
  double _price;
  File _image;
  final picker = ImagePicker();

  // Future getImage(BuildContext ctxt) async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //
  //   }
  //   );
  //   addProduct(ctxt);
  // }
  

  // addProduct(BuildContext ctxt){
  //   return showDialog(
  //       context: ctxt,
  //       builder: (context) {
  //         return StatefulBuilder(  // You need this, notice the parameters below:
  //             builder: (BuildContext context, StateSetter setState) {
  //               return AlertDialog(
  //                 title: Text('Add Product?'),
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
  //                                               padding: EdgeInsets.fromLTRB(10,5,10,0),
  //                                               width: MediaQuery.of(context).size.width * 0.90,
  //                                               child: FormField<String>(
  //                                                 validator: (value) {
  //                                                   if (_image == null) {
  //                                                     return "Select the Image";
  //                                                   }
  //                                                 },
  //                                                 builder: (
  //                                                     FormFieldState<String> state,
  //                                                     ) {
  //                                                   return Column(
  //                                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                                     children: <Widget>[
  //                                                       new InputDecorator(
  //                                                         decoration: const InputDecoration(
  //                                                           counterStyle: TextStyle(color: Colors.white54),
  //                                                           enabledBorder: OutlineInputBorder(
  //                                                             borderRadius: BorderRadius.all(
  //                                                                 Radius.circular(40.0)),
  //                                                             borderSide: BorderSide(
  //                                                                 color: Colors.green, width: 2),
  //                                                           ),
  //                                                           border: OutlineInputBorder(
  //                                                             borderRadius: const BorderRadius.all(
  //                                                               const Radius.circular(40.0),
  //                                                             ),
  //                                                             borderSide: BorderSide(
  //                                                                 color: Colors.green, width: 2),
  //                                                           ),
  //                                                           focusedBorder: OutlineInputBorder(
  //                                                             borderRadius: BorderRadius.all(
  //                                                                 Radius.circular(40.0)),
  //                                                             borderSide: BorderSide(
  //                                                                 color: Colors.green, width: 2),
  //                                                           ),
  //                                                           hintStyle: TextStyle(color: const Color(0xFF9516B6)),
  //                                                           filled: true,
  //                                                           fillColor: Colors.white,
  //                                                           contentPadding: EdgeInsets.all(0.0),
  //                                                           labelText: 'Image',
  //                                                           hintText: 'Image',
  //                                                           labelStyle: TextStyle(color: const Color(0xFF9516B6)),
  //
  //                                                         ),
  //                                                         child: Container(
  //                                                             padding: EdgeInsets.all(30, ),
  //                                                             child:SizedBox(
  //                                                               height: 150,
  //                                                               width: MediaQuery.of(ctxt).size.width*0.5,
  //                                                               child: GestureDetector(
  //                                                                 onTap: (){
  //                                                                   Navigator.pop(context);
  //                                                                   getImage(ctxt);
  //                                                                 },
  //                                                                 child: (_image==null)?Image.asset(
  //                                                                   'assets/images/addPrescription.jpg',
  //                                                                   height: 150,
  //                                                                   width: MediaQuery.of(ctxt).size.width*0.5,
  //                                                                   fit: BoxFit.contain,
  //                                                                 ):Image.file(
  //                                                                   (_image),
  //                                                                   height: 150,
  //                                                                   width: MediaQuery.of(ctxt).size.width*0.5,
  //                                                                   fit: BoxFit.contain,
  //                                                                 ),
  //                                                               )
  //                                                             )
  //                                                         )
  //
  //                                                       ),
  //                                                       SizedBox(height: 5.0),
  //                                                       Text(
  //                                                         state.hasError ? state.errorText : '',
  //                                                         style:
  //                                                         TextStyle(color: Colors.redAccent.shade700, fontSize: 12.0),
  //                                                       ),
  //                                                     ],
  //                                                   );
  //                                                 },
  //                                               )
  //                                           ))),
  //                                   Container(
  //                                       child: Center(
  //                                           child: Container(
  //                                               padding: EdgeInsets.fromLTRB(10,5,10,25),
  //                                               width: MediaQuery.of(context).size.width * 0.90,
  //                                               child: TextFormField(
  //                                                 autocorrect: true,
  //                                                 maxLines: 1,
  //                                                 keyboardType: TextInputType.name,
  //                                                 validator: (String value){
  //                                                   if (value==null){
  //                                                     return 'Product name is required!';
  //                                                   }
  //                                                   if (value==''){
  //                                                     return 'Product name is required!';
  //                                                   }
  //                                                   if (value.length<4){
  //                                                     return "Has to be at least 4 letters";
  //                                                   }
  //                                                   return null;
  //                                                 },
  //                                                 onSaved: (String value){
  //                                                   setState(() {
  //                                                     _name=value;
  //                                                   });
  //                                                 },
  //                                                 decoration: InputDecoration(
  //                                                   labelText: 'Product Name',
  //                                                   hintText: 'Product Name',
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
  //                                   Container(
  //                                       child: Center(
  //                                           child: Container(
  //                                               padding: EdgeInsets.fromLTRB(10,5,10,0),
  //                                               width: MediaQuery.of(context).size.width * 0.90,
  //                                               child: FormField<String>(
  //                                                 validator: (value) {
  //                                                   if (value == null) {
  //                                                     return "Select the Category";
  //                                                   }
  //                                                 },
  //                                                 onSaved: (value) {
  //                                                   _category = value;
  //                                                 },
  //                                                 builder: (
  //                                                     FormFieldState<String> state,
  //                                                     ) {
  //                                                   return Column(
  //                                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                                     children: <Widget>[
  //                                                       new InputDecorator(
  //
  //                                                         decoration: const InputDecoration(
  //                                                           counterStyle: TextStyle(color: Colors.white54),
  //                                                           enabledBorder: OutlineInputBorder(
  //                                                             borderRadius: BorderRadius.all(
  //                                                                 Radius.circular(40.0)),
  //                                                             borderSide: BorderSide(
  //                                                                 color: Colors.green, width: 2),
  //                                                           ),
  //                                                           border: OutlineInputBorder(
  //                                                             borderRadius: const BorderRadius.all(
  //                                                               const Radius.circular(40.0),
  //                                                             ),
  //                                                             borderSide: BorderSide(
  //                                                                 color: Colors.green, width: 2),
  //                                                           ),
  //                                                           focusedBorder: OutlineInputBorder(
  //                                                             borderRadius: BorderRadius.all(
  //                                                                 Radius.circular(40.0)),
  //                                                             borderSide: BorderSide(
  //                                                                 color: Colors.green, width: 2),
  //                                                           ),
  //                                                           hintStyle: TextStyle(color: const Color(0xFF9516B6)),
  //                                                           filled: true,
  //                                                           fillColor: Colors.white,
  //                                                           contentPadding: EdgeInsets.all(0.0),
  //                                                           labelText: 'Category',
  //                                                           hintText: 'Category',
  //                                                           labelStyle: TextStyle(color: const Color(0xFF9516B6)),
  //                                                           prefixIcon: Icon(
  //                                                             Icons.category_outlined,
  //                                                             color: const Color(0xFF9516B6),
  //                                                           ),
  //                                                         ),
  //                                                         child: DropdownButtonHideUnderline(
  //                                                           child: DropdownButton<String>(
  //                                                             hint: new Text("Select the Category"),
  //                                                             value: _category,
  //                                                             onChanged: (String newValue) {
  //                                                               state.didChange(newValue);
  //                                                               setState(() {
  //                                                                 _category = newValue;
  //                                                               });
  //                                                             },
  //                                                             items: PopulateCategoryList().map((String value) {
  //                                                               return new DropdownMenuItem<String>(
  //                                                                 value: value,
  //                                                                 child: new Text(value),
  //                                                               );
  //                                                             }).toList(),
  //                                                           ),
  //                                                         ),
  //                                                       ),
  //                                                       SizedBox(height: 5.0),
  //                                                       Text(
  //                                                         state.hasError ? state.errorText : '',
  //                                                         style:
  //                                                         TextStyle(color: Colors.redAccent.shade700, fontSize: 12.0),
  //                                                       ),
  //                                                     ],
  //                                                   );
  //                                                 },
  //                                               )
  //                                           ))),
  //                                   Container(
  //                                       child: Center(
  //                                           child: Container(
  //                                               padding: EdgeInsets.fromLTRB(10,5,10,25),
  //                                               width: MediaQuery.of(context).size.width * 0.90,
  //                                               child: TextFormField(
  //                                                 autocorrect: true,
  //                                                 maxLines: 5,
  //                                                 keyboardType: TextInputType.name,
  //                                                 validator: (String value){
  //                                                   if (value==null){
  //                                                     return 'Product detail is required!';
  //                                                   }
  //                                                   if (value==''){
  //                                                     return 'Product detail is required!';
  //                                                   }
  //                                                   if (value.length<4){
  //                                                     return "Has to be at least 4 letters";
  //                                                   }
  //                                                   return null;
  //                                                 },
  //                                                 onSaved: (String value){
  //                                                   setState(() {
  //                                                     _detail=value;
  //                                                   });
  //                                                 },
  //                                                 decoration: InputDecoration(
  //                                                   labelText: 'Product Detail',
  //                                                   hintText: 'Product Detail',
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
  //                                   Container(
  //                                       child: Center(
  //                                           child: Container(
  //                                               padding: EdgeInsets.fromLTRB(10,5,10,25),
  //                                               width: MediaQuery.of(context).size.width * 0.90,
  //                                               child: TextFormField(
  //                                                 autocorrect: true,
  //                                                 maxLines: 1,
  //                                                 keyboardType: TextInputType.number,
  //                                                 validator: (String value){
  //                                                   if (value==null){
  //                                                     return 'Product price is required!';
  //                                                   }
  //                                                   if (value==''){
  //                                                     return 'Product price is required!';
  //                                                   }
  //                                                   if (!RegExp(r'(^\d*\.?\d*)').hasMatch(value)){
  //                                                     return "Incorrect give a valid number";
  //                                                   }
  //                                                   return null;
  //                                                 },
  //                                                 onSaved: (String value){
  //                                                   setState(() {
  //                                                     _price=double.tryParse(value);
  //                                                   });
  //                                                 },
  //                                                 decoration: InputDecoration(
  //                                                   labelText: 'Product Price',
  //                                                   hintText: 'Product Price',
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
  //                           Category category=Category(
  //                               _name, MyImagesList.PharCat1.elementAt(1), _detail, _price
  //                           );
  //                           // Category.categories.add(
  //                           //   category
  //                           // );
  //                           Switcher(category, _category);
  //
  //                           Navigator.of(context).pop();
  //                           Navigator.of(context).pop();
  //                           Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                   builder: (context) => PharmacyEdit(pharmacy: widget.pharmacy)));
  //                         }
  //                       }),
  //                 ],
  //               );
  //             });
  //       });
  // }

  editMessageDescription(BuildContext context, String title, String message, String pharmacyId){
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
                                                      widget.pharmacy.detail=value;
                                                      FirebaseFirestore.instance.collection('pharmacy')
                                                          .doc(pharmacyId)
                                                          .update({'description': widget.pharmacy.detail})
                                                          .then((value) => print("Detail of $pharmacyId Updated"))
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PharmacyEdit(pharmacy: widget.pharmacy)));
                          }
                        }),
                  ],
                );
              });
        });
  }

  editMessagePhone(BuildContext context, String title, String message, String pharmacyId){
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
                                                    if(value.substring(0,2)=="01"){
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
                                                    if(value.substring(0,1)=="1"){
                                                      if(value.length==10){
                                                        return 'You have longer phone number or start with "01"';
                                                      }
                                                      if(value.length!=9){
                                                        return 'Please provide you complete Phone number';
                                                      }
                                                    }

                                                    if (value.length==10){
                                                      if(value.substring(0,2)!="09" && value.substring(0,2)!="01"){
                                                        return 'Please give the right phone number';
                                                      }
                                                    }
                                                    if (value.length==9){
                                                      if(value.substring(0,1)!="9" && value.substring(0,1)!="1"){
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
                            widget.pharmacy.phone=fullPhone;
                            FirebaseFirestore.instance.collection('pharmacy')
                                .doc(pharmacyId)
                                .update({'phone': fullPhone})
                                .then((value) => print("Detail Updated"))
                                .catchError((error) => print("Failed to update user: $error"));
                          });
                        }
                        if (_formKey.currentState.validate()) {

                          _formKey.currentState.save();
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PharmacyEdit(pharmacy: widget.pharmacy)));
                        }

                      },)
                  ],
                );
              });
        });
  }

  editMessageOfficeHours(BuildContext context, String title, String first, String last, String pharmacyId){
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
                            widget.pharmacy.officeHours=("$_firstTime - $_secondTime");
                            FirebaseFirestore.instance.collection('pharmacy')
                                .doc(pharmacyId)
                                .update({'officehours': "$_firstTime - $_secondTime"})
                                .then((value) => print("Detail Updated"))
                                .catchError((error) => print("Failed to update user: $error"));
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PharmacyEdit(pharmacy: widget.pharmacy)));
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
                                                          widget.pharmacy.name=value;
                                                          print(widget.pharmacy.name);
                                                          print(value);

                                                        }
                                                        break;
                                                        case 2: {
                                                          widget.pharmacy.info=value;
                                                          print(widget.pharmacy.info);
                                                          print(value);
                                                        }
                                                        break;
                                                        case 3: {
                                                          widget.pharmacy.location=value;
                                                          print(widget.pharmacy.location);
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
                                    builder: (context) => PharmacyEdit(pharmacy: widget.pharmacy)));
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

