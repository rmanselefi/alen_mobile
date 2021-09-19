import 'package:flutter/material.dart';

import 'package:alen/utils/AppColors.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key key}) : super(key: key);

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
                                  "8. Contact Us",
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
                                "You may contact us at any time for details"
                                    " regarding this Privacy Policy. For"
                                    " any questions concerning your account"
                                    " or your personal data please contact"
                                    " us at hyssoppharma.com",
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
