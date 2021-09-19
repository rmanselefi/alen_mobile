import 'package:flutter/material.dart';

import 'package:alen/utils/AppColors.dart';

class DataRetention extends StatelessWidget {
  const DataRetention({Key key}) : super(key: key);

  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
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
                                  "7. Data Retention",
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
                                "We will store your personal data for as "
                                    "long as it is reasonably necessary"
                                    " for achieving the purposes set forth"
                                    " in this Privacy Policy (including"
                                    " providing the Service to you), which "
                                    "includes (but is not limited to) the"
                                    " period during which you have an “Alen” "
                                    "account. We will also retain and use your"
                                    " personal data as necessary to comply with"
                                    " our legal obligations, resolve disputes,"
                                    " and enforce our agreements.",
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
}
