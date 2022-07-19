import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ink/model_comment.dart';
import 'package:ink/user.dart';
import 'user.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:http/http.dart' as http3;
import 'package:http/http.dart' as http4;
import 'package:http/http.dart' as http2;
import 'package:linkfy_text/linkfy_text.dart';
class comment extends StatefulWidget {
 late int id;
 late int myid;
 late String email;
 late String pasword;
 comment(int id2, int myids, String emails, String peas){
   id=id2;
   myid=myids;
   email=emails;
   pasword=peas;

 }

  @override
  _commentState createState() => _commentState(id,myid,email,pasword);

}



class _commentState extends State<comment> {

  late int id;
  late int myid;
  late String email;
  late String pasword;
  _commentState(int id2,int myids, String emails, String peas){
    id=id2;
    myid=myids;
    email=emails;
    pasword=peas;
  }





  void comment1() async {
    var ur="http://192.168.100.42:2000/comment?id="+id.toString()+"&comment="+key.currentState!.controller!.text+"&user_id="+myid.toString();
    var response = await http
        .get(Uri.parse(ur));
    var jsondata = jsonDecode(response.body);


    setState(() {
      _loadedPhotos = jsondata;

    });
  }



  void addItemToList(){
    setState(() {
      //يضيف تعليق
  // comment1();


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
        list.add( new model_commdemt(usename:_loadedPhotos[i]["username"],comment:_loadedPhotos[i]["comment"],profile_photo: _loadedPhotos[i]["profile_photo"],tiem:_loadedPhotos[i]["time"],dlet:_loadedPhotos[i]["comsetmy"],id_comment:_loadedPhotos[i]["id_comment"],id: _loadedPhotos[i]["id"]));
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

    print("id_post:"+id.toString());
    print(email);
    print(pasword);


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
  List rows = [];
  void search() async {
    var response = await http3.get(Uri.parse("http://192.168.100.42:2000/serch_mention?username="+key.currentState!.controller!.markupText),);

    var json = jsonDecode(response.body);

    setState(() {
      rows = json;
      for(int s=0;s<rows.length;s++){




        // add_mention(post_id, myid);

      }




    });
  }
  List list_mention=[];
  void add_mention(var post_id,var user_id,) async {
    var response = await http3.get(Uri.parse("http://192.168.100.42:2000/add_mention?post_id=$post_id&user_id=$user_id&email=abdullah@gmail.com&password=123456"),);

    var json = jsonDecode(response.body);

    setState(() {

      list_mention = json;

    });
  }
  List _list=[];
  List dd=[];

  void search4(var i) async {
    var response = await http2.get(Uri.parse("http://192.168.100.42:2000/serch_mention2?username="+i+"&id="+myid.toString()),);

    var json = jsonDecode(response.body);

    setState(() {
      _list = json;
      for(int s=0;s<_list.length;s++){
      //  _string=_list[s]["username"].toString();
      //  dd.add(_string);


      }


    //  add_mention(xxx[i].toString(), 6);

    });
  }
  List pus=[];
  void push(var i) async {
    var response = await http4.get(Uri.parse("http://192.168.100.42:2000/serch_mention2?username="+i+"&id="+myid.toString()),);

    var json = jsonDecode(response.body);

    setState(() {
      pus = json;



      for(int s=0;s<pus.length;s++){

        print(pus[s]["id"]);

        // print(aa);
          if(pus[s]["myid"]!=true){
          //  Navigator.push(context,MaterialPageRoute(builder: (context)  =>   users(pus[s]["id"],myid,email,pasword)));
          }

      }
    });
  }
  void lllll(var i){
    dd.add(i);
  }
 // var nows = new DateTime.now();
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();
  String? search_;
  String? text;
  List _string=[""];
  List remiv_list=[];
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
            alignment: Alignment.bottomCenter,
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                for(int i=0;i<user.length;i++)
                Container(
                  padding: EdgeInsets.all(10),
                  child:user[i]["profile_photo"]==null?

                  Container(
                    child: Center(child: Text(charAt(user[i]["username"].toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
                    width: 35,
                    height: 35,

                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,

                    ),

                  ):Container(

                    child:Container(

                      width: 35,
                      height: 35,

                      decoration: BoxDecoration(

                        shape: BoxShape.circle,
                        image: DecorationImage(

                          fit: BoxFit.cover,

                          image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+user[i]["profile_photo"],),


                        ),

                      ),

                    ),
                  ),
                ),
                Expanded(

                  child: FlutterMentions(

                     minLines: 1,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,


                    suggestionPosition: SuggestionPosition.Top,

                    key: key,

                    onChanged: (v){
                      text=v;
                      if(key.currentState!.controller!.text==""){

                        remiv_list.clear();


                      }



                    },
                    onSearchChanged: (_,v){
                      for(int i=0;i<_string.length;i++){
                        _string[i]=v;

                      }


                      search4(v);





                      //dd.remove(v);

                      //  dd.removeWhere((item) => item == v);
                      search();

                      //  remiv_list.removeWhere((item) => item == v);


                    },

                    onMentionAdd: (s){
                      text=s["display"];
                      // _string=s["display"].toString();
                      search4(s["display"].toString());


                    },
                    /*
              onSuggestionVisibleChanged: (b){
                boolen=b;

                if(boolen){
                  if(lentgh > text!.length){

                      s.removeWhere((item) => item == _string);


                     print(search_);

                    print("delete");
                  }else{
                    print("add");
                  }
                }

                lentgh = text!.length;
              },
              */

                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Write comment...",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none
                    ),

                    mentions: [

                      Mention(


                          trigger: '@',
                          style:const TextStyle(
                            color: Colors.blue,
                          ),

                          data: [
                            for(int i=0;i<rows.length;i++)
                              {
                                'id': '61as61fsa',
                                'display':rows[i]["username"],
                                'full_name': rows[i]["bio"]??"",
                                "imag": rows[i]["profile_photo"]??"",

                              },
                          ],

                          matchAll: false,


                          suggestionBuilder: (data) {

                            search_==data["full_name"];


                            return Container(

                              color: Colors.black,
                              padding: EdgeInsets.all(10),
                              child: Row(

                                children: <Widget>[
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      "http://192.168.100.42:2000/get_trnd2_image?path=" +data["imag"],

                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(

                                    children: <Widget>[
                                      Text(data['full_name'],style: TextStyle(color: Colors.white),),
                                      Text(data['display'],style: TextStyle(color: Colors.white24),),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),


                    ],
                  ),

                ),


                /*
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

                   */



                Container(
                  padding: EdgeInsets.all(10),
                  height: 57,
                  width: 57,
                  child:FloatingActionButton(

                    onPressed: (){
                      ///

                      if(key.currentState!.controller!.text==""){

                      }else{
                        //يضيف تعليق
                        addItemToList();

                      }
                      setState(() {


                        if(key.currentState!.controller!.text==""){


                          print("nn");
                        }else{


                          DateTime now = DateTime.now();
                          // print(convertToAgo(now));

                          list.insert(0, model_commdemt(comment:key.currentState!.controller!.text,usename:user[0]["username"],profile_photo:user[0]["profile_photo"],tiem:convertToAgo(now)));


                          key.currentState!.controller!.clear();


                          //

                          for(int s=0;s<_string.length;s++){
                            dd.add(_string[s].toString());
                            // print(_string[s].toString());
                            // _string.removeWhere((element) => true);
                          }
                          var distinctIds = dd.toSet().toList();
                          for(int s=0;s<distinctIds.length;s++){

                            print("xxxxx:"+distinctIds[s].toString());
                            _string.removeWhere((element) => element==distinctIds[s].toString());
                            //  dd.clear();


                            //dd.clear();
                            // dd.remove("1bd");
                            //  push(distinctIds[s].toString());
                            //  search4(distinctIds[s].toString());
                            //   add_mention(id,distinctIds[s].toString());

                          }


                          // _string.remove(_string[i].toString());

                        }



                      });


                    },
                    child: Icon(Icons.send_outlined,color: Colors.black,size: 25),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                ),

              ],

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
               leading: GestureDetector(
                 behavior: HitTestBehavior.opaque,
                 onTap: () {
                   if(list[index].dlet!=true){
                     Navigator.push(context,MaterialPageRoute(builder: (context)  =>   users(_loadedPhotos[index]["id"],myid,email,pasword)));
                   }
                 },
                 child:  Container(

                   width: 48,
                   height: 48,
                   padding: EdgeInsets.symmetric(vertical: 4.0),
                   alignment: Alignment.center,
                   child: Container(

                     child:Center(
                       child:Container(

                         child: Center(
                           child:list[index].profile_photo==null?

                           Container(
                             child: Center(
                               child:Text(charAt(list[index].usename.toString().toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),

                             ),
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

                             ),

                           ),
                         ),


                       ),
                     ),
                   ),
                 ),
               ),
               title:Container(
                 child:Column(
                   children: [

                   Row(
                     children: [

                      GestureDetector(
                        onTap: (){
                          if(list[index].dlet!=true){
                            Navigator.push(context,MaterialPageRoute(builder: (context)  =>   users(_loadedPhotos[index]["id"],myid,email,pasword)));
                          }

                        },
                        child:Container(
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



           onLongPress:(){

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

                  child:LinkifyText(

                    list[index].comment.toString(),
                    textAlign: TextAlign.left,

                    linkTypes: const [
                      LinkType.email,
                      LinkType.url,
                      LinkType.hashTag,
                      LinkType.userTag
                    ],
                    linkStyle:const TextStyle(color: Colors.blue),
                    textStyle: TextStyle(color: Colors.white,fontSize: 16),
                    onTap: (link) {
                      var i=link.value!.substring(1);
                      push(i);

                    },
                    //   showSnackbar("link pressed: ${link.value!}"),
                  ),
                ),
                SizedBox(height: 1,),
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

