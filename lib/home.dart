import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ink/comment.dart';
import 'package:ink/user.dart';
import 'package:like_button/like_button.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http2;
import 'package:http/http.dart' as http3;

class home extends StatefulWidget {
  late  int id;
  late String email;
  late String paswrd;
   home(int ids, String emails, String passwords){
     id=ids;
     email=emails;
     paswrd=passwords;
   }




  @override
  _homeState createState() => _homeState(id,email,paswrd);
}

class _homeState extends State<home> {
  late  int id;
  late String email;
  late String paswrd;
  _homeState(int ids,String emails,String passwords){
    id=ids;
    email=emails;
    paswrd=passwords;
  }

  late File _image = new File('your initial file');
  String name = "abdullah";
  List _loadedPhotos = [];
  List lis = [];


  bool isLoading = false;

  void aa() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/homepage3?user_id="+id.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      _loadedPhotos = jsondata;
    //  print("id:..."+_loadedPhotos[0]["id"]);
      isLoading=true;
    });
  }


  void like(var index) async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/like?post_id="+index.toString()+"&email="+email+"&password="+paswrd),);

    var json = jsonDecode(response.body);


    setState(() {
      lis = json;
    });
  }

  int _rateCount = 0;
  final snackBar = SnackBar(content: Text('Image is tapped.'));
  late OverlayEntry _popupDialog;

  void getlike6() async {
    var response = await http2
        .get(Uri.parse("http://192.168.100.42:2000/homepage3?user_id="+id.toString()),);

    var json = jsonDecode(response.body);

    setState(() {
      lis = json;
      if (lis != null) {
        _isLiked = true;
        _rateCount += 1;
        print("c");
      } else {
        _isLiked = false;
        _rateCount = 0;
        print("j");
      }
    });
  }

  Future<bool> onLikeButtonTapped(bool isLiked,  int lik) async {
    {

      if(isLiked){

        //  isLiked = false;

        like(lik);

        ///   _rateCount -= 1;

      }else{

        //  isLiked = true;
        like(lik);
        //  _rateCount += 1;

      }



      return !isLiked;
    }
  }
  List getfollowing2 = [];

  void getfollowing() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/allfollow?fan_id="+id.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      getfollowing2 = jsondata;


    });

  }
  late PageController controller;


  late AnimationController _controller;


  late bool _isLiked = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getlike6();
    aliiuser(id);
   aa();
   getfollowing();
    controller = PageController(viewportFraction: 0.9);

  // print(email);
  //  print(paswrd);
     vvv();
    super.initState();
  }


  void vvv()async{
 setState(() async {

   SharedPreferences prefs = await SharedPreferences.getInstance();
   String? Email = (prefs.getString('Email') ?? '');

   print("Email:"+Email.toString());

 });

  }




  List allusers = [];
  void aliiuser(int fanId) async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/alluser?fan_id="+fanId.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      allusers = jsondata;
      for(var i=0;i<allusers.length;i++)
        {
          print(allusers[i]["id"]);

        }

    });
  }

  bool _showPreview = false;
  List<int> selectedIndexList =[];
  List following = [];
  void follow(int i) async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/follow?email="+email+"&password="+paswrd+"&account_id="+i.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      following = jsondata;


    });

  }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          backgroundColor: Color.fromRGBO(1, 4, 30, 1),
          centerTitle: true,

          title: InkWell(
            onTap: () {
              scrollController.animateTo( //go to top of scroll
                  0, //scroll offset to go
                  duration: Duration(milliseconds: 500), //duration of scroll
                  curve: Curves.fastOutSlowIn //scroll type
              );
            },
            child: Text("Ink",),
          )
      ),
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),

      body:isLoading?ListView.builder(


          itemCount: _loadedPhotos.length,
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          reverse: false,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Visibility(
                  visible: _loadedPhotos[_loadedPhotos.length -1-index]["image"] == null ? false : true,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color.fromRGBO(1, 4, 30, 1),
                    child: Column(
                      children: [
                        GestureDetector(
                         onTap: (){
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => users(_loadedPhotos[_loadedPhotos.length -1-index]["user_id"],id,email,paswrd)),
                           );
                         },
                         child:Row(
                           children: [
                             Container(

                               child:Center(
                                 child:Container(

                                   child: Center(
                                     child:_loadedPhotos[_loadedPhotos.length -1-index]["profile_photo"]==null?

                                     Container(
                                       child: Center(child: Text(charAt(_loadedPhotos[_loadedPhotos.length -1-index]["account_name"].toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 25),),),
                                       width: 40,
                                       height: 40,

                                       decoration: BoxDecoration(
                                         color: Colors.blue,
                                         shape: BoxShape.circle,
                                         ),

                                     ):Center(

                                         child:Container(

                                           width: 40,
                                           height: 40,

                                           decoration: BoxDecoration(

                                             shape: BoxShape.circle,
                                             image: DecorationImage(

                                               fit: BoxFit.cover,

                                               image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+_loadedPhotos[_loadedPhotos.length -1-index]["profile_photo"],),


                                             ),

                                           ),

                                         )
                                     ),
                                   ),


                                 ),
                               ),
                             ),

                             Expanded(
                               child: Container(
                                 padding: EdgeInsets.all(10),
                                 child: Text(
                                   _loadedPhotos[_loadedPhotos.length -1-index]["account_name"],
                                   style:
                                   TextStyle(color: Colors.white, fontSize: 15),
                                 ),
                               ),
                             ),
                             Container(
                               width: 30,

                               child:IconButton(
                                 splashRadius: 20,
                                 onPressed: () {
                                   button();
                                 },
                                 icon: Icon(Icons.more_vert),
                                 iconSize: 23,
                                 color: Colors.white,
                               ),
                             ),

                           ],
                         ),
                       ),
                        SizedBox(
                          height: 10,
                        ),
                        Image.network(
                          "http://192.168.100.42:2000/get_trnd2_image?path="!=
                              null
                              ? "http://192.168.100.42:2000/get_trnd2_image?path="+
                              _loadedPhotos[_loadedPhotos.length -1-index]["image"].toString()
                              : "http://192.168.100.42:2000/get_trnd2_image?path=",
                          fit: BoxFit.cover,
                          height: 350,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Row(
                          children: [
                            /*
                            LikeButton(
                              circleColor: CircleColor(
                                  start: Color(0xff0e1313),
                                  end: Color(0xfff60e0e)),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff000000),
                              ),
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  _loadedPhotos[index]["IsLike"] != isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,

                                  color: _loadedPhotos[index]["IsLike"] != isLiked
                                      ? Colors.red
                                      : Colors.white,
                                  size: 30,
                                );
                              },

                              size: 33,
                              likeCount:_loadedPhotos[index]["likes"],

                              onTap: (isLiked) {
                                return onLikeButtonTapped(
                                  isLiked,_loadedPhotos[index]["id"],
                                );
                              },
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            IconButton(
                              highlightColor:Color.fromRGBO(1, 4, 30, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          comment(_loadedPhotos[index]["id"],id,email,paswrd)),
                                );

                              },
                              icon: Icon(
                                Icons.comment_outlined,
                                size: 30,
                              ),
                              color: Colors.white,
                            ),

                            */
                            number_like(_loadedPhotos[_loadedPhotos.length -1-index]["post_id"],id,email,paswrd,_loadedPhotos[_loadedPhotos.length -1-index]["IsLike"],_loadedPhotos[_loadedPhotos.length -1-index]["likes"]),
                          ],
                        ),

                        Row(
                          children:
                          [
                           // convertToAgo(now)

                            SizedBox(width: 5,height: 15,),

                            Text(
                              _loadedPhotos[_loadedPhotos.length -1-index]["time"],
                              style:TextStyle(color: Colors.white54, fontSize: 10),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                ),

              Visibility(
                visible:  _loadedPhotos[_loadedPhotos.length -1-index]["title"] == null ? false : true,
                child:Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color.fromRGBO(1, 4, 30, 1),
                child: Column(

                  children: [

                    Row(
                      children: [
                        Container(

                          child:Center(
                            child:Container(

                              child: Center(
                                child:_loadedPhotos[index]["profile_photo"]==null?

                                Container(
                                  child: Center(child: Text(charAt(_loadedPhotos[index]["account_name"].toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 25),),),
                                  width: 40,
                                  height: 40,

                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,


                                  ),

                                ):Center(

                                    child:Container(

                                      width: 40,
                                      height: 40,

                                      decoration: BoxDecoration(

                                        shape: BoxShape.circle,
                                        image: DecorationImage(

                                          fit: BoxFit.cover,

                                          image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+_loadedPhotos[index]["profile_photo"],),


                                        ),

                                      ),

                                    )
                                ),
                              ),


                            ),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => users(_loadedPhotos[_loadedPhotos.length -1-index]["user_id"],id,email,paswrd)),
                                );

                              },
                              child:Text(
                                _loadedPhotos[_loadedPhotos.length -1-index]["account_name"],
                                style:
                                TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            )
                          ),
                        ),


                        Container(
                          width: 30,

                          child:IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              button();
                            },
                            icon: Icon(Icons.more_vert),
                            iconSize: 23,
                            color: Colors.white,
                          ),
                        ),

                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Text(_loadedPhotos[_loadedPhotos.length -1-index]['title']==null?_loadedPhotos[_loadedPhotos.length -1-index]['title'].toString():_loadedPhotos[_loadedPhotos.length -1-index]['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        )),
                    Row(
                      children: [
                        /*
                            LikeButton(
                              circleColor: CircleColor(
                                  start: Color(0xff0e1313),
                                  end: Color(0xfff60e0e)),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff000000),
                              ),
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  _loadedPhotos[index]["IsLike"] != isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,

                                  color: _loadedPhotos[index]["IsLike"] != isLiked
                                      ? Colors.red
                                      : Colors.white,
                                  size: 30,
                                );
                              },

                              size: 33,
                              likeCount:_loadedPhotos[index]["likes"],

                              onTap: (isLiked) {
                                return onLikeButtonTapped(
                                  isLiked,_loadedPhotos[index]["id"],
                                );
                              },
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            IconButton(
                              highlightColor:Color.fromRGBO(1, 4, 30, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          comment(_loadedPhotos[index]["id"],id,email,paswrd)),
                                );

                              },
                              icon: Icon(
                                Icons.comment_outlined,
                                size: 30,
                              ),
                              color: Colors.white,
                            ),

                            */
                        number_like(_loadedPhotos[_loadedPhotos.length -1-index]["post_id"],id,email,paswrd,_loadedPhotos[_loadedPhotos.length -1-index]["IsLike"],_loadedPhotos[_loadedPhotos.length -1-index]["likes"]),
                      ],
                    ),
                    Row(
                      children:
                      [
                        SizedBox(width: 5,height: 15,),
                      //  convertToAgo
                        
                        Text(
                          _loadedPhotos[_loadedPhotos.length -1-index]["time"],
                          style:TextStyle(color: Colors.white54, fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
              ),

              ],
            );
          }):Container(

        child:Padding(
          padding: EdgeInsets.all(20.0),

          child:PageView.builder(
              controller: controller,
              physics: BouncingScrollPhysics(),
            itemCount: allusers.length,
              itemBuilder: (context,index){
            return Stack(

              children: [
                Center(
                    child:ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  color:  Color.fromRGBO(15, 3, 50, 1.0),
                  width: 270,
                  height: 270,
                ),
                    ),
                ),

               Center(
                 child:Column(
                   children: [
                     SizedBox(height: 360,),
                     TextButton(

                       onPressed:(){
                         setState(() {




                           if (!selectedIndexList.contains(index)) {
                             selectedIndexList.add(index);
                             follow(allusers[index]["id"]);
                           } else {
                             selectedIndexList.remove(index);
                             follow(allusers[index]["id"]);

                           }


                         });
                       },
                       style: ButtonStyle(
                           side: MaterialStateProperty.all(allusers[index]["IsLike"]!=selectedIndexList.contains(index)?BorderSide(
                               width: 2, color:Colors.blue):BorderSide(
                               width: 2, color:Colors.white)),
                           foregroundColor:
                           MaterialStateProperty.all(allusers[index]["IsLike"]!=selectedIndexList.contains(index)?Colors.blue:Colors.white),
                           padding: MaterialStateProperty.all(
                               const EdgeInsets.symmetric(
                                   vertical: 5, horizontal: 10)),
                           textStyle: MaterialStateProperty.all(
                               const TextStyle(fontSize: 18))),


                       child: Text(allusers[index]["IsLike"]!=selectedIndexList.contains(index)?"Following":"Follow"),

                     ),
                   ],
                 )
               ),

               Center(
                 child: Text(allusers[index]["username"],style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
               ),

               Container(
                 height: 450,
                 child:Center(
                   child:Container(

                     child: Center(
                       child:allusers[index]["profile_photo"]==null?

                       Container(
                        child: Center(child: Text(charAt(allusers[index]["username"].toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),),
                         width: 95,
                         height: 95,

                         decoration: BoxDecoration(
                          color: Colors.blue,
                           shape: BoxShape.circle,


                         ),

                       ):Center(

                           child:Container(

                           width: 95,
                           height: 95,

                           decoration: BoxDecoration(

                             shape: BoxShape.circle,
                             image: DecorationImage(

                               fit: BoxFit.cover,

                               image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path=" +allusers[index]["profile_photo"],),


                             ),

                           ),

                         )
                       ),
                     ),


                   ),
                 ),
               ),


              ],
            );
          })
        )
      ),
    );

  }

  void button() {
    showModalBottomSheet<String>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.3,
          decoration: BoxDecoration(
              color: Color
                  .fromRGBO(15, 3,
                  50, 1.0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),

          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 350,
                    child: Icon(
                      Icons.arrow_drop_down, size: 40, color: Colors.white,),)
                ],
              ),
              SizedBox(height: 30,),
              Column(
                children: [
                  InkWell(
                    child: Center(
                      child: Text("Report the post",
                        style: TextStyle(fontSize: 25, color: Colors.white),),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Divider(height: 15, color: Colors.white),
                  InkWell(
                      child: Center(
                        child: Text("Report account",
                          style: TextStyle(fontSize: 25, color: Colors.white),),
                      ),
                      onTap: () {
                        Navigator.pop(context);
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
class number_like extends StatefulWidget {
  late int id;
  late int myid;
  late String email;
  late String pasword;
  late bool like;
  late int number_lik;
  number_like(int id2, int myids, String emails, String peas,bool liks,int number_like2){
    id=id2;
    myid=myids;
    email=emails;
    pasword=peas;
    like=liks;
    number_lik=number_like2;
  }

  @override
  State<number_like> createState() => _PostState(id,myid,email,pasword,like,number_lik);
}

class _PostState extends State<number_like> {
  late int id;
  late int myid;
  late String email;
  late String pasword;
  late bool like;
  late int number_lik;
  _PostState(int id2, int myids, String emails, String peas,bool liks,int number_like2){
    id=id2;
    myid=myids;
    email=emails;
    pasword=peas;
    like=liks;
    number_lik=number_like2;
  }

  var i = 0;
  bool likeee=false;
  List apilike=[];
  void likes(var index) async {
    var response = await http.get(Uri.parse("http://192.168.100.42:2000/like?post_id="+index.toString()+"&email="+email+"&password="+pasword));

    var jsondata = jsonDecode(response.body);

    setState(() {
      apilike = jsondata;
      print("hhh");
    });

  }

  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }

  String k_m_b_generator22(num) {
    if(num > 999 && num < 99999){
      return "${(num / 1000)}";
    }
    return num.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [

              IconButton(
                onPressed: (){

                  setState((){

                    if(like!=likeee) {

                      likeee=!likeee;
                      number_lik--;
                      likes(id);
                      print(id);
                    } else {
                      likeee=!likeee;
                      likes(id);
                      number_lik++;
                      print(id);


                    }

                  });

                },
                icon:likeee!=like?Icon(Icons.favorite,size: 30,color: Colors.red,):Icon(Icons.favorite_border,size: 30,color: Colors.white,),
                splashRadius: 0.1,
              ),
              IconButton(

                highlightColor:Color.fromRGBO(1, 4, 30, 1),
                onPressed: () {


                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>comment(id,myid,email,pasword)),

                  );


                },
                icon:const Icon(
                  Icons.comment_outlined,
                  size: 30,
                ),
                splashRadius: 0.5,
                color: Colors.white,
              ),
            ],
          ),

          Row(
            children: [
              SizedBox(width: 5,),
              Text(k_m_b_generator(number_lik),style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold )),
              SizedBox(width: 2,),
              Text("likes",style:const TextStyle(fontSize: 16,color: Colors.white,fontWeight:FontWeight.bold )),
            ],
          ),

        ],
      ),
    );
  }
}

