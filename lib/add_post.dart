import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class add_post extends StatefulWidget {
  const add_post({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<add_post> {
  TextEditingController textarea = TextEditingController();
  bool isLocked=true;
  int data=0;
  File? _imageFile=null;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
      

    });
  }



  enableButton() {
    setState(() {
      isLocked = true;
    });
  }
  @override
  void initState() {
   enableButton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(1, 4, 30, 1),
          title: Text(
            'Post',
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
              child: AppBar(
                backgroundColor: Color.fromRGBO(1, 4, 30, 1),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.image),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.text_fields,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  // first tab bar view widget
                  Scaffold(
                    backgroundColor: Color.fromRGBO(1, 4, 30, 1),
                    body: Stack(
                      children: <Widget>[
                        Container(
                          height: 360,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50.0),
                                  bottomRight: Radius.circular(50.0)),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [],
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 80),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(

                                ),
                              ),
                              SizedBox(height: 20.0),
                              Expanded(
                                child:  Container(
                                  height: double.infinity,
                                  margin: const EdgeInsets.only(
                                      left: 30.0, right: 30.0, top: 10.0),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(30.0),
                                    child: _imageFile != null
                                        ? Image.file(_imageFile!)
                                        : Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                      size: 50,
                                    ),

                                  ),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 16.0),
                                  margin: const EdgeInsets.only(
                                      top: 30,
                                      left: 20.0,
                                      right: 20.0,
                                      bottom: 20.0),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    colors: [],
                                  )))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // second tab bar viiew widget
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: textarea,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    maxLength: 250,
                    decoration: InputDecoration(
                        counterStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Enter Remarks",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white))),
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Color.fromRGBO(1, 4, 30, 1),
          overlayColor: Color.fromRGBO(1, 4, 30, 1),
          overlayOpacity: 0.5,
          spacing: 15,
          spaceBetweenChildren: 15,
          closeManually: true,
          children: [
            SpeedDialChild(
                child: Icon(Icons.drive_folder_upload),
                label: 'Image',
                onTap: () {
                  getImage();

                  print('Mail Tapped');
                }),
            SpeedDialChild(
                child: Icon(Icons.text_fields_rounded),
                label: 'Text',
                onTap: () {
                  print('Copy Tapped');
                }),
          ],
        ),
      ),
    );
  }
}
