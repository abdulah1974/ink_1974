import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ink/addcoment.dart';
import 'package:ink/model_comment.dart';
class comment extends StatefulWidget {
 late int id;
 late int myid;
 comment(int id2, int myids){
   id=id2;
   myid=myids;
 }

  @override
  _commentState createState() => _commentState(id,myid);
}

class _commentState extends State<comment> {

  late int id;
  late int myid;
  _commentState(int id2,int myids){
    id=id2;
    myid=myids;
  }


  TextEditingController nameController = TextEditingController();


  void comment1() async {
    var ur="http://192.168.100.42:2000/comment?id="+id.toString()+"&comment="+nameController.text+"&user_id="+myid.toString();
    var response = await http
        .get(Uri.parse(ur));
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

  List  _loadedPhotos = [];
  List<model_commdemt>  list = [];


  List user=[];

  void getr() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/get_usernamr_image?id="+id.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      user = jsondata;
      for(var i=0;i<user.length;i++){
        list.add( new model_commdemt(usename:_loadedPhotos[i]["username"]));

      }


    });
  }

  void aa() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/getcomment?post_id="+id.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      _loadedPhotos = jsondata;

      for(var i=0;i<_loadedPhotos.length;i++){
        list.add( new model_commdemt(usename:_loadedPhotos[i]["username"],comment:_loadedPhotos[i]["comment"],profile_photo: _loadedPhotos[i]["profile_photo"],tiem:_loadedPhotos[i]["time"] ));

      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aa();
    print("myid:"+myid.toString());
    getr();
    print(id);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    print(now.hour);

    print(formattedDate);
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
            height: 640,
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
                  ///

                      if(nameController.text==""){

                      }else{
                        addItemToList();
                      }
                      setState(() {


                        if(nameController.text==""){

                        }else{
                          list.insert(0, model_commdemt(comment:nameController.text,usename:list[0].usename,profile_photo:list[0].profile_photo,tiem:list[0].tiem ));
                          nameController.clear();

                        }



                      });


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

        itemCount: list.length,
        physics: BouncingScrollPhysics(),
        itemBuilder:(BuildContext context, int index){

          return ListTile(
            leading:Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+list[index].profile_photo.toString()),
                ),
              ),
            ),
            title: Row(
              children: [
                Text(
                  list[index].usename.toString(),
                  style:TextStyle(color: Colors.white, fontSize: 13),

                ),
                SizedBox(width: 10,),
                Text(
                  list[index].tiem.toString(),
                  style:TextStyle(color: Colors.white, fontSize: 10),

                ),
              ],
            ),


            subtitle: Text(
               list[index].comment.toString(),
              style: TextStyle(color: Colors.white, fontSize: 13,),

            ),


          );
        });
  }


}
