import 'package:alen/ui/ServiceCategory/Category.dart';
import 'package:flutter/material.dart';

import '../../utils/AppColors.dart';
import '../../utils/DetailsPage.dart';


class ListInCategories extends StatefulWidget {

  @override
  _ListInCategoriesState createState() => _ListInCategoriesState();
}

class _ListInCategoriesState extends State<ListInCategories> {

  static const myCustomColors = AppColors();
  List<Category> categories = Category.categories;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: 'Ubuntu',
            scaffoldBackgroundColor: myCustomColors.mainBackground),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: myCustomColors.loginBackgroud,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                )),
            body: SingleChildScrollView(
                child: Stack(
                    children: <Widget>[
                      Container(
                          child: categories.length == 0
                              ? Center(
                            child: Text(
                              "No Health Articles Available",
                            ),
                          )
                              : GridView.builder(
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 2 / 2.6,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return _buildCategoriesListItem(
                                  categories[index], ctxt);
                            },
                            itemCount: categories.length,
                          )),
                    ]))
        )
    );
  }
  _buildCategoriesListItem(Category category, BuildContext ctxt) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    name: category.name,
                    description: category.detail,
                    imageUrl: category.imagePath,
                  )));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              clipBehavior: Clip.hardEdge,
              child: Container(
                width: 150,
                height: 180,
                child: SizedBox(
                  height: 180,
                  width: 150,
                  child: Image.asset(category.imagePath,
                      width: 150, height: 180, fit: BoxFit.fill),
                ),
              ),
            ),
            Text(
              category.name,
              maxLines: 2,
              textScaleFactor: 1.1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        )
    );
  }
}
