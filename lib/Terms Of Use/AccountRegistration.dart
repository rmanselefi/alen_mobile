import 'package:alen/providers/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alen/utils/AppColors.dart';

class AccountRegistration extends StatelessWidget {
  const AccountRegistration({Key key}) : super(key: key);

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
                                      "Account Registration",
                                      textAlign: TextAlign.left,
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
                                  child: RichText(
                                    text: TextSpan(
                                        text:
                                        "2.1. In order to use certain features of"
                                            " the Service you may need to register"
                                            " an account on the Platform (the ",
                                        style: TextStyle(
                                            color: Colors.black
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '“Account”',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),
                                          ),
                                          TextSpan(
                                              text: ") "
                                                  "and provide certain information about yourself as"
                                                  " prompted by the registration form.\n\n"
                                                  "2.2. You may create an Account as an "
                                                  "individual or as an authorized"
                                                  " representative of a company.\n\n"
                                                  "2.3. You acknowledge that you are"
                                                  " solely responsible for safeguarding"
                                                  " and maintaining the confidentiality of "
                                                  "access details to your Account and "
                                                  "that you are fully responsible and liable"
                                                  " for any activity performed using your "
                                                  "Account access details.\n\n"
                                                  "2.4. We reserve the right to suspend or "
                                                  "terminate your Account, or your access"
                                                  " to the Service, with or without notice"
                                                  " to you, in the event that you breach"
                                                  " these Terms.\n\n"
                                                  "2.5. You agree to immediately notify us of"
                                                  " any unauthorized use, or suspected"
                                                  " unauthorized use of your Account or "
                                                  "any other breach of security. We cannot"
                                                  " and will not be liable for any loss or "
                                                  "damage arising from your failure to comply "
                                                  "with the above requirements.",
                                          ),
                                        ]
                                    ),
                                  )
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
