import 'package:alen/models/drugs.dart';
import 'package:alen/providers/drug.dart';
import 'package:alen/ui/Details/DetailForDrug.dart';
import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ListInCategories extends StatefulWidget {
  final Category category;
  final String id;
  final bool isPharma;

  const ListInCategories({Key key, this.category, this.id, this.isPharma})
      : super(key: key);
  @override
  _ListInCategoriesState createState() => _ListInCategoriesState();
}

class _ListInCategoriesState extends State<ListInCategories> {
  static const myCustomColors = AppColors();

  @override
  Widget build(BuildContext context) {
    var drugProvider = Provider.of<DrugProvider>(context);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: myCustomColors.loginBackgroud,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
              Container(
                  child: FutureBuilder<List<Drugs>>(
                      future: widget.isPharma
                          ? drugProvider.getDrugByCategoryAndPharmacyId(
                          widget.id, widget.category)
                          : drugProvider.getDrugByCategoryAndImporterId(
                          widget.id, widget.category),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none &&
                            snapshot.hasData == null) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.data == null) {
                          return Container(
                              child:
                              Center(child: CircularProgressIndicator()));
                        } else {
                          return GridView.builder(
                            gridDelegate:
                            SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 2 / 3.4,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return _buildCategoriesListItem(
                                  snapshot.data[index], ctxt, widget.id);
                            },
                            itemCount: snapshot.data.length,
                          );
                        }
                      })),
            ])));
  }

  _buildCategoriesListItem(Drugs category, BuildContext ctxt, String id) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => DetailForDrug(
                      drug: category,
                      id: id,
                      isPharma: widget.isPharma
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
                  child: Image.network(category.image,
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
        ));
  }
}
