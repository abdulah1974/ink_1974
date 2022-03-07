import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class comment extends StatefulWidget {
 late int id;

 comment(int id2){
   id=id2;
 }

  @override
  _commentState createState() => _commentState(id);
}

class _commentState extends State<comment> {

  late int id;
  _commentState(int id2){
    id=id2;
  }


  TextEditingController nameController = TextEditingController();


  void comment1() async {

    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/comment?id="+id.toString()+"&comment="+nameController.text));
    var jsondata = jsonDecode(response.body);


    setState(() {
      _loadedPhotos = jsondata;
    });
  }



  void addItemToList(){
    setState(() {
   comment1();
    });
  }

  List _loadedPhotos = [];



  void aa() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/getcomment?post_id="+id.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      _loadedPhotos = jsondata;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aa();
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      appBar: AppBar(
        title:  Text("Comment"),
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      ),
      body:Stack(
        children: <Widget>[
          Container(
            height: 650,
            child: postComment(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(

              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 55,
              width: double.infinity,
              color:  Color.fromRGBO(1, 4, 30, 1),
              child: Row(
                children: <Widget>[


                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: nameController,
                      decoration: InputDecoration(

                          hintText: "Write Comment...",
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      addItemToList();
                      nameController.clear();
                    },
                    child: Icon(Icons.send_outlined,color: Colors.black,size: 25),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget postComment()
       {
    return  ListView.builder(
        itemCount: _loadedPhotos.length,
        physics: BouncingScrollPhysics(),
        itemBuilder:(BuildContext context, int index){
          return  Column(
            children: [
              SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+_loadedPhotos[index]["profile_photo"]),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      _loadedPhotos[index]["username"],
                      style:
                      TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),

                  SizedBox(
                    width: 184,
                  ),

                ],
              ),
              SizedBox(
                height: 10,
              ),
                Text(
                _loadedPhotos[index]["comment"],
                style: TextStyle(color: Colors.white, fontSize: 13,),
               ),

            ],
          );
        });
  }


}
