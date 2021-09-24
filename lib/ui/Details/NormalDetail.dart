import 'dart:io';

import 'package:alen/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class NormalDetail extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String description;
  final String serviceId;
  final String homeCareId;

  NormalDetail({
    Key key,
    this.name,
    this.imageUrl,
    this.description,
    this.serviceId,
    this.homeCareId
  }) : super(key: key);
  @override
  _NormalDetailState createState() => _NormalDetailState();
}

class _NormalDetailState extends State<NormalDetail> {

  static const myCustomColors = AppColors();
  static String prc;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final PageController controller = PageController(initialPage: 0);
    return Scaffold(
      appBar: AppBar(
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
                    SizedBox(
                      height: 200,
                      width: 350,
                      child: (widget.imageUrl==null)?Text("Image not available"):
                      Image.network(widget.imageUrl,
                          width: 200, height: 120, fit: BoxFit.fill),
                    ),
                    Container(
                        padding: EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child:Text(
                              widget.name??"Name",
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
                            widget.description??"Description",
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
    );
  }
}


