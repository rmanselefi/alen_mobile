import 'package:alen/providers/language.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alen/utils/AppColors.dart';

class PersonalDataController extends StatelessWidget {
  const PersonalDataController({Key key}) : super(key: key);

  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
    Future<dynamic> handleExitApp() async{
      Navigator.pop(context, false);
    }
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
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  var _myLanguage = snapshot.data.getString("lang");
                  var languageProvider = Provider.of<LanguageProvider>(context, listen: true);
                  languageProvider.langOPT = _myLanguage;
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Alen"),
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                    ),
                    body: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 30,),
                                  SizedBox(
                                    height: 200,
                                    child: Image.asset(
                                        'assets/images/alen_no_name.png',
                                        fit: BoxFit.fill
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(30),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                          child:Text(
                                            "1. PERSONAL DATA CONTROLLER",
                                            textAlign: TextAlign.center,
                                            textScaleFactor: 1.6,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          )
                                      )
                                  ),

                                  Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Text(
                                          "Hyssop Pharma Trading P.L.C. a company registered"
                                              " in Ethiopia, Addis Ababa ,Gullele sub-city, "
                                              "Shegole  (with registered office at peace building"
                                              " ,in front of Kenema pharmacy head office) will"
                                              " be the controller of your personal data.",
                                          textDirection: TextDirection.ltr,
                                          maxLines: 20,
                                        ),
                                      )
                                  ),

                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                }
              })
      ),
    );
  }
}
