import 'package:alen/providers/language.dart';
import 'package:flutter/material.dart';

import 'package:alen/utils/AppColors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesOfPersonalDataWeCollect extends StatelessWidget {
  const CategoriesOfPersonalDataWeCollect({Key key}) : super(key: key);

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
                                      "2. CATEGORIES OF PERSONAL DATA WE COLLECT",
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
                                    "We collect data you give us voluntarily (for example,"
                                        " an email address). We also collect data"
                                        " automatically (for example, your IP address).",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),

                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "2.1 Data you give us.",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.6,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "You may be asked to provide us information about "
                                        "yourself when you register for and/or use the"
                                        " Service. This information includes: first name,"
                                        " last name, phone number, email, gender, date of"
                                        " birth (together “Required Information”), as well"
                                        " as your photo, address details, working hours."
                                        "To use our Service and register an account, you will"
                                        " need to provide Required Information. Sometimes"
                                        " you may also need to provide to us additional"
                                        " information in the communication with our Support"
                                        " Team in order to fulfill your request (for example,"
                                        " if your account was previously blocked, we may ask"
                                        " you to confirm your identity by providing an ID document).",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "2.2 Data provided to us by third parties",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.6,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "When you decide to log in using Facebook,"
                                        " we get personal data from your Facebook account. "
                                        "This includes your profile image, name, and Facebook"
                                        " ID. Unless you opt out on the Facebook Login screen,"
                                        " we will also collect other data, such as email address,"
                                        " gender, date of birth, friends list, and location as"
                                        " listed in your Facebook profile.\n\n"

                                        "For more information, please refer to the "
                                        "Facebook Permissions Reference (describes "
                                        "the categories of information, which Facebook may"
                                        " share with third parties and the set of requirements)"
                                        " and to the Facebook Data policy. In addition, "
                                        "Facebook lets you control the choices you made when"
                                        " connecting your Facebook profile to the App on "
                                        "their Apps and Websites page.\n\n"

                                        "When you log in with Google, we get your name, "
                                        "email address, profile language settings,"
                                        " profile picture, gender, and date of birth."
                                        " To know more about how Google processes your data, "
                                        "visit its Privacy Policy. To remove access granted"
                                        " to us, visit Google Permissions.\n\n"

                                        "When you decide to log in using Apple, we get Apple ID,"
                                        " name and email from your account. You can use Hide "
                                        "My Email function during signing in with Apple,"
                                        " and it will create and share a unique, random email"
                                        " address that will forward our messages to your personal email.",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "2.3 Data we collect automatically:",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.6,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "2.3.1. Data about how you found us",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.3,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "We collect data about your referring URL "
                                        "(that is, the place on the Web where"
                                        " you were when you tapped on our ad).",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),

                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "2.3.2. Device and Location Data.",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.3,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "We collect data from your device. Examples"
                                        " of such data include: language settings,"
                                        " IP address, time zone, type and model of"
                                        " a device, device settings, operating system,"
                                        " Internet service provider, mobile carrier,"
                                        " hardware ID, and Facebook ID.",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),

                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "2.3.3. Usage data",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.3,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "We record how you interact with our Service. "
                                        "For example, we log the features, and content"
                                        " you interact with, how often you use the "
                                        "Service, how long you are on the Service, "
                                        "what sections you use, how many ads you watch.",
                                    textDirection: TextDirection.ltr,
                                    maxLines: 20,
                                  ),
                                )
                            ),

                            Container(
                                padding: EdgeInsets.all(30),
                                width: MediaQuery.of(context).size.width,
                                child:Text(
                                  "2.3.4. Cookies",
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.3,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "A cookie is a small text file that is stored on"
                                        " a user's computer for record-keeping purposes. "
                                        "Cookies can be either session cookies or "
                                        "persistent cookies. A session cookie expires "
                                        "when you close your browser and is used to make"
                                        " it easier for you to navigate our Service."
                                        " A persistent cookie remains on your hard drive"
                                        " for an extended period of time. \n\n"
                                        "Cookies are used, in particular, to automatically "
                                        "recognize you the next time you visit our"
                                        " website. As a result, the information, "
                                        "which you have earlier entered in certain"
                                        " fields on the Website may automatically "
                                        "appear the next time when you use our Service."
                                        " Cookie data will be stored on your device "
                                        "and most of the times only for a limited "
                                        "time period.",
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
        });
  }
}
