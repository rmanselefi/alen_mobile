import 'package:alen/models/hospital.dart';
import 'package:alen/providers/auth.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/user_preference.dart';
import 'package:alen/ui/Details/DiagnosisDetail.dart';
import 'package:alen/ui/Details/HospitalDetail.dart';
import 'package:alen/ui/Details/ImporterDetail.dart';
import 'package:alen/ui/Details/LabDetail.dart';
import 'package:alen/ui/Details/PharmacyDetail.dart';
import 'package:alen/ui/Pages/Diagnosis.dart';
import 'package:alen/ui/Pages/Hospital.dart';
import 'package:alen/ui/Pages/Importer.dart';
import 'package:alen/ui/Pages/Lab.dart';
import 'package:alen/ui/Pages/Pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import '../AppColors.dart';

enum Roles{
  Hospital,
  Pharmacist,
  Importer,
  Diagnosis,
  Lab
}
class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {


  String _email;
  String _password;

  static const myCustomColors = AppColors();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  errorMessageAlert(int temp,String text){
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(  // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: (temp==0)? Text('No $text with this Account'):Text("Invalid credentials"),
                  content: SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            (temp==0)?
                            Text(
                                "There is no $text with this account, Please try by either changing your credentials or your role."
                            )
                                :
                            Text(
                                'Invalid credentials please give the correct email and password.'
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text(
                            "OK"
                        )
                    )
                  ],
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    void Switcher(String email, String password) async{
       
          Status message;
          var hos= await authProvider.signIn(email, password);

          if(hos==Status.NonWithThisAccount){
            errorMessageAlert(0, "Hospital");
          }
          else if(hos==Status.InvalidCredential){
            errorMessageAlert(1, "Hospital");
          }
          else if(hos==Status.LoggedIn){
            String role= await UserPreferences().getRole();
            switch(role){
              case "0":Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HospitalDetail(
                        // hospital: Hospital.hospitals.first,
                      )));
              break;
              case "1": Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PharamacyDetail(
                        pharmacy: Pharmacy.pharmacies.first,)));
              break;
              case "2":Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImporterDetail(
                        importer: Importer.importers.first,)));
              break;
              case "3":Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DiagnosisDetail(
                        diagnosis: Diagnosis.diagnosises.elementAt(2),
                      )));
              break;
              case "4":Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LabDetail(
                        lab: Lab.labs.elementAt(1),
                      )));
              break;
            }
            
          }
    }


    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: myCustomColors.loginBackgroud),
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
                            "Login",
                            textAlign: TextAlign.center,
                            textScaleFactor: 2.5,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                                children:[
                                  Container(
                                      child: Center(
                                          child: Container(
                                              padding: EdgeInsets.fromLTRB(10,20,10,13),
                                              width: MediaQuery.of(context).size.width * 0.90,
                                              child: TextFormField(
                                                autocorrect: true,
                                                maxLines: 1,
                                                keyboardType: TextInputType.emailAddress,
                                                validator: (String value){
                                                  if (value==null){
                                                    return 'Email is required!';
                                                  }
                                                  if (value==''){
                                                    return 'Email is required!';
                                                  }
                                                  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                                                    return "Incorrect Email Address";
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value){
                                                  setState(() {
                                                    _email= value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'Email',
                                                  hintText: 'Email',
                                                  counterStyle: TextStyle(color: Colors.white54),
                                                  labelStyle: TextStyle(color: myCustomColors.loginBackgroud),
                                                  prefixIcon: Icon(
                                                    Icons.email_outlined,
                                                    color: myCustomColors.loginBackgroud,
                                                  ),

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
                                  Container(
                                      child: Center(
                                          child: Container(
                                              padding: EdgeInsets.fromLTRB(10,5,10,25),
                                              width: MediaQuery.of(context).size.width * 0.90,
                                              child: TextFormField(
                                                obscureText: true,
                                                maxLength: 15,
                                                maxLines: 1,
                                                keyboardType: TextInputType.visiblePassword,
                                                validator: (String value){
                                                  if (value==null){
                                                    return 'Password is required!';
                                                  }
                                                  if (value==''){
                                                    return 'Password is required!';
                                                  }
                                                  if (value.length<6){
                                                    return "Has to be at least 6 characters!";
                                                  }
                                                  return null;
                                                },

                                                onSaved: (value){
                                                  setState(() {
                                                    _password= value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  counterStyle: TextStyle(color: Colors.white54),
                                                  labelText: 'Password',
                                                  hintText: 'Password',
                                                  labelStyle: TextStyle(color:myCustomColors.loginBackgroud),
                                                  prefixIcon: Icon(
                                                    Icons.password_outlined,
                                                    color: myCustomColors.loginBackgroud,
                                                  ),
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
                                          if (_formKey.currentState.validate()) {
                                            _formKey.currentState.save();
                                            print(_email);
                                            print(_password);
                                            Switcher(_email, _password);
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) => ButtonsPage()));
                                          }

                                        },
                                      )),]
                            ),
                          ),
                          SizedBox(height: 60,)
                        ],

                      )),

                ],
              )),
        ));
  }
}
