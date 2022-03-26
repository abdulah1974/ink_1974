import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:ink/dateTiem.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ink/addcoment.dart';
import 'package:ink/model_comment.dart';
import 'dart:ui';
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
        .get(Uri.parse("http://192.168.100.42:2000/get_usernamr_image?id="+myid.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      user = jsondata;
      for(var i=0;i<user.length;i++){
     ///   list.add( new model_commdemt(usename:user[i]["username"],profile_photo:user[i]["profile_photo"]));
     ///   print(user[i]["id"]);

      }


    });
  }
  late DateTime time1;
  var api="http://192.168.100.42:2000/getcomment?post_id=";
  void aa() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/getcomment22?post_id="+id.toString()+"&user_id="+myid.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      _loadedPhotos = jsondata;

      for(var i=0;i<_loadedPhotos.length;i++){
        list.add( new model_commdemt(usename:_loadedPhotos[i]["username"],comment:_loadedPhotos[i]["comment"],profile_photo: _loadedPhotos[i]["profile_photo"],tiem:_loadedPhotos[i]["time"],dlet:_loadedPhotos[i]["comsetmy"],id_comment:_loadedPhotos[i]["id_comment"]));
      ///  time1 = DateTime.parse(_loadedPhotos[i]["time"]);

      }
    });
  }

//  var i="http://192.168.100.42:2000/dlate_comment?id_comment=15";
  var delat=[];
  void dlate_comment(var i) async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/dlate_comment?id_comment="+i.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      delat = jsondata;



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

    //String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

  //  print(formattedDate);

  //  dateTiem s=new dateTiem();
   // s.convertToAgo(input);

  }


 //  dateTiem s=new dateTiem();
  String convertToAgo(DateTime input){
    Duration diff = DateTime.now().difference(input);

    if(diff.inDays >= 1){
      return '${diff.inDays} day(s) ago';
    } else if(diff.inHours >= 1){
      return '${diff.inHours} hour(s) ago';
    } else if(diff.inMinutes >= 1){
      return '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1){
      return '${diff.inSeconds} second(s) ago';
    } else {
      return 'just now';
    }
  }
 // var nows = new DateTime.now();

 bool bo=false;
  List<int> selectedIndexList =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      appBar: AppBar(
        title:  Text("Comment"),
        leading:   IconButton(
            splashRadius: 20,
            onPressed: (){

              setState(() {
                Navigator.of(context).pop();
              });
            }, icon:Icon(Icons.arrow_back,color: Colors.white,)),
        actions: [
/*
         Container(
           width: 40,
           child:ListView.builder(
               shrinkWrap: true,
               itemCount: list.length,
               itemBuilder:(_,index){
                 return  Visibility(
                   visible:selectedIndexList.contains(index),

                   child:list[index].dlet==true?IconButton(
                       splashRadius: 20,
                       onPressed:(){
                         setState(() {
                           if(!selectedIndexList.contains(index)) {

                             selectedIndexList.add(index);
                             print("hhh");

                            // dlate_comment(list[index].id_comment.toString());
                           } else {

                             selectedIndexList.remove(index);
                             list.removeAt(index);

                             //  for(var c=0;c<_loadedPhotos.length;c++)
                           ///  dlate_comment(list[c].id_comment.toString());
                             print("ccc");
                           }
                         });
                       },
                       icon:Icon(Icons.delete,color: Colors.white,)):IconButton(
                       splashRadius: 20,
                       onPressed: (){

                         setState(() {
                           if(!selectedIndexList.contains(index)) {

                             selectedIndexList.add(index);
                             print("hhh");



                           } else {

                             selectedIndexList.remove(index);



                             print("ccc");
                           }
                         });
                       }, icon:Icon(Icons.clear,color: Colors.white,)),
                 );
               }),
         ),
          */


        ],
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
                  Container(

                    width: 35,

                    child:ListView.builder(
                       physics: NeverScrollableScrollPhysics(),
                       itemCount: user.length,
                        itemBuilder:(_,index){
                          return  Container(

                            child:Center(
                              child:Container(

                                child: Center(
                                  child:list[index].profile_photo==null?

                                  Container(
                                    child: Center(child: Text(charAt(user[index]["username"].toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
                                    width: 35,
                                    height: 35,

                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,


                                    ),

                                  ):Center(

                                      child:Container(

                                        width: 35,
                                        height: 35,

                                        decoration: BoxDecoration(

                                          shape: BoxShape.circle,
                                          image: DecorationImage(

                                            fit: BoxFit.cover,

                                            image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+user[index]["profile_photo"],),


                                          ),

                                        ),

                                      )
                                  ),
                                ),


                              ),
                            ),
                          );
                        }),
                  ),

                  Expanded(
                    child: TextField(
                     // cursorWidth: 2,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      controller: nameController,

                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),

                          hintText: "Write comment...",
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

                          DateTime now = DateTime.now();
                          // print(convertToAgo(now));

                          list.insert(0, model_commdemt(comment:nameController.text,usename:user[0]["username"],profile_photo:user[0]["profile_photo"],tiem:convertToAgo(now)));

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
  Widget  postComment()
       {
    return  ListView.builder(

        itemCount: list.length,
        physics:const BouncingScrollPhysics(),
        itemBuilder:(BuildContext context, int index){

          return ListTile(

               title:Container(
                 child:Column(
                   children: [

                   Row(
                     children: [

                       GestureDetector(
                         onTap: (){

                         },
                         child:Container(

                           child:Center(
                             child:Container(

                               child: Center(
                                 child:list[index].profile_photo==null?

                                 Container(
                                   child: Center(child: Text(charAt(list[index].usename.toString().toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
                                   width: 38,
                                   height: 38,

                                   decoration: BoxDecoration(
                                     color: Colors.blue,
                                     shape: BoxShape.circle,


                                   ),

                                 ):Center(

                                     child:Container(

                                       width: 38,
                                       height: 38,

                                       decoration: BoxDecoration(

                                         shape: BoxShape.circle,
                                         image: DecorationImage(

                                           fit: BoxFit.cover,

                                           image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+list[index].profile_photo.toString(),),


                                         ),

                                       ),

                                     )
                                 ),
                               ),


                             ),
                           ),
                         ),
                       ),
                       SizedBox(width: 3,),
                      GestureDetector(
                        onTap: (){

                        },
                        child:Container(
                          height: 30,
                          child:Text(
                            list[index].usename.toString(),
                            style:TextStyle(color: Colors.white, fontSize: 13,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),



                     ],
                   ),

                     SizedBox(width: 2.5,),
                   ],
                 ),
               ),

           onLongPress: (){
            setState(() {
              if(!selectedIndexList.contains(index)) {

             ///   selectedIndexList.add(index);
                print("hhh");
                if(list[index].dlet==true){
                  showModalBottomSheet<String>(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext ctx) {
                      return Container(
                        height:160,

                        decoration: BoxDecoration(
                            color: Color.fromRGBO(15, 3, 50, 1.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20), topRight: Radius.circular(20))
                        ),

                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 350,
                                  child: Icon(
                                    Icons.arrow_drop_down, size: 40, color: Colors.white,),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Column(
                              children: [


                                InkWell(
                                    child: Center(
                                      child: Text("Delete comment",
                                        style: TextStyle(fontSize: 25, color: Colors.white),),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      //
                                      setState(() {
                                        list.removeAt(index);

                                        dlate_comment(_loadedPhotos[index]["id_comment"]);

                                      });
                                    }

                                ),


                                Divider(height: 15, color: Colors.white),
                                InkWell(
                                  child: Center(
                                    child: Text("Close",
                                      style: TextStyle(fontSize: 25, color: Colors.white),),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),

                                Divider(height: 15, color: Colors.white),
                              ],
                            ),


                          ],
                        ),

                      );
                    },
                  );



                }

              } else {
              //  button(index);

                selectedIndexList.remove(index);




                print("ccc");
              }
            });
           },
            subtitle:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  child:Text(
                    list[index].comment.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16,),
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  list[index].tiem.toString(),
                  style:TextStyle(color: Colors.white54, fontSize: 10),

                ),
              ],
            ),



          );
        });
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
