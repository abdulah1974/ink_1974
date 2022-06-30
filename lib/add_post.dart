import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http4;
import 'package:another_flushbar/flushbar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ink/Button.dart';
import 'package:ink/favorite.dart';
import 'package:ink/main.dart';
class add_post extends StatefulWidget {
  const add_post({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
 }

class _accountState extends State<add_post>  with SingleTickerProviderStateMixin{
  TextEditingController textarea = TextEditingController();
  bool isLocked=true;
  int data=0;
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  Future<void> _uploadImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
        _cropImage();
      });
    }
  }



  Future<void> _cropImage() async {
    print("kll");
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,

        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,



        ],
        uiSettings: [
            AndroidUiSettings(
              cropFrameColor: Color.fromRGBO(1, 4, 30, 1),
              dimmedLayerColor: Color.fromRGBO(1, 4, 30, 1),
              backgroundColor: Color.fromRGBO(1, 4, 30, 1),
              toolbarTitle: 'Post',
              toolbarColor: Color.fromRGBO(1, 4, 30, 1),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio7x5,
              hideBottomControls: true,
              lockAspectRatio: true,
              showCropGrid: false,
            ),
          ]
      );

      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
          print("_imageFile");
        });
      }
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
   _tabController = TabController(vsync: this, length: myTabs.length);
   _tabController.addListener(_handleTabSelection);
    super.initState();

  }

  upload(File imageFile) async {
    var stream =
    new http.ByteStream(imageFile.openRead());

    var length = await imageFile.length();

    var uri = Uri.parse("http://192.168.100.42:2000/postimg?email=ink@gmail.com&password=ink");

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
  int _currentIndex = 0;
  final List<Tab> myTabs = <Tab>[
    Tab(icon: Icon(Icons.image,),),
    Tab(icon: Icon(Icons.text_fields,),),
  ];
  late TabController _tabController;


   BottomNavigationBar? navigationBar;
  List titel_post =[];
  Future<void>  titel() async {

    var response = await http4.get(Uri.parse("http://192.168.100.42:2000/post10?email=abdullah@gmail.com&password=aaaa&title="+textarea.text),);

    var json = jsonDecode(response.body);

    titel_post = json;


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
          actions: [
            _currentIndex == 0
                ?IconButton(
                    onPressed: () {
                      setState(() {
                        if(_croppedFile!=null){
                          upload(File(_croppedFile!.path));
                          _croppedFile = null;

                        }

                      });
                      print("1");
                    },
                    icon:_croppedFile!=null?Icon(Icons.add_task,):Icon(null),


                    splashRadius: 20,
                  )
                : IconButton(
                    onPressed: () {
                      if(textarea.text!=""){
                        print("2");
                        titel();
                        textarea.clear();
                      }else{
                        Flushbar(
                          margin: EdgeInsets.all(50),
                          borderRadius: BorderRadius.circular(8),
                          message:'You have to enter text',
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ).show(context);

                      }

                    },
                    icon: Icon(
                      Icons.add_task,
                    ),
                    splashRadius: 20,
                  ),
          ],
        ),
        body: Column(

          children: <Widget>[
            SizedBox(
              height: 50,

              child: AppBar(

                backgroundColor: Color.fromRGBO(1, 4, 30, 1),
                bottom: TabBar(

                  indicatorColor: Colors.white,
                  controller: _tabController,


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

            Expanded(
              child: TabBarView(
               controller:_tabController,
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

                                          child: _croppedFile != null
                                              ? Column(
                                            children: [

                                              Stack(
                                                children:
                                                [

                                                  SizedBox(
                                                    height: 300,

                                                    child: Center(
                                                      child: Image.file(File(_croppedFile!.path)),
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
                                                            _croppedFile = null;



                                                          //  navigationBar!.onTap!(1);

                                                           // navigationBar!.onTap!(0);

                                                           // scakey.currentState!._onItemTapped(1);





                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),


                                              SizedBox(height: 35,),
                                              /*
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

                                               */
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
                                              _uploadImage();
                                            //  getImage();
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




                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: textarea,
                    keyboardType: TextInputType.multiline,
                    maxLines: 27,
                    cursorColor: Colors.white,
                    cursorWidth: 1,
                    maxLength: 250,
                    autofocus: false,
                    decoration: InputDecoration(
                      counterStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white60),
                      hintText: "What are you thinking?",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(

                        borderSide:BorderSide(width: 1, color: Colors.transparent),


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

  _handleTabSelection() {
      setState(() {
        _currentIndex = _tabController.index;
      });

  }


}



