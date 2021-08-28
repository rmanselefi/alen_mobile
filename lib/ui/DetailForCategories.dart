import 'package:alen/ui/ServiceCategory/Category.dart';
import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'DetailsPage.dart';

class DetailsForCategory extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  final List<Category> category;

  DetailsForCategory({
    Key key,
     this.name,
     this.imageUrl,
     this.description,
     this.category
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
              )),
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
                          child: Image.asset(imageUrl,
                              width: 200, height: 120, fit: BoxFit.fill),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.03,
                              30,
                              MediaQuery.of(context).size.width * 0.03,
                              5),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Types',
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              // GestureDetector(
                              //     onTap: (){
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => SeeAllServices()
                              //           ));
                              //     },
                              //   child: Text(
                              //     'See All',
                              //     textScaleFactor: 1.3,
                              //     textAlign: TextAlign.left,
                              //     overflow: TextOverflow.ellipsis,
                              //     style: const TextStyle(fontWeight: FontWeight.bold,
                              //     color: Colors.blueAccent),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        Container(
                            height: 110.0,
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.07,
                                5,
                                MediaQuery.of(context).size.width * 0.07,
                                30),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return _buildHopitalServicesListItem(
                                    category[index], ctxt);
                              },
                              itemCount: category.length,
                            )),
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
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                description,
                                textDirection: TextDirection.ltr,
                                maxLines: 10,
                              ),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                description,
                                textDirection: TextDirection.ltr,
                                maxLines: 10,
                              ),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                description,
                                textDirection: TextDirection.ltr,
                                maxLines: 10,
                              ),
                            )
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  )
                ],
              )),
        ));
  }
  _buildHopitalServicesListItem(Category category, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                // builder: (context) => ListInServices()
                  builder: (context) => DetailsPage(name: category.name, imageUrl: category.imagePath, description: category.detail, )
              ));
        },
        child: Card(
            elevation: 0,
            color: myCustomColors.mainBackground,
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150.0),
                  ),
                  // // c
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: Image.asset(
                      category.imagePath,
                      fit: BoxFit.fitHeight,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                ),
                Text(
                  category.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )));
  }
}
