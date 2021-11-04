import 'package:alen/providers/language.dart';
import 'package:flutter/material.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HowCanYouExerciseYourRights extends StatelessWidget {
  const HowCanYouExerciseYourRights({Key key}) : super(key: key);

  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
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
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child:Text(
                                      "5. HOW YOU CAN EXERCISE YOUR RIGHTS",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 2,
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
                                    "To be in control of your personal data,"
                                        " you have the following rights:\n\n"
                                        "Accessing / reviewing / updating / correcting"
                                        " your personal data.You may review, edit,"
                                        " or change the personal data that you had"
                                        " previously provided to “Alen” in the settings"
                                        " section on the Website.\n\n"
                                        "When you request deletion of your personal data,"
                                        " we will use reasonable efforts to honor your "
                                        "request. In some cases we may be legally required"
                                        " to keep some of the data for a certain time; "
                                        "in such event, we will fulfill your request"
                                        " after we have complied with our obligations."
                                        "Objecting to or restricting the use of your personal"
                                        " data.You can ask us to stop using all"
                                        " or some of your personal data or limit our"
                                        " use thereof by sending a request at name@com",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 25,
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
        });
  }
}
