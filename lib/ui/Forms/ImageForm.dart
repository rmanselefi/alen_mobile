import 'dart:io';

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
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageForm extends StatefulWidget {
  final user;
  const ImageForm(
      {Key key, this.user})
      : super(key: key);

  @override
  _ImageFormState createState() =>
      new _ImageFormState();
}

class _ImageFormState
    extends State<ImageForm> {
  static const myCustomColors = AppColors();

  String id;
  void getHospitalId() {
    UserPreferences().getUser().then((value) {
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
    var pharmacyProvider =
        Provider.of<AuthProvider>(parentContext, listen: false);

    var snackBar = SnackBar(
      content: const Text('You have sucessfully registered!'),
      backgroundColor: myCustomColors.loginBackgroud,
    );
    print("hospitalIdhospitalId $id");
    return FutureBuilder<dynamic>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return CircularProgressIndicator();
          }
          print('project snapshot data is: ${snapshot.data}');
          if (snapshot.data == null) {
            return Container(
                child: Center(child: CircularProgressIndicator()));
          } else {
            var _myLanguage = snapshot.data.getString("lang");
            var languageProvider = Provider.of<LanguageProvider>(parentContext, listen: true);
            languageProvider.langOPT = _myLanguage;
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              body: SingleChildScrollView(
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
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Text(
                                  "Please Add Your Image",
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
                                      width: MediaQuery.of(context).size.width*0.7,
                                      child: (_image == null)
                                          ? Image.asset(
                                        'assets/images/profile.png',
                                        fit: BoxFit.fill,
                                      )
                                          : Image.file(
                                        (_image),
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                              )
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: LinearProgressIndicator(
                                value: AuthProvider().progress,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            myCustomColors.loginBackgroud),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(30.0),
                                                side: BorderSide(
                                                    color: myCustomColors
                                                        .loginBackgroud)))),
                                    child: new Center(
                                      child: Container(
                                        width: 90,
                                          height: 40,
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(Icons.attach_file_outlined),
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
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
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
                                            myCustomColors.loginBackgroud),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(30.0),
                                                side: BorderSide(
                                                    color: myCustomColors
                                                        .loginBackgroud)))),
                                    onPressed: () async {
                                      if (_image != null) {
                                        var result =  await Provider.of<AuthProvider>(context,
                                            listen: false)
                                            .uploadFile(_image);
                                        print("resultresultresultresult $result");
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
                                              builder: (BuildContext context) =>
                                                  HomePage(),
                                            ),
                                                (route) => false,
                                          );
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Upload Failed'),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "Couldn't upload image, Please check your internet connection.  Failed",
                                                        maxLines: 5,
                                                      ),
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                      children: <Widget>[
                                                        new ElevatedButton(
                                                            child: new Center(
                                                              child: Container(
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      mainAxisSize:
                                                                      MainAxisSize.max,
                                                                      children: [
                                                                        Text('Ok')
                                                                      ])),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
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

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.bottomRight,
                            child: FlatButton(
                              height: 70,
                              onPressed:(){
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomePage(),
                                  ),
                                      (route) => false,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              } ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Skip',style: TextStyle(color:  myCustomColors.loginBackgroud),),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_right
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            );
          }
        });
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
