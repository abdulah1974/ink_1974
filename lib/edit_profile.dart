import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'account.dart';
class edit_profile extends StatefulWidget {


  @override
  _edit_profileState createState() => _edit_profileState(

  );
}

class _edit_profileState extends State<edit_profile> {
  var _controller = TextEditingController();


  late File _image = new File('your initial file');

  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {

      }
    });
  }
  String username="abdullah";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      body: Column(
        children: [
         Row(
           children: [
             SizedBox(height: 100,width: 10,),
             IconButton(onPressed: ()
             {
               Navigator.pop(context);
             },
                 icon: Icon(Icons.arrow_back),color: Colors.white,),
                Text("Edit profile",style: TextStyle(fontSize: 18,color: Colors.white),),
                SizedBox(width: 165,),
                IconButton(onPressed: ()
             {
               Navigator.pushAndRemoveUntil(
                 context,
                 MaterialPageRoute(
                   builder: (BuildContext context) => account(),
                 ),
                     (route) => false,
               );
             },



               icon: Icon(Icons.add_task_outlined),color: Colors.white,),


           ],
         ),
          InkWell(
            child: Container(
              width: 110,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: FileImage(_image),
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
                    child:TextField(
                    maxLength: 30,
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

                      ),
                    ),
                    width: 300,

                  ),
                  SizedBox(height: 10,),
                  Container(
                    child:TextField(
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

