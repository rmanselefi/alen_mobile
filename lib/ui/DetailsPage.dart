import 'package:flutter/material.dart';
import 'AppColors.dart';

class DetailsPage extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;

  DetailsPage({
    Key key,
     this.name,
     this.imageUrl,
     this.description,
  }) : super(key: key);

  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: myCustomColors.mainBackground,
            appBarTheme: AppBarTheme(
              color: myCustomColors.loginBackgroud,
            )),
        home: Scaffold(
          appBar: AppBar(
              leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )
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
                    SizedBox(
                      height: 200,
                      width: 350,
                      child: Image.network(imageUrl,
                          width: 200, height: 120, fit: BoxFit.fill),
                    ),
                    Container(
                        padding: EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child:Text(
                              name,
                              textAlign: TextAlign.left,
                              textScaleFactor: 2,
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
                            description,
                            textDirection: TextDirection.ltr,
                            maxLines: 10,
                          ),
                        )
                    ),
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
