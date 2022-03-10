import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http3;
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http1;
import 'package:http/http.dart' as http2;
import 'account.dart';
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
      } else {

      }
    });
  }



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


               onPressed: ()
             {
               Navigator.pop(context);


             },
                 icon: Icon(Icons.arrow_back),color: Colors.white,),




                Text("Edit profile",style: TextStyle(fontSize: 18,color: Colors.white),),



                SizedBox(width: 165,),



                IconButton(onPressed: (){
               Navigator.pop(context);

                if(bio.text=="")
                  {
                    print("den");
                  }else{
                  edit_pio();
                  }

                 upload(_image);
                 if(username.text==""){
                   print("den");
                 }else{
                   update_usernam();
                 }


             },



               icon: Icon(Icons.add_task_outlined),color: Colors.white,),


           ],
         ),
         for(var i=0;i<pip.length;i++)
          InkWell(
            child: Container(
              width: 110,
              height: 100,
              child: Visibility(
                visible:img,
                child:Container(

                  decoration: BoxDecoration(



                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path=" +
                          pip[i]["profile_photo"],),

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
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black),

                        hintText: 'Bio',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 3.0, 23.0, 12.0),
                        border:OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),

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

}

