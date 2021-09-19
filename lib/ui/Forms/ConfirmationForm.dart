import 'package:alen/providers/auth.dart';
import 'package:alen/ui/Forms/NameForm.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:alen/ui/Home/HomePage.dart';
import 'package:provider/provider.dart';

class ConfirmationForm extends StatefulWidget {
  final verId;
  final smscode;
  ConfirmationForm(this.verId, this.smscode);
  @override
  _ConfirmationFormState createState() => _ConfirmationFormState();
}

class _ConfirmationFormState extends State<ConfirmationForm> {
  static const myCustomColors = AppColors();

  String _confirmationCode = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context);
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
                                          maxLength: 6,
                                          maxLines: 1,
                                          keyboardType: TextInputType.phone,
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Confirmation Code is required!';
                                            }
                                            if (value == '') {
                                              return 'Please provide you Confirmation Code';
                                            }
                                            if (value.length < 6) {
                                              return 'Please provide you complete Confirmation Code';
                                            }
                                            if (!RegExp(r"^[0-9]+")
                                                .hasMatch(value)) {
                                              return "Incorrect give a valid Confirmation Code";
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            setState(() {
                                              _confirmationCode = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: '123456',
                                            labelText: 'Confirmation Code',
                                            labelStyle: TextStyle(
                                                color: myCustomColors
                                                    .loginButton),
                                            counterStyle: TextStyle(
                                                color: Colors.white54),
                                            prefixIcon: Icon(
                                              Icons.message,
                                              color:
                                                  myCustomColors.loginButton,
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
                                    onPressed: () async {
                                      _formKey.currentState.save();
                                      if (_formKey.currentState.validate()) {
                                        Map<String, dynamic> successInfo =
                                            await auth.signInWithPhone(
                                                this.widget.verId,
                                                _confirmationCode);
                                        print(successInfo);
                                        if (successInfo['success']) {
                                          var user = successInfo['user'];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NameFormScreen(user)));
                                        }
                                      }
                                    })),
                          ])),
                      SizedBox(
                        height: 40,
                      )
                      // textSection,
                    ],
                  ))
            ],
          )),
        ));
  }
}
