import 'package:alen/providers/HomeCare.dart';
import 'package:alen/providers/ads.dart';
import 'package:alen/providers/auth.dart';
import 'package:alen/providers/cart.dart';
import 'package:alen/providers/company.dart';
import 'package:alen/providers/hospital.dart';
import 'package:alen/providers/healtharticle.dart';
import 'package:alen/providers/diagnostic.dart';
import 'package:alen/providers/importer.dart';
import 'package:alen/providers/laboratory.dart';
import 'package:alen/providers/drug.dart';

import 'package:alen/providers/pharmacy.dart';
import 'package:alen/ui/Forms/PhoneForm.dart';
import 'package:alen/ui/Home/HomePage.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/user_preference.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MySplashScreen());
}

class MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: SplashScreen(
          seconds: 4,
          navigateAfterSeconds: new MyApp(),
          //image: new Image.asset('assets/images/splash.jpg'),
          loaderColor: AppColors().loginButton,
          imageBackground: AssetImage('assets/images/splash.jpg'),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
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
        ChangeNotifierProvider(create: (_) => AdsProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HospitalProvider()),
        ChangeNotifierProvider(create: (_) => PharmacyProvider()),
        ChangeNotifierProvider(create: (_) => ImporterProvider()),
        ChangeNotifierProvider(create: (_) => LaboratoryProvider()),
        ChangeNotifierProvider(create: (_) => DiagnosticProvider()),
        ChangeNotifierProvider(create: (_) => HealthArticleProvider()),
        ChangeNotifierProvider(create: (_) => DrugProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => HomeCareProvider()),
        ChangeNotifierProvider(create: (_) => CompanyProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: 'hind',
            appBarTheme: AppBarTheme(
              color: AppColors().loginBackgroud
            ),
            // scaffoldBackgroundColor: const Color(0xFF2929C7)),
          scaffoldBackgroundColor: AppColors().mainBackground),
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
                    return SignUp();
                  else
                    HomePage();
                  return HomePage();
              }
            }),
      ),
    );
  }
}
