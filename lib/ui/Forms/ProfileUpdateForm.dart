import 'dart:io';

import 'package:alen/models/Users.dart';
import 'package:alen/providers/auth.dart';
import 'package:alen/providers/language.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:alen/ui/Home/HomePage.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileUpdateForm extends StatefulWidget {
  const ProfileUpdateForm({Key key}) : super(key: key);

  @override
  _ProfileUpdateFormState createState() => new _ProfileUpdateFormState();
}

class _ProfileUpdateFormState extends State<ProfileUpdateForm> {
  static const myCustomColors = AppColors();

  String id;

  void getHospitalId() {
    UserPreferences().getId().then((value) {
      setState(() {
        id = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHospitalId();
  }

  @override
  Widget build(BuildContext parentContext) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String _firstName;
    String _lastName;
    String _middleName;
    String _email;
    String _address;
    String _sex;
    int _age;
    Users user;
    var authProvider = Provider.of<AuthProvider>(parentContext, listen: false);
    final _fNameControler = TextEditingController();
    final _mNameControler = TextEditingController();
    final _lNameControler = TextEditingController();
    final _emailControler = TextEditingController();
    final _ageControler = TextEditingController();
    final _locationControler = TextEditingController();

    Future<dynamic> handleExitApp() async{
      Navigator.pop(context, false);
    }

    var snackBar = SnackBar(
      content: const Text('You have sucessfully registered!'),
      backgroundColor: myCustomColors.loginBackgroud,
    );
    print("hospitalIdhospitalId $id");
    return WillPopScope(
      onWillPop:() async => handleExitApp(),
      child: LoaderOverlay(
          overlayOpacity: 0.8,
          child: FutureBuilder<dynamic>(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none &&
                    snapshot.hasData == null) {
                  return CircularProgressIndicator();
                }
                print('project snapshot data is: ${snapshot.data}');
                if (snapshot.data == null) {
                  return Container(child: Center(child: CircularProgressIndicator()));
                } else {
                  var _myLanguage = snapshot.data.getString("lang");
                  var languageProvider =
                  Provider.of<LanguageProvider>(parentContext, listen: true);
                  languageProvider.langOPT = _myLanguage;
                  return Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      // actions: [
                      //   IconButton(
                      //     padding: EdgeInsets.only(right: 15),
                      //     onPressed: () {
                      //       authProvider.updateUser(user);
                      //       Navigator.of(parentContext).pop();
                      //     },
                      //     icon: Icon(Icons.done_all_outlined),
                      //   ),
                      // ],
                    ),
                    body: FutureBuilder<Users>(
                        future: authProvider.fetchUser(id),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState == ConnectionState.none &&
                              userSnapshot.hasData == null) {
                            return CircularProgressIndicator();
                          }
                          print('project snapshot data is: ${userSnapshot.data}');
                          if (userSnapshot.data == null) {
                            return Container(
                                child: Center(child: CircularProgressIndicator()));
                          } else {
                            user = userSnapshot.data;
                            _fNameControler.text = userSnapshot.data.firstName;
                            _mNameControler.text = userSnapshot.data.middleName;
                            _lNameControler.text = userSnapshot.data.lastName;
                            _emailControler.text = userSnapshot.data.email;
                            _ageControler.text = userSnapshot.data.age;
                            _locationControler.text = userSnapshot.data.location;
                            return SingleChildScrollView(
                                child: Stack(
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(0, 40, 0, 20),
                                            ),
                                            Container(
                                              width:
                                              MediaQuery.of(context).size.width * 0.7,
                                              child: Text(
                                                "Update Profile",
                                                textAlign: TextAlign.center,
                                                textScaleFactor: 2.5,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Container(
                                                  padding: EdgeInsets.only(top: 30),
                                                  child: SizedBox(
                                                      height: 250,
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.7,
                                                      child: (_image == null)
                                                          ? userSnapshot.data.image ==
                                                          null ||
                                                          userSnapshot
                                                              .data.image ==
                                                              ""
                                                          ? Image.asset(
                                                        'assets/images/profile.png',
                                                        fit: BoxFit.fill,
                                                      )
                                                          : CircleAvatar(
                                                        backgroundColor:
                                                        Colors.white,
                                                        backgroundImage:
                                                        NetworkImage(
                                                            userSnapshot
                                                                .data
                                                                .image),
                                                      )
                                                          : Image.file(
                                                        (_image),
                                                        fit: BoxFit.fill,
                                                      ))),
                                            )
                                          ],
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0),
                                            child: LinearProgressIndicator(
                                              value: AuthProvider().progress,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              new ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateProperty.all<Color>(
                                                          myCustomColors
                                                              .loginBackgroud),
                                                      shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(
                                                                  30.0),
                                                              side: BorderSide(
                                                                  color: myCustomColors
                                                                      .loginBackgroud)))),
                                                  child: new Center(
                                                    child: Container(
                                                        width: 90,
                                                        height: 40,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            children: [
                                                              Icon(Icons
                                                                  .attach_file_outlined),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text('Add')
                                                            ])),
                                                  ),
                                                  onPressed: () {
                                                    getImage(context);
                                                  }),
                                              new ElevatedButton(
                                                  child: new Center(
                                                    child: Container(
                                                        width: 90,
                                                        height: 40,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            children: [
                                                              Icon(Icons.done),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text('Done')
                                                            ])),
                                                  ),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateProperty.all<Color>(
                                                          myCustomColors
                                                              .loginBackgroud),
                                                      shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(
                                                                  30.0),
                                                              side: BorderSide(
                                                                  color: myCustomColors
                                                                      .loginBackgroud)))),
                                                  onPressed: () async {
                                                    if (_image != null) {
                                                      var result =
                                                      await Provider.of<AuthProvider>(
                                                          context,
                                                          listen: false)
                                                          .uploadFile(_image);
                                                      print(
                                                          "resultresultresultresult $result");
                                                      if (result != null) {
                                                        // Navigator.of(context).pop();
                                                        // setState(() {
                                                        //   Provider.of<ImporterProvider>(context,
                                                        //       listen: false)
                                                        //       .fetchImporters(id);
                                                        // });
                                                        Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (BuildContext context) =>
                                                                HomePage(),
                                                          ),
                                                              (route) => false,
                                                        );
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title:
                                                                Text('Upload Failed'),
                                                                content: Column(
                                                                  mainAxisSize:
                                                                  MainAxisSize.min,
                                                                  children: [
                                                                    Text(
                                                                      "Couldn't upload image, Please check your internet connection.  Failed",
                                                                      maxLines: 5,
                                                                    ),
                                                                  ],
                                                                ),
                                                                actions: <Widget>[
                                                                  Row(
                                                                    mainAxisSize:
                                                                    MainAxisSize.max,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                    children: <Widget>[
                                                                      new ElevatedButton(
                                                                          child:
                                                                          new Center(
                                                                            child: Container(
                                                                                child: Row(
                                                                                    mainAxisAlignment:
                                                                                    MainAxisAlignment.center,
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Text(
                                                                                          'Ok')
                                                                                    ])),
                                                                          ),
                                                                          onPressed: () {
                                                                            Navigator.of(
                                                                                context)
                                                                                .pop();
                                                                          }),
                                                                    ],
                                                                  )
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    } else {
                                                      print('No image selected.');
                                                    }
                                                  })
                                            ],
                                          ),
                                        ),
                                        // Form(
                                        //   key: _formKey,
                                        //   child: Column(children: [
                                        //     Container(
                                        //         child: Center(
                                        //             child: Container(
                                        //                 padding: EdgeInsets.fromLTRB(
                                        //                     10, 25, 10, 5),
                                        //                 width: MediaQuery.of(context)
                                        //                         .size
                                        //                         .width *
                                        //                     0.90,
                                        //                 child: TextFormField(
                                        //                   controller: _fNameControler,
                                        //                   autocorrect: true,
                                        //                   maxLength: 15,
                                        //                   maxLines: 1,
                                        //                   keyboardType:
                                        //                       TextInputType.name,
                                        //                   validator: (String value) {
                                        //                     if (value == null) {
                                        //                       return 'First name is required!';
                                        //                     }
                                        //                     if (value == '') {
                                        //                       return 'First name is required!';
                                        //                     }
                                        //                     if (value.length < 3) {
                                        //                       return "Has to be at least 3 letters";
                                        //                     }
                                        //                     if (RegExp(
                                        //                             r'[!@#<>?":;$}{_`~;[\]\\|=+)(*&^%0-9-]')
                                        //                         .hasMatch(value)) {
                                        //                       return "Illegal characters!";
                                        //                     }
                                        //                     return null;
                                        //                   },
                                        //                   onSaved: (String value) {
                                        //                     setState(() {
                                        //                       _firstName = value;
                                        //                       user.firstName = value;
                                        //                     });
                                        //                   },
                                        //                   onChanged: (String newValue) {
                                        //                     setState(() {
                                        //                       _firstName = newValue;
                                        //                     });
                                        //                   },
                                        //                   decoration: InputDecoration(
                                        //                     labelText: 'First Name',
                                        //                     hintText: 'First Name',
                                        //                     labelStyle: TextStyle(
                                        //                         color: myCustomColors
                                        //                             .loginBackgroud),
                                        //                     prefixIcon: Icon(
                                        //                       Icons.perm_identity,
                                        //                       color: myCustomColors
                                        //                           .loginBackgroud,
                                        //                     ),
                                        //                     counterStyle: TextStyle(
                                        //                         color: Colors.white54),
                                        //                     hintStyle: TextStyle(
                                        //                         color: myCustomColors
                                        //                             .loginBackgroud),
                                        //                     filled: true,
                                        //                     fillColor: Colors.white,
                                        //                     enabledBorder:
                                        //                         OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.all(
                                        //                               Radius.circular(
                                        //                                   40.0)),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                     border: OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           const BorderRadius.all(
                                        //                         const Radius.circular(
                                        //                             40.0),
                                        //                       ),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.all(
                                        //                               Radius.circular(
                                        //                                   40.0)),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                   ),
                                        //                 )))),
                                        //     Container(
                                        //         child: Center(
                                        //             child: Container(
                                        //                 padding: EdgeInsets.fromLTRB(
                                        //                     10, 5, 10, 5),
                                        //                 width: MediaQuery.of(context)
                                        //                         .size
                                        //                         .width *
                                        //                     0.90,
                                        //                 child: TextFormField(
                                        //                   controller: _mNameControler,
                                        //                   autocorrect: true,
                                        //                   maxLength: 15,
                                        //                   maxLines: 1,
                                        //                   keyboardType:
                                        //                       TextInputType.name,
                                        //                   onSaved: (String value) {
                                        //                     setState(() {
                                        //                       _middleName = value;
                                        //                       user.middleName = value;
                                        //                     });
                                        //                   },
                                        //                   onChanged: (String newValue) {
                                        //                     setState(() {
                                        //                       _middleName = newValue;
                                        //                     });
                                        //                   },
                                        //                   decoration: InputDecoration(
                                        //                     labelText: 'Middle Name',
                                        //                     hintText: 'Middle Name',
                                        //                     labelStyle: TextStyle(
                                        //                         color: myCustomColors
                                        //                             .loginBackgroud),
                                        //                     prefixIcon: Icon(
                                        //                       Icons.perm_identity,
                                        //                       color: myCustomColors
                                        //                           .loginBackgroud,
                                        //                     ),
                                        //                     counterStyle: TextStyle(
                                        //                         color: Colors.white54),
                                        //                     hintStyle: TextStyle(
                                        //                         color: myCustomColors
                                        //                             .loginBackgroud),
                                        //                     filled: true,
                                        //                     fillColor: Colors.white,
                                        //                     enabledBorder:
                                        //                         OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.all(
                                        //                               Radius.circular(
                                        //                                   40.0)),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                     border: OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           const BorderRadius.all(
                                        //                         const Radius.circular(
                                        //                             40.0),
                                        //                       ),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.all(
                                        //                               Radius.circular(
                                        //                                   40.0)),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                   ),
                                        //                 )))),
                                        //     Container(
                                        //         child: Center(
                                        //             child: Container(
                                        //                 padding: EdgeInsets.fromLTRB(
                                        //                     10, 5, 10, 5),
                                        //                 width: MediaQuery.of(context)
                                        //                         .size
                                        //                         .width *
                                        //                     0.90,
                                        //                 child: TextFormField(
                                        //                   controller: _lNameControler,
                                        //                   autocorrect: true,
                                        //                   maxLength: 15,
                                        //                   maxLines: 1,
                                        //                   keyboardType:
                                        //                       TextInputType.name,
                                        //                   validator: (String value) {
                                        //                     if (value == null) {
                                        //                       return 'Last name is required!';
                                        //                     }
                                        //                     if (value == '') {
                                        //                       return 'Last name is required!';
                                        //                     }
                                        //                     if (value.length < 3) {
                                        //                       return "Has to be at least 3 letters";
                                        //                     }
                                        //                     if (RegExp(
                                        //                             r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                        //                         .hasMatch(value)) {
                                        //                       return "Illegal characters!";
                                        //                     }
                                        //                     return null;
                                        //                   },
                                        //                   onSaved: (String value) {
                                        //                     setState(() {
                                        //                       _lastName = value;
                                        //                       user.lastName = value;
                                        //                     });
                                        //                   },
                                        //                   onChanged: (String newValue) {
                                        //                     setState(() {
                                        //                       _lastName = newValue;
                                        //                     });
                                        //                   },
                                        //                   decoration: InputDecoration(
                                        //                     labelText: 'Last Name',
                                        //                     hintText: 'Last Name',
                                        //                     labelStyle: TextStyle(
                                        //                         color: myCustomColors
                                        //                             .loginBackgroud),
                                        //                     prefixIcon: Icon(
                                        //                       Icons.perm_identity,
                                        //                       color: myCustomColors
                                        //                           .loginBackgroud,
                                        //                     ),
                                        //                     counterStyle: TextStyle(
                                        //                         color: Colors.white54),
                                        //                     hintStyle: TextStyle(
                                        //                         color: myCustomColors
                                        //                             .loginBackgroud),
                                        //                     filled: true,
                                        //                     fillColor: Colors.white,
                                        //                     enabledBorder:
                                        //                         OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.all(
                                        //                               Radius.circular(
                                        //                                   40.0)),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                     border: OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           const BorderRadius.all(
                                        //                         const Radius.circular(
                                        //                             40.0),
                                        //                       ),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.all(
                                        //                               Radius.circular(
                                        //                                   40.0)),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                   ),
                                        //                 )))),
                                        //     Container(
                                        //         child: Center(
                                        //             child: Container(
                                        //                 padding: EdgeInsets.fromLTRB(
                                        //                     10, 5, 10, 5),
                                        //                 width: MediaQuery.of(context)
                                        //                         .size
                                        //                         .width *
                                        //                     0.90,
                                        //                 child: TextFormField(
                                        //                   controller: _emailControler,
                                        //                   autocorrect: true,
                                        //                   maxLines: 1,
                                        //                   keyboardType:
                                        //                       TextInputType.emailAddress,
                                        //                   validator: (String value) {
                                        //                     if (value == null) {
                                        //                       return 'Email is required!';
                                        //                     }
                                        //                     if (value == '') {
                                        //                       return null;
                                        //                     }
                                        //                     if (!RegExp(
                                        //                             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        //                         .hasMatch(value)) {
                                        //                       return "Incorrect Email Address";
                                        //                     }
                                        //                     return null;
                                        //                   },
                                        //                   onSaved: (value) {
                                        //                     setState(() {
                                        //                       if (value == null) {
                                        //                         _email = "";
                                        //                       }
                                        //                       _email = value;
                                        //                       user.email = value;
                                        //                     });
                                        //                   },
                                        //                   onChanged: (String newValue) {
                                        //                     setState(() {
                                        //                       _email = newValue;
                                        //                     });
                                        //                   },
                                        //                   decoration: InputDecoration(
                                        //                     labelText: 'Email',
                                        //                     hintText: 'Email',
                                        //                     counterStyle: TextStyle(
                                        //                         color: Colors.white54),
                                        //                     labelStyle: TextStyle(
                                        //                         color: myCustomColors
                                        //                             .loginBackgroud),
                                        //                     prefixIcon: Icon(
                                        //                       Icons.email_outlined,
                                        //                       color: myCustomColors
                                        //                           .loginBackgroud,
                                        //                     ),
                                        //                     hintStyle: TextStyle(
                                        //                         color: myCustomColors
                                        //                             .loginBackgroud),
                                        //                     filled: true,
                                        //                     fillColor: Colors.white,
                                        //                     enabledBorder:
                                        //                         OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.all(
                                        //                               Radius.circular(
                                        //                                   40.0)),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                     border: OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           const BorderRadius.all(
                                        //                         const Radius.circular(
                                        //                             40.0),
                                        //                       ),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.all(
                                        //                               Radius.circular(
                                        //                                   40.0)),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                   ),
                                        //                 )))),
                                        //     Container(
                                        //         child: Center(
                                        //             child: Container(
                                        //                 padding: EdgeInsets.fromLTRB(
                                        //                     10, 25, 10, 5),
                                        //                 width: MediaQuery.of(context)
                                        //                         .size
                                        //                         .width *
                                        //                     0.90,
                                        //                 child: TextFormField(
                                        //                   controller: _ageControler,
                                        //                   autocorrect: true,
                                        //                   maxLength: 2,
                                        //                   maxLines: 1,
                                        //                   keyboardType:
                                        //                       TextInputType.phone,
                                        //                   validator: (value) {
                                        //                     if (value == null) {
                                        //                       return 'Age is required!';
                                        //                     }
                                        //                     if (value == '') {
                                        //                       return 'Please provide you age';
                                        //                     }
                                        //                     if (!RegExp(r"^[0-9]+")
                                        //                         .hasMatch(value)) {
                                        //                       return "Age must be a number";
                                        //                     }
                                        //                     return null;
                                        //                   },
                                        //                   onSaved: (value) {
                                        //                     setState(() {
                                        //                       _age = int.tryParse(value);
                                        //                       user.age = value;
                                        //                     });
                                        //                   },
                                        //                   onChanged: (value) {
                                        //                     setState(() {
                                        //                       _age = int.tryParse(value);
                                        //                     });
                                        //                   },
                                        //                   decoration: InputDecoration(
                                        //                     labelText: 'Age',
                                        //                     hintText: 'Age',
                                        //                     counterStyle: TextStyle(
                                        //                         color: Colors.white54),
                                        //                     labelStyle: TextStyle(
                                        //                         color: myCustomColors
                                        //                             .loginBackgroud),
                                        //                     prefixIcon: Icon(
                                        //                       Icons.assignment_ind,
                                        //                       color: myCustomColors
                                        //                           .loginBackgroud,
                                        //                     ),
                                        //                     hintStyle: TextStyle(
                                        //                         color: myCustomColors
                                        //                             .loginBackgroud),
                                        //                     filled: true,
                                        //                     fillColor: Colors.white,
                                        //                     enabledBorder:
                                        //                         OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.all(
                                        //                               Radius.circular(
                                        //                                   40.0)),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                     border: OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           const BorderRadius.all(
                                        //                         const Radius.circular(
                                        //                             40.0),
                                        //                       ),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.all(
                                        //                               Radius.circular(
                                        //                                   40.0)),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                   ),
                                        //                 )))),
                                        //     Container(
                                        //         child: Center(
                                        //             child: Container(
                                        //                 padding: EdgeInsets.fromLTRB(
                                        //                     10, 5, 10, 25),
                                        //                 width: MediaQuery.of(context)
                                        //                         .size
                                        //                         .width *
                                        //                     0.90,
                                        //                 child: FormField<String>(
                                        //                   validator: (value) {
                                        //                     if (value == null) {
                                        //                       return "Select your Sex";
                                        //                     }
                                        //                     return null;
                                        //                   },
                                        //                   onSaved: (value) {
                                        //                     _sex = value;
                                        //                   },
                                        //                   builder: (
                                        //                     FormFieldState<String> state,
                                        //                   ) {
                                        //                     return Column(
                                        //                       crossAxisAlignment:
                                        //                           CrossAxisAlignment
                                        //                               .start,
                                        //                       children: <Widget>[
                                        //                         new InputDecorator(
                                        //                           decoration:
                                        //                               const InputDecoration(
                                        //                             counterStyle:
                                        //                                 TextStyle(
                                        //                                     color: Colors
                                        //                                         .white54),
                                        //                             enabledBorder:
                                        //                                 OutlineInputBorder(
                                        //                               borderRadius:
                                        //                                   BorderRadius.all(
                                        //                                       Radius.circular(
                                        //                                           40.0)),
                                        //                               borderSide:
                                        //                                   BorderSide(
                                        //                                       color: Colors
                                        //                                           .green,
                                        //                                       width: 2),
                                        //                             ),
                                        //                             border:
                                        //                                 OutlineInputBorder(
                                        //                               borderRadius:
                                        //                                   const BorderRadius
                                        //                                       .all(
                                        //                                 const Radius
                                        //                                         .circular(
                                        //                                     40.0),
                                        //                               ),
                                        //                               borderSide:
                                        //                                   BorderSide(
                                        //                                       color: Colors
                                        //                                           .green,
                                        //                                       width: 2),
                                        //                             ),
                                        //                             focusedBorder:
                                        //                                 OutlineInputBorder(
                                        //                               borderRadius:
                                        //                                   BorderRadius.all(
                                        //                                       Radius.circular(
                                        //                                           40.0)),
                                        //                               borderSide:
                                        //                                   BorderSide(
                                        //                                       color: Colors
                                        //                                           .green,
                                        //                                       width: 2),
                                        //                             ),
                                        //                             hintStyle: TextStyle(
                                        //                                 color: const Color(
                                        //                                     0xFF1DB9A3)),
                                        //                             filled: true,
                                        //                             fillColor:
                                        //                                 Colors.white,
                                        //                             contentPadding:
                                        //                                 EdgeInsets.all(
                                        //                                     0.0),
                                        //                             labelText: 'Sex',
                                        //                             hintText: 'Sex',
                                        //                             labelStyle: TextStyle(
                                        //                                 color: const Color(
                                        //                                     0xFF1DB9A3)),
                                        //                             prefixIcon: Icon(
                                        //                                 Icons.wc,
                                        //                                 color: const Color(
                                        //                                     0xFF1DB9A3)),
                                        //                           ),
                                        //                           child:
                                        //                               DropdownButtonHideUnderline(
                                        //                             child: DropdownButton<
                                        //                                 String>(
                                        //                               hint: new Text(
                                        //                                   "Select your Sex"),
                                        //                               value: _sex,
                                        //                               onChanged: (String
                                        //                                   newValue) {
                                        //                                 state.didChange(
                                        //                                     newValue);
                                        //                                 setState(() {
                                        //                                   _sex = newValue;
                                        //                                   user.sex =
                                        //                                       newValue;
                                        //                                 });
                                        //                               },
                                        //                               items: <String>[
                                        //                                 'Male',
                                        //                                 'Female',
                                        //                               ].map(
                                        //                                   (String value) {
                                        //                                 return new DropdownMenuItem<
                                        //                                     String>(
                                        //                                   value: value,
                                        //                                   child: new Text(
                                        //                                       value),
                                        //                                 );
                                        //                               }).toList(),
                                        //                             ),
                                        //                           ),
                                        //                         ),
                                        //                         SizedBox(height: 5.0),
                                        //                         Text(
                                        //                           state.hasError
                                        //                               ? state.errorText
                                        //                               : '',
                                        //                           style: TextStyle(
                                        //                               color: Colors
                                        //                                   .redAccent
                                        //                                   .shade700,
                                        //                               fontSize: 12.0),
                                        //                         ),
                                        //                       ],
                                        //                     );
                                        //                   },
                                        //                 )))),
                                        //     Container(
                                        //         child: Center(
                                        //             child: Container(
                                        //                 padding: EdgeInsets.fromLTRB(
                                        //                     10, 5, 10, 25),
                                        //                 width: MediaQuery.of(context)
                                        //                         .size
                                        //                         .width *
                                        //                     0.90,
                                        //                 child: TextFormField(
                                        //                   controller: _locationControler,
                                        //                   autocorrect: true,
                                        //                   maxLines: 1,
                                        //                   keyboardType:
                                        //                       TextInputType.name,
                                        //                   validator: (String value) {
                                        //                     if (value == null) {
                                        //                       return 'Location is required!';
                                        //                     }
                                        //                     if (value == '') {
                                        //                       return null;
                                        //                     }
                                        //                     if (value.length < 4) {
                                        //                       return "Has to be at least 4 letters";
                                        //                     }
                                        //                     return null;
                                        //                   },
                                        //                   onSaved: (value) {
                                        //                     setState(() {
                                        //                       if (value == null) {
                                        //                         _address = "";
                                        //                       }
                                        //                       _address = value;
                                        //                       user.location = value;
                                        //                     });
                                        //                   },
                                        //                   onChanged: (String newValue) {
                                        //                     setState(() {
                                        //                       _address = newValue;
                                        //                     });
                                        //                   },
                                        //                   decoration: InputDecoration(
                                        //                     counterStyle: TextStyle(
                                        //                         color: Colors.white54),
                                        //                     labelText: 'Location',
                                        //                     hintText: 'Location',
                                        //                     labelStyle: TextStyle(
                                        //                         color: myCustomColors
                                        //                             .loginBackgroud),
                                        //                     prefixIcon: Icon(
                                        //                       Icons.location_on_outlined,
                                        //                       color: myCustomColors
                                        //                           .loginBackgroud,
                                        //                     ),
                                        //                     hintStyle: TextStyle(
                                        //                         color: myCustomColors
                                        //                             .loginBackgroud),
                                        //                     filled: true,
                                        //                     fillColor: Colors.white,
                                        //                     enabledBorder:
                                        //                         OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.all(
                                        //                               Radius.circular(
                                        //                                   40.0)),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                     border: OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           const BorderRadius.all(
                                        //                         const Radius.circular(
                                        //                             40.0),
                                        //                       ),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                     focusedBorder:
                                        //                         OutlineInputBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.all(
                                        //                               Radius.circular(
                                        //                                   40.0)),
                                        //                       borderSide: BorderSide(
                                        //                           color: Colors.green,
                                        //                           width: 2),
                                        //                     ),
                                        //                   ),
                                        //                 )))),
                                        //     Container(
                                        //         width: 130,
                                        //         height: 50,
                                        //         child: ElevatedButton(
                                        //           child: Text("Submit",
                                        //               style: TextStyle(
                                        //                 fontSize: 20,
                                        //               )),
                                        //           style: ButtonStyle(
                                        //               backgroundColor:
                                        //                   MaterialStateProperty.all<Color>(
                                        //                       myCustomColors
                                        //                           .loginBackgroud),
                                        //               shape: MaterialStateProperty.all<
                                        //                       RoundedRectangleBorder>(
                                        //                   RoundedRectangleBorder(
                                        //                       borderRadius: BorderRadius.circular(
                                        //                           30.0),
                                        //                       side: BorderSide(
                                        //                           color: myCustomColors
                                        //                               .loginBackgroud)))),
                                        //           onPressed: () {
                                        //             _formKey.currentState.save();
                                        //             if (_formKey.currentState
                                        //                 .validate()) {
                                        //               // context.loaderOverlay.show();
                                        //               // Navigator.push(
                                        //               //     context,
                                        //               //     MaterialPageRoute(
                                        //               //         builder: (context) =>
                                        //               //             EmailFormScreen(user)));
                                        //               authProvider.updateUser(user);
                                        //               Navigator.of(parentContext).pop();
                                        //             }
                                        //           },
                                        //         )),
                                        //     SizedBox(
                                        //       height: 50,
                                        //     )
                                        //   ]),
                                        // ),
                                      ],
                                    )
                                  ],
                                ));
                          }
                        }),
                  );
                }
              })
      ),
    );
  }

  File _image;
  final picker = ImagePicker();

  Future getImage(BuildContext ctxt) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  bool isUploaded = false;
}
