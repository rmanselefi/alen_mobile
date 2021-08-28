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
  String _role;

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
       switch(_role)  {
        case "Hospital":
          Status message;
          var hos= await authProvider.signInHospital(email, password);

          if(hos==Status.NonWithThisAccount){
            errorMessageAlert(0, "Hospital");
          }
          else if(hos==Status.InvalidCredential){
            errorMessageAlert(1, "Hospital");
          }
          else if(hos==Status.LoggedIn){
            UserPreferences().setRole(Roles.Hospital);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HospitalDetail(
                      // hospital: Hospital.hospitals.first,
                    )));
          }
          break;
        case "Pharmacy":
          Status message;
          var hos= await authProvider.signInPharmacy(email, password);

          if(hos==Status.NonWithThisAccount){
            errorMessageAlert(0,"Pharmacy");
          }
          else if(hos==Status.InvalidCredential){
            errorMessageAlert(1,"Pharmacy");
          }
          else if(hos==Status.LoggedIn){
            UserPreferences().setRole(Roles.Pharmacist);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PharamacyDetail(
                      pharmacy: Pharmacy.pharmacies.first,)));
          }
          break;
        case "Lab":
          Status message;
          var hos= await authProvider.signInLaboratorist(email, password);

          if(hos==Status.NonWithThisAccount){
            errorMessageAlert(0, "Laboratory");
          }
          else if(hos==Status.InvalidCredential){
            errorMessageAlert(1, "Laboratory");
          }
          else if(hos==Status.LoggedIn){
            UserPreferences().setRole(Roles.Hospital);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LabDetail(
                      lab: Lab.labs.elementAt(1),
                    )));
          }
          break;
        case "Diagnosis":
          Status message;
          var hos= await authProvider.signInDiagnostics(email, password);

          if(hos==Status.NonWithThisAccount){
            errorMessageAlert(0, "Diagnosis");
          }
          else if(hos==Status.InvalidCredential){
            errorMessageAlert(1, "Diagnosis");
          }
          else if(hos==Status.LoggedIn){
            UserPreferences().setRole(Roles.Hospital);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DiagnosisDetail(
                      diagnosis: Diagnosis.diagnosises.elementAt(2),
                    )));
          }
          break;
        case "Importer":
            Status message;
        var hos= await authProvider.signInImporter(email, password);

        if(hos==Status.NonWithThisAccount){
          errorMessageAlert(0,"Importer");
        }
        else if(hos==Status.InvalidCredential){
          errorMessageAlert(1,"Importer");
        }
        else if(hos==Status.LoggedIn){
          UserPreferences().setRole(Roles.Pharmacist);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImporterDetail(
                    importer: Importer.importers.first,)));
        }
        break;
        default:
          break;

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
                                              padding: EdgeInsets.fromLTRB(10,5,10,0),
                                              width: MediaQuery.of(context).size.width * 0.90,
                                              child: FormField<String>(
                                                validator: (value) {
                                                  if (value == null) {
                                                    return "Select your Role";
                                                  }
                                                },
                                                onSaved: (value) {
                                                  _role = value;
                                                },
                                                builder: (
                                                    FormFieldState<String> state,
                                                    ) {
                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      new InputDecorator(

                                                        decoration: const InputDecoration(
                                                          counterStyle: TextStyle(color: Colors.white54),
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
                                                          hintStyle: TextStyle(color: const Color(0xFF9516B6)),
                                                          filled: true,
                                                          fillColor: Colors.white,
                                                          contentPadding: EdgeInsets.all(0.0),
                                                          labelText: 'Role',
                                                          hintText: 'Role',
                                                          labelStyle: TextStyle(color: const Color(0xFF9516B6)),
                                                          prefixIcon: Icon(
                                                            Icons.wc,
                                                            color: const Color(0xFF9516B6),
                                                          ),
                                                        ),
                                                        child: DropdownButtonHideUnderline(
                                                          child: DropdownButton<String>(
                                                            hint: new Text("Select your Role"),
                                                            value: _role,
                                                            onChanged: (String newValue) {
                                                              state.didChange(newValue);
                                                              setState(() {
                                                                _role = newValue;
                                                              });
                                                            },
                                                            items: <String>[
                                                              "Hospital",
                                                              "Pharmacy",
                                                              "Lab",
                                                              "Diagnosis",
                                                              "Importer",
                                                            ].map((String value) {
                                                              return new DropdownMenuItem<String>(
                                                                value: value,
                                                                child: new Text(value),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.0),
                                                      Text(
                                                        state.hasError ? state.errorText : '',
                                                        style:
                                                        TextStyle(color: Colors.redAccent.shade700, fontSize: 12.0),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                          ))),
                                  Container(
                                      child: Center(
                                          child: Container(
                                              padding: EdgeInsets.fromLTRB(10,0,10,13),
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
                                            print(_role);
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
