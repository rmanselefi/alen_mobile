import 'package:alen/ui/Forms/EmailForm.dart';
import 'package:alen/ui/Home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/AppColors.dart';

class NameFormScreen extends StatefulWidget {
  final user;
  NameFormScreen(this.user);

  @override
  _NameFormScreenState createState() => _NameFormScreenState();
}

class _NameFormScreenState extends State<NameFormScreen> {
  String _firstName;
  String _lastName;
  String _middleName;

  static const myCustomColors = AppColors();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = widget.user;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: myCustomColors.loginButton),
        home: Scaffold(
          body: SingleChildScrollView(
              child: Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        "Your Name",
                        textAlign: TextAlign.center,
                        textScaleFactor: 2.5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(children: [
                          Container(
                              child: Center(
                                  child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 25, 10, 5),
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      child: TextFormField(
                                        autocorrect: true,
                                        maxLength: 15,
                                        maxLines: 1,
                                        keyboardType: TextInputType.name,
                                        validator: (String value) {
                                          if (value == null) {
                                            return 'First name is required!';
                                          }
                                          if (value == '') {
                                            return 'First name is required!';
                                          }
                                          if (value.length < 3) {
                                            return "Has to be at least 3 letters";
                                          }
                                          if (RegExp(
                                                  r'[!@#<>?":;$}{_`~;[\]\\|=+)(*&^%0-9-]')
                                              .hasMatch(value)) {
                                            return "Illegal characters!";
                                          }
                                          return null;
                                        },
                                        onSaved: (String value) {
                                          setState(() {
                                            _firstName = value;
                                            user['firstName']=value;
                                          });
                                        },
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _firstName = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'First Name',
                                          hintText: 'First Name',
                                          labelStyle: TextStyle(
                                              color: myCustomColors
                                                  .loginButton),
                                          prefixIcon: Icon(
                                            Icons.perm_identity,
                                            color:
                                                myCustomColors.loginButton,
                                          ),
                                          counterStyle:
                                              TextStyle(color: Colors.white54),
                                          hintStyle:
                                              TextStyle(color: myCustomColors.loginButton),
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0)),
                                            borderSide: BorderSide(
                                                color: Colors.green, width: 2),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
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
                          Container(
                              child: Center(
                                  child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      child: TextFormField(
                                        autocorrect: true,
                                        maxLength: 15,
                                        maxLines: 1,
                                        keyboardType: TextInputType.name,
                                        onSaved: (String value) {
                                          setState(() {
                                            _middleName = value;
                                            user['middleName']=value;
                                          });
                                        },
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _middleName = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Middle Name',
                                          hintText: 'Middle Name',
                                          labelStyle: TextStyle(
                                              color: myCustomColors
                                                  .loginButton),
                                          prefixIcon: Icon(
                                            Icons.perm_identity,
                                            color:
                                                myCustomColors.loginButton,
                                          ),
                                          counterStyle:
                                              TextStyle(color: Colors.white54),
                                          hintStyle: TextStyle(
                                              color: myCustomColors
                                                  .loginButton),
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0)),
                                            borderSide: BorderSide(
                                                color: Colors.green, width: 2),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
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
                          Container(
                              child: Center(
                                  child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 25),
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      child: TextFormField(
                                        autocorrect: true,
                                        maxLength: 15,
                                        maxLines: 1,
                                        keyboardType: TextInputType.name,
                                        validator: (String value) {
                                          if (value == null) {
                                            return 'Last name is required!';
                                          }
                                          if (value == '') {
                                            return 'Last name is required!';
                                          }
                                          if (value.length < 3) {
                                            return "Has to be at least 3 letters";
                                          }
                                          if (RegExp(
                                                  r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                              .hasMatch(value)) {
                                            return "Illegal characters!";
                                          }
                                          return null;
                                        },
                                        onSaved: (String value) {
                                          setState(() {
                                            _lastName = value;
                                            user['lastName']=value;
                                          });
                                        },
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _lastName = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Last Name',
                                          hintText: 'Last Name',
                                          labelStyle: TextStyle(
                                              color: myCustomColors
                                                  .loginButton),
                                          prefixIcon: Icon(
                                            Icons.perm_identity,
                                            color:
                                                myCustomColors.loginButton,
                                          ),
                                          counterStyle:
                                              TextStyle(color: Colors.white54),
                                          hintStyle: TextStyle(
                                              color: myCustomColors
                                                  .loginButton),
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.0)),
                                            borderSide: BorderSide(
                                                color: Colors.green, width: 2),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
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
                                  _formKey.currentState.save();
                                  if (_formKey.currentState.validate()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EmailFormScreen(user)));
                                  }
                                },
                              )),
                        ]),
                      ),
                      // textSection,
                    ],
                  ))
            ],
          )),
        ));
  }
}
