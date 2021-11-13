import 'package:alen/providers/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alen/utils/AppColors.dart';

class MiscellaneousProvisions extends StatelessWidget {
  const MiscellaneousProvisions({Key key}) : super(key: key);

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
                                      "MISCELLANEOUS PROVISIONS",
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
                                  child: Text(
                                    "7.1. Except as otherwise provided, if"
                                        " any provision of these Terms is"
                                        " held to be invalid, void, or for"
                                        " any reason unenforceable, such "
                                        "provision shall be struck out and"
                                        " shall not affect the validity and"
                                        " enforceability of the remaining provisions.\n\n"
                                        "7.2. We may transfer and assign any and"
                                        " all of our rights and obligations"
                                        " under these Terms to any other "
                                        "person, by any way, including by "
                                        "novation, and by accepting these Terms "
                                        "you give us consent to any such transfer"
                                        " or assignment.\n\n"
                                        "7.3. If we fail to take any action with"
                                        " respect to your breach of these "
                                        "Terms, we will still be entitled"
                                        " to use our rights and remedies in"
                                        " any other situation where you breach"
                                        " these Terms.\n\n"
                                        "7.4. In no event shall the Administrator "
                                        "be liable for any failure to comply "
                                        "with these Terms to the extent that"
                                        " such failure arises from factors outside"
                                        " the Administrator's reasonable control.\n\n",
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
