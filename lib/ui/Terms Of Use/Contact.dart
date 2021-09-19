import 'package:flutter/material.dart';

import 'package:alen/utils/AppColors.dart';

class Contact extends StatelessWidget {
  const Contact({Key key}) : super(key: key);

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
                              "Contact",
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
                            "8.1. If you want to send any notice"
                                " under these Terms or have any"
                                "questions regarding the Service, "
                                "you may contact us at:***.com",
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
