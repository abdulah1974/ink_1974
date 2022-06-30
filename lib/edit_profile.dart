import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http3;
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http1;
import 'package:http/http.dart' as http2;
import 'package:another_flushbar/flushbar.dart';
class edit_profile extends StatefulWidget {

  late  int id;
  late String emails;
  late String paswrd;
  edit_profile(int ids, String email, String paswd){
    id=ids;
    emails=email;
    paswrd=paswd;
  }


  @override
  _edit_profileState createState() => _edit_profileState(id,emails,paswrd);


}

class _edit_profileState extends State<edit_profile> {


  late  int id;
  late String emails;
  late String paswrd;
  _edit_profileState(int ids,String email, String paswd){
    id=ids;
    emails=email;
    paswrd=paswd;
  }

  List pip = [];
  void pio() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/getpio?id="+id.toString()),);

    var json = jsonDecode(response.body);


    setState(() {
      pip = json;

    });
  }

  TextEditingController bio = TextEditingController();
  ///تعديل البايو
  List editpio = [];
  void edit_pio() async {
    var response = await http
        .get(Uri.parse(
        "http://192.168.100.42:2000/bio?email="+emails+"&password="+paswrd+"&bio="+bio.text),);

    var json = jsonDecode(response.body);


    setState(() {
      editpio = json;

    });
  }



  TextEditingController username = TextEditingController();
  List update_username = [];
  void update_usernam() async {
    var response = await http2
        .get(Uri.parse(
        "http://192.168.100.42:2000/update_username?email="+emails+"&password="+paswrd+"&username="+username.text),);

    var json = jsonDecode(response.body);


    setState(() {
      update_username = json;

    });
  }



  late File _image = new File('your initial file');
  final picker = ImagePicker();
  bool img=true;
  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        img=false;
      //  cropImage();
      } else {

      }
    });
  }

  /*
  cropImage() async {
    File? croppedFile = (await ImageCropper().cropImage(
        sourcePath: _image.path,

        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,

        ],

        cropStyle:CropStyle.circle,

        // rotating/straightening
        androidUiSettings:const AndroidUiSettings(
          cropFrameColor:  Color.fromRGBO(1, 4, 30, 1),

          toolbarTitle: 'ink',
          toolbarColor:  Color.fromRGBO(1, 4, 30, 1),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          dimmedLayerColor:  Color.fromRGBO(1, 4, 30, 1),
          hideBottomControls: true,
          lockAspectRatio: true,
          backgroundColor: Color.fromRGBO(1, 4, 30, 1),
          showCropGrid: false,

        )));
    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;
        print(croppedFile.path);
      });
    }
  }

   */





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pio();
    /*
    for(int i=0;i<pip.length;i++)
      {
     ///   _authorController = TextEditingController(text:pip[i]["username"]);
      }

     */


  }
  upload(File imageFile) async {
    var stream =
    new http1.ByteStream(imageFile.openRead());

    var length = await imageFile.length();

    var uri = Uri.parse("http://192.168.100.42:2000/bio2?email="+emails+"&password="+paswrd);

    var request = new http1.MultipartRequest("POST", uri);
    var multipartFile = new http1.MultipartFile('recfile', stream, length,
        filename:(imageFile.path));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    if(response.statusCode==200)
      {
        print("hhhhh");
      }
    response.stream.transform(utf8.decoder).listen((value) {
      print(response);
    });
  }
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = username.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {

      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      body: Column(
        children: [
         Row(
           children: [
             SizedBox(height: 100,width: 10,),

             IconButton(
             splashRadius: 20,

               onPressed: ()
             {
               Navigator.pop(context);


             },
                 icon: Icon(Icons.arrow_back),color: Colors.white,),




                Text("Edit profile",style: TextStyle(fontSize: 18,color: Colors.white),),



                SizedBox(width: 164,),



                IconButton(onPressed: (){


                if(bio.text=="")
                  {
                    print("den");
                  }else{
                  edit_pio();
                  }

             if(username.text==""&&bio.text==""){

               Flushbar(
                 margin: EdgeInsets.all(50),
                 borderRadius: BorderRadius.circular(8),
                 message:'You have to enter text',
                 backgroundColor: Colors.red,
                 duration: Duration(seconds: 3),
               ).show(context);

             }else{
               print("hh");
               Navigator.pop(context);
             }



                 upload(_image);
                 if(username.text==""){
                   print("den2");
                 }else{
                   update_usernam();
                 }


             },


                  splashRadius: 20,
                  icon: Icon(Icons.add_task_outlined),color: Colors.white,),


           ],
         ),
         for(var i=0;i<pip.length;i++)
          GestureDetector(

            child: Container(
              width: 110,
              height: 100,

              child: Visibility(
                visible:img,
                child:Container(

                  child:Center(
                    child:Container(

                      child: Center(
                        child:pip[i]["profile_photo"]==null?

                        Container(
                          child: Center(child: Text(charAt(pip[i]["username"].toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),),


                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,


                          ),

                        ):Center(

                            child:Container(



                              decoration: BoxDecoration(

                                shape: BoxShape.circle,
                                image: DecorationImage(

                                  fit: BoxFit.cover,

                                  image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+pip[i]["profile_photo"],),


                                ),

                              ),

                            )
                        ),
                      ),


                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(



                shape: BoxShape.circle,
                image: DecorationImage(

                  fit: BoxFit.fill,
                  image:FileImage(_image),

                ),
              ),
            ),
            onTap: () {
              getImage();

            },

          ),
          SizedBox(height: 20,),
          Card(
            shadowColor: Colors.white,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child:Container(
              height: 192,
              width: 350,
              child: Column(
                children: [
                  SizedBox(height: 22,),
                  Container(
                    child:TextFormField(
                      inputFormatters: [
                     FilteringTextInputFormatter.allow(RegExp('[a-z_0-9]')),


                      ],
                      controller: username,
                      maxLength: 30,
                    ///  onChanged: (text) => setState(() => text),
                    //  initialValue: pip[0]["username"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black),

                        hintText: 'Username',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 3.0, 23.0, 12.0),
                        border:OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      ///  errorText: _errorText,
                        focusedBorder: myfocusborder(),

                      ),
                    ),
                    width: 300,

                  ),
                  SizedBox(height: 10,),
                  Container(
                    child:TextFormField(

                      controller: bio,
               ///     initialValue: pip[0]["bio"],
                      maxLength: 200,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,


                      ),

                      decoration: InputDecoration(


                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black),

                        hintText: 'Bio',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 3.0, 23.0, 12.0),
                        border:OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),


                        ),
                        focusedBorder: myfocusborder(),
                      ),

                    ),
                    width: 300,

                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),






        ],
      ),
    );

  }
  String charAt(String subject, int position) {
    if (subject is! String ||
        subject.length <= position ||
        subject.length + position < 0) {
      return '';
    }

    int _realPosition = position < 0 ? subject.length + position : position;

    return subject[_realPosition];
  }
}
OutlineInputBorder myfocusborder(){
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color:Colors.black,
        width: 3,
      )
  );
}
