import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
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
      cropImage();

    });
  }


  cropImage() async {
    File? croppedFile = (await ImageCropper().cropImage(
        sourcePath: _imageFile!.path,

        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,


        ],
        androidUiSettings:const AndroidUiSettings(
          cropFrameColor:  Color.fromRGBO(1, 4, 30, 1),
          dimmedLayerColor:  Color.fromRGBO(1, 4, 30, 1),
          backgroundColor: Color.fromRGBO(1, 4, 30, 1),
          toolbarTitle: 'Post',
          toolbarColor: Color.fromRGBO(1, 4, 30, 1),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio7x5,
          hideBottomControls: true,
          lockAspectRatio: true,
          showCropGrid: false,



        )));
    if (croppedFile != null) {
      setState(() {
        _imageFile = croppedFile;

      });
    }
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


  upload(File imageFile) async {
    var stream =
    new http.ByteStream(imageFile.openRead());

    var length = await imageFile.length();

    var uri = Uri.parse("http://192.168.100.42:2000/postimg?email=abdullah@gmail.com&password=abd");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('recfile', stream, length,
        filename:(imageFile.path));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
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
                          margin: const EdgeInsets.only(top: 80),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(

                                ),
                              ),
                              SizedBox(height: 15),
                              Expanded(
                                child:  Container(
                                  height: double.infinity,
                                  margin: const EdgeInsets.only(
                                      left: 30.0, right: 30.0, top: 10.0),
                                  child: ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [
                                      ClipRRect(

                                          child: _imageFile != null
                                              ? Column(
                                            children: [

                                              Stack(
                                                children:
                                                [

                                                  SizedBox(
                                                    height: 300,

                                                    child: Center(
                                                      child: Image.file(_imageFile!),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(width: 270,),
                                                      InkWell(
                                                        child:Icon(
                                                          Icons.clear,
                                                          color: Colors.white,
                                                          size: 25,
                                                        ),
                                                        onTap: (){
                                                          setState(() {
                                                            _imageFile = null;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),


                                              SizedBox(height: 35,),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    upload(_imageFile!);
                                                    _imageFile = null;
                                                  });
                                                },
                                                style: ButtonStyle(
                                                    side: MaterialStateProperty.all(
                                                        const BorderSide(
                                                            width: 2, color: Colors.white)),
                                                    foregroundColor:
                                                    MaterialStateProperty.all(Colors.white),
                                                    padding: MaterialStateProperty.all(
                                                        const EdgeInsets.symmetric(
                                                            vertical: 5, horizontal: 20)),
                                                    textStyle: MaterialStateProperty.all(
                                                        const TextStyle(fontSize: 25))),
                                                child: Text("upload"),
                                              ),
                                            ],
                                          )
                                              : SizedBox(
                                            height: 350,
                                            child:GestureDetector(

                                            child:Icon(

                                              Icons.add_a_photo,
                                              color: Colors.white,
                                              size: 55,
                                            ),
                                            onTap: (){
                                              getImage();
                                            },
                                              ),
                                          ),


                                      ),
                                    ],
                                  )

                                ),

                              ),

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
                      hintText: "What are you thinking?",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(

                          borderSide:BorderSide(width: 1, color: Colors.white),


                      ),

                    ),

                  ),

                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}

