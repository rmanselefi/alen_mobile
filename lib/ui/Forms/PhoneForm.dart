import 'package:alen/providers/language.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/AppColors.dart';
import 'ConfirmationForm.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String phoneNo;
  String smsCode;
  String verId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  var isPressed = false;
  Future<void> verifyPhone(BuildContext ctxt) async {
    setState(() {
      isPressed = true;
    });

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verId = verId;
    };

    final PhoneCodeSent smsCodesent = (String verId, [int forceCodeReSend]) {
      this.verId = verId;
      setState(() {
        isPressed = true;
      });
      Navigator.of(context).push(_createRoute(this.verId, this.smsCode));
      // ctxt.loaderOverlay.hide();
    };
    final PhoneVerificationCompleted verifySuccess = (AuthCredential user) {
      print('VERIFIED');
      setState(() {
        isPressed = false;
      });
    };
    final PhoneVerificationFailed verifyFailed = (error) {
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${error.message}');
      ctxt.loaderOverlay.hide();
      final snackBar = SnackBar(content: Text('${error.message}}'));
      ScaffoldMessenger.of(ctxt).showSnackBar(snackBar);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodesent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifySuccess,
        verificationFailed: verifyFailed);
  }

  static const myCustomColors = AppColors();

  String _countryCode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: AppColors().mainBackground),
        home: LoaderOverlay(
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
            return Container(
                child: Center(child: CircularProgressIndicator()));
          } else {
            var _myLanguage = snapshot.data.getString("lang");
            var languageProvider = Provider.of<LanguageProvider>(context, listen: true);
            languageProvider.langOPT = _myLanguage;
            return Scaffold(
              body: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 40, 0, 20),
                                child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Image.asset('assets/images/alen_no_name.png',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Text(
                                "Sign Up",
                                textAlign: TextAlign.center,
                                textScaleFactor: 2.5,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Form(
                                  key: _formKey,
                                  child: Column(children: [
                                    Container(
                                        child: Center(
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 40.0, bottom: 40.0),
                                                width:
                                                MediaQuery.of(context).size.width *
                                                    0.9,
                                                child: TextFormField(
                                                  autocorrect: true,
                                                  maxLength: 10,
                                                  maxLines: 1,
                                                  keyboardType: TextInputType.phone,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Phone number is required!';
                                                    }
                                                    if (value == '') {
                                                      return 'Please provide you Phone number';
                                                    }
                                                    if (value.length < 9) {
                                                      return 'Please provide you complete Phone number';
                                                    }
                                                    if (!RegExp(r"^[0-9]+")
                                                        .hasMatch(value)) {
                                                      return "Incorrect give a valid phone number";
                                                    }
                                                    if (value.substring(0, 2) == "09") {
                                                      if (value.length != 10) {
                                                        return 'Please complete your phone';
                                                      }
                                                    }

                                                    if (value.substring(0, 1) == "9") {
                                                      if (value.length == 10) {
                                                        return 'You have longer phone number or start with "09"';
                                                      }
                                                      if (value.length != 9) {
                                                        return 'Please provide you complete Phone number';
                                                      }
                                                    }
                                                    if (value.length == 10) {
                                                      if (value.substring(0, 2) !=
                                                          "09") {
                                                        return 'Please give the right phone number';
                                                      }
                                                    }
                                                    if (value.length == 9) {
                                                      if (value.substring(0, 1) !=
                                                          "9") {
                                                        return 'Please give the right phone number';
                                                      }
                                                    }

                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    setState(() {
                                                      _countryCode == null
                                                          ? _countryCode = "+251"
                                                          : _countryCode = _countryCode;
                                                      String temp0Checker =
                                                      value.substring(0, 1);
                                                      temp0Checker == "0"
                                                          ? this.phoneNo =
                                                          _countryCode +
                                                              value.substring(1, 10)
                                                          : temp0Checker == "9"
                                                          ? this.phoneNo =
                                                          _countryCode +
                                                              value.substring(
                                                                  0, 9)
                                                          : this.phoneNo =
                                                          _countryCode + value;

                                                      print("on save text");
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: '900000000',
                                                    labelText: 'Phone Number',
                                                    labelStyle: TextStyle(
                                                        color: myCustomColors
                                                            .loginButton),
                                                    counterStyle: TextStyle(
                                                        color: Colors.white54),
                                                    prefixIcon: CountryCodePicker(
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _countryCode = value.dialCode;
                                                          _countryCode == null
                                                              ? _countryCode = "+251"
                                                              : _countryCode =
                                                              _countryCode;
                                                        });
                                                      },
                                                      backgroundColor: Colors.white,
                                                      initialSelection: 'ET',
                                                      favorite: ['+251', 'ET'],
                                                      showCountryOnly: false,
                                                      showOnlyCountryWhenClosed: false,
                                                      alignLeft: false,
                                                    ),
                                                    hintStyle: TextStyle(
                                                        color: myCustomColors
                                                            .loginButton),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(40.0)),
                                                      borderSide: BorderSide(
                                                          color: myCustomColors
                                                              .loginButton,
                                                          width: 2),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(40.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.green,
                                                          width: 2),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(40.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.green,
                                                          width: 2),
                                                    ),
                                                  ),
                                                )))),
                                    Container(
                                        width: MediaQuery.of(context).size.width * 0.33,
                                        height: 50,
                                        child: ElevatedButton(
                                            child: Text("Sign up",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                )),
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
                                            onPressed: () {
                                              _formKey.currentState.validate();
                                              _formKey.currentState.save();
                                              if (_formKey.currentState.validate()) {
                                                print("object ${this.phoneNo}");
                                                context.loaderOverlay.show();
                                                verifyPhone(context);
                                              }
                                            })),
                                  ])),
                              SizedBox(
                                height: 40,
                              )
                            ],
                          ))
                    ],
                  )),
            );
          }
        }),
        )
    );
  }
}


Route _createRoute(verId, smsCode) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        ConfirmationForm(verId, smsCode),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
