import 'package:alen/providers/ads.dart';
import 'package:alen/providers/auth.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/healtharticle.dart';
import 'package:alen/providers/diagnostic.dart';
import 'package:alen/providers/importer.dart';
import 'package:alen/providers/laboratory.dart';
import 'package:alen/providers/drug.dart';

import 'package:alen/providers/pharmacy.dart';
import 'package:alen/ui/Forms/LoginForm.dart';
import 'package:alen/ui/Home/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/user_preference.dart';
import 'ui/Details/HospitalDetail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  HospitalProvider hospital = HospitalProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hospital.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HospitalProvider()),
        ChangeNotifierProvider(create: (_) => PharmacyProvider()),
        ChangeNotifierProvider(create: (_) => LaboratoryProvider()),
        ChangeNotifierProvider(create: (_) => DiagnosticProvider()),
        ChangeNotifierProvider(create: (_) => ImporterProvider()),
        ChangeNotifierProvider(create: (_) => HealthArticleProvider()),
        ChangeNotifierProvider(create: (_) => DrugProvider()),
        ChangeNotifierProvider(create: (_) => AdsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: const Color(0xFF2929C7)),
        home: FutureBuilder(
            future: UserPreferences().getUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else if (snapshot.data == null)
                    return LoginForm();
                  else
                    return FutureBuilder(
                      future: UserPreferences().getRole(),
                        builder: ( context, snapshot){
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else if (snapshot.data == null)
                            return LoginForm();
                          else{
                            switch(snapshot.data){
                              case 0:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HospitalDetail(
                                          // hospital: Hospital.hospitals.first,
                                        )));
                                return Text('Hospital');
                                break;
                              // case 1:
                              //   return HospitalDetail(
                              //
                              //   );
                              //   break;
                              // case 2:
                              //   return HospitalDetail(
                              //
                              //   );
                              //   break;
                              // case 3:
                              //   return HospitalDetail(
                              //
                              //   );
                              //   break;
                              // case 4:
                              //   return LoginForm(
                              //
                              //   );
                              //   break;
                              default:
                                return LoginForm(
                                  // hospital: Hospital.hospitals.first,
                                );
                                break;

                            }
                          }
                        }
                    );
                  return LoginForm();
              }
            }),
      ),
    );
  }
}
