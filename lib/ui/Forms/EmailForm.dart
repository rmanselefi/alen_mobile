import 'package:alen/providers/auth.dart';
import 'package:alen/providers/language.dart';
import 'package:alen/ui/Home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/AppColors.dart';

class EmailFormScreen extends StatefulWidget {
  final user;
  EmailFormScreen(this.user);
  @override
  _EmailFormScreenState createState() => _EmailFormScreenState();
}

class _EmailFormScreenState extends State<EmailFormScreen> {
  String _email;
  String _address;
  String _sex;
  int _age;

  static const myCustomColors = AppColors();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = widget.user;
    var auth = Provider.of<AuthProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: 'Ubuntu',
            appBarTheme: AppBarTheme(
                color: AppColors().loginBackgroud
            ),
            scaffoldBackgroundColor: myCustomColors.mainBackground),
        home: FutureBuilder<dynamic>(
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
                        "Additional Info.",
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
                                      padding:
                                      EdgeInsets.fromLTRB(10, 25, 10, 5),
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      child: TextFormField(
                                        autocorrect: true,
                                        maxLines: 1,
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        validator: (String value) {
                                          if (value == null) {
                                            return 'Email is required!';
                                          }
                                          if (value == '') {
                                            return null;
                                          }
                                          if (!RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value)) {
                                            return "Incorrect Email Address";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            if (value == null) {
                                              _email = "";
                                            }
                                            _email = value;
                                            user['email'] = value;
                                          });
                                        },
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _email = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          hintText: 'Email',
                                          counterStyle:
                                          TextStyle(color: Colors.white54),
                                          labelStyle: TextStyle(
                                              color: myCustomColors
                                                  .loginBackgroud),
                                          prefixIcon: Icon(
                                            Icons.email_outlined,
                                            color:
                                            myCustomColors.loginBackgroud,
                                          ),
                                          hintStyle: TextStyle(
                                              color: myCustomColors
                                                  .loginBackgroud),
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
                                      EdgeInsets.fromLTRB(10, 25, 10, 5),
                                      width: MediaQuery.of(context).size.width *
                                          0.90,
                                      child: TextFormField(
                                        autocorrect: true,
                                        maxLength: 2,
                                        maxLines: 1,
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Age is required!';
                                          }
                                          if (value == '') {
                                            return 'Please provide you age';
                                          }
                                          if (!RegExp(r"^[0-9]+")
                                              .hasMatch(value)) {
                                            return "Age must be a number";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            _age = int.tryParse(value);
                                            user['age'] = value;
                                          });
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _age = int.tryParse(value);
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Age',
                                          hintText: 'Age',
                                          counterStyle:
                                          TextStyle(color: Colors.white54),
                                          labelStyle: TextStyle(
                                              color: myCustomColors
                                                  .loginBackgroud),
                                          prefixIcon: Icon(
                                            Icons.assignment_ind,
                                            color:
                                            myCustomColors.loginBackgroud,
                                          ),
                                          hintStyle: TextStyle(
                                              color: myCustomColors
                                                  .loginBackgroud),
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
                                      child: FormField<String>(
                                        validator: (value) {
                                          if (value == null) {
                                            return "Select your Sex";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _sex = value;
                                        },
                                        builder: (
                                            FormFieldState<String> state,
                                            ) {
                                          return Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new InputDecorator(
                                                decoration:
                                                const InputDecoration(
                                                  counterStyle: TextStyle(
                                                      color: Colors.white54),
                                                  enabledBorder:
                                                  OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            40.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                      const Radius.circular(
                                                          40.0),
                                                    ),
                                                    borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2),
                                                  ),
                                                  focusedBorder:
                                                  OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            40.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2),
                                                  ),
                                                  hintStyle: TextStyle(
                                                      color: const Color(
                                                          0xFF9516B6)),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  contentPadding:
                                                  EdgeInsets.all(0.0),
                                                  labelText: 'Sex',
                                                  hintText: 'Sex',
                                                  labelStyle: TextStyle(
                                                      color: const Color(
                                                          0xFF9516B6)),
                                                  prefixIcon: Icon(
                                                    Icons.wc,
                                                    color:
                                                    const Color(0xFF9516B6),
                                                  ),
                                                ),
                                                child:
                                                DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    hint: new Text(
                                                        "Select your Sex"),
                                                    value: _sex,
                                                    onChanged:
                                                        (String newValue) {
                                                      state.didChange(newValue);
                                                      setState(() {
                                                        _sex = newValue;
                                                        user['sex'] = newValue;
                                                      });
                                                    },
                                                    items: <String>[
                                                      'Male',
                                                      'Female',
                                                    ].map((String value) {
                                                      return new DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: new Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                              Text(
                                                state.hasError
                                                    ? state.errorText
                                                    : '',
                                                style: TextStyle(
                                                    color: Colors
                                                        .redAccent.shade700,
                                                    fontSize: 12.0),
                                              ),
                                            ],
                                          );
                                        },
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
                                        maxLength: 20,
                                        maxLines: 1,
                                        keyboardType: TextInputType.name,
                                        validator: (String value) {
                                          if (value == null) {
                                            return 'Location is required!';
                                          }
                                          if (value == '') {
                                            return null;
                                          }
                                          if (value.length < 4) {
                                            return "Has to be at least 4 letters";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            if (value == null) {
                                              _address = "";
                                            }
                                            _address = value;
                                            user['location'] = value;
                                          });
                                        },
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _address = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          counterStyle:
                                          TextStyle(color: Colors.white54),
                                          labelText: 'Location',
                                          hintText: 'Location',
                                          labelStyle: TextStyle(
                                              color: myCustomColors
                                                  .loginBackgroud),
                                          prefixIcon: Icon(
                                            Icons.location_on_outlined,
                                            color:
                                            myCustomColors.loginBackgroud,
                                          ),
                                          hintStyle: TextStyle(
                                              color: myCustomColors
                                                  .loginBackgroud),
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
                                onPressed: () async {
                                  _formKey.currentState.save();
                                  print("object $user");
                                  if (_formKey.currentState.validate()) {
                                    var res = await auth.signUp(user);
                                    if (res['success']) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomePage(),
                                        ),
                                            (route) => false,
                                      );
                                    }
                                  }
                                },
                              )),
                        ]),
                      ),
                      SizedBox(
                        height: 60,
                      )
                    ],
                  )),
            ],
          )),
    );
    }
    }));
  }
}
