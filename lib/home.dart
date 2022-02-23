import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ink/comment.dart';
import 'package:ink/user.dart';
import 'package:like_button/like_button.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http2;
import 'package:http/http.dart' as http3;
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class home extends StatefulWidget {

  const home( {Key? key}) : super(key: key);



  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  late File _image = new File('your initial file');
  String name = "abdullah";
  List _loadedPhotos = [];
  List lis = [];


  bool isLoading = false;

  void aa() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:3080/homepage3?user_id=2"));
    var jsondata = jsonDecode(response.body);

    setState(() {
      _loadedPhotos = jsondata;
      // print(_loadedPhotos[0]["username"]);
      isLoading=true;
    });
  }


  void like(index) async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:3020/like?post_id=$index&email=abdullah@gmail.com&password=abd"),);

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
        .get(Uri.parse("http://192.168.100.42:3020/homepage3?user_id=2"),);

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

  Future<bool> onLikeButtonTapped(bool isLiked, likes) async {
    {
      if (isLiked) {
        like(likes);

        _rateCount -= 1;
      } else {
        like(likes);
        _rateCount += 1;
      }
      return !isLiked;
    }
  }
  List getfollowing2 = [];

  void getfollowing() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:3030/allfollow?fan_id=2"));
    var jsondata = jsonDecode(response.body);

    setState(() {
      getfollowing2 = jsondata;


    });

  }
  late PageController controller;


  late AnimationController _controller;
  ShakeAnimationController _shakeAnimationController = new ShakeAnimationController();

  late bool _isLiked = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getlike6();
   aliiuser(2);
    aa();
    getfollowing();
    controller = PageController(viewportFraction: 0.9);
    super.initState();
  }

  List allusers = [];
  void aliiuser(int fan_id) async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:3080/alluser?fan_id="+fan_id.toString()));
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
  void follow(var i) async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:3080/follow?email=abdullah@gmail.com&password=abd&account_id="+i.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      following = jsondata;


    });

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

          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Visibility(
                  visible: _loadedPhotos[index]["image"] == null ? false : true,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color.fromRGBO(1, 4, 30, 1),
                    child: Column(
                      children: [
                       InkWell(
                         onTap: (){
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => user(_loadedPhotos[index]["id"],_loadedPhotos[index]["user_id"])),
                           );
                         },
                         child:Row(
                           children: [
                             Container(
                               width: 40,
                               height: 40,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 image: DecorationImage(

                                   fit: BoxFit.fill,
                                   image: NetworkImage(
                                     "http://192.168.100.42:3020/get_trnd2_image?path=" +
                                         _loadedPhotos[index]["profile_photo"],),
                                 ),

                               ),

                             ),

                             Expanded(
                               child: Container(
                                 padding: EdgeInsets.all(10),
                                 child: Text(
                                   _loadedPhotos[index]["account_name"],
                                   style:
                                   TextStyle(color: Colors.white, fontSize: 15),
                                 ),
                               ),
                             ),


                             Container(
                               width: 30,

                               child:IconButton(
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
                          "http://192.168.100.42:3020/get_trnd2_image?path="!=
                              null
                              ? "http://192.168.100.42:3020/get_trnd2_image?path="+
                              _loadedPhotos[index]["image"].toString()
                              : "http://192.168.100.42:3020/get_trnd2_image?path=",
                          fit: BoxFit.cover,
                          height: 350,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Row(
                          children: [
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
                              likeCount:  _loadedPhotos[index]["likes"],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          comment(_loadedPhotos[index]["id"])),
                                );

                              },
                              icon: Icon(
                                Icons.comment_outlined,
                                size: 30,
                              ),
                              color: Colors.white,
                            ),
                          ],
                        ),

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
                visible:  _loadedPhotos[index]["title"] == null ? false : true,
                child:Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color.fromRGBO(1, 4, 30, 1),
                child: Column(

                  children: [

                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(

                              fit: BoxFit.fill,
                              image: NetworkImage(
                                "http://192.168.100.42:3020/get_trnd2_image?path=" +
                                    _loadedPhotos[index]["profile_photo"],),
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
                                  MaterialPageRoute(builder: (context) => user(_loadedPhotos[index]["id"],_loadedPhotos[index]["user_id"])),
                                );
                              },
                              child:Text(
                                _loadedPhotos[index]["account_name"],
                                style:
                                TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            )
                          ),
                        ),


                        Container(
                          width: 30,

                          child:IconButton(
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
                    Text(_loadedPhotos[index]['title']==null?_loadedPhotos[index]['title'].toString():_loadedPhotos[index]['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        )),
                    Row(
                      children: [
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
                          likeCount: _loadedPhotos[index]["likes"],
                          onTap: (isLiked) {
                            return onLikeButtonTapped(
                              isLiked, _loadedPhotos[index]["id"],
                            );
                          },

                        ),

                        // Text(_rateCount.toString(),style: TextStyle(color: Colors.white),),

                        SizedBox(
                          width: 15,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      comment(_loadedPhotos[index]["id"])),
                            );
                          },
                          icon: Icon(
                            Icons.comment_outlined,
                            size: 30,
                          ),
                          color: Colors.white,
                        ),
                      ],
                    ),
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
                  color: Colors.black26,
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
                           side: MaterialStateProperty.all(
                               const BorderSide(
                                   width: 1, color: Colors.white)),
                           foregroundColor:
                           MaterialStateProperty.all(selectedIndexList.contains(index)?Colors.red:Colors.white),
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
                 child: Text(allusers[index]["username"],style: TextStyle(color: Colors.white,fontSize: 17),),
               ),

               Container(
                 height: 450,
                 child:Center(
                   child:Container(
                     width: 100,
                     height: 100,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       image: DecorationImage(

                           fit: BoxFit.cover,
                           image: NetworkImage(
                             "http://192.168.100.42:3020/get_trnd2_image?path=" +
                                 allusers[index]["profile_photo"],),

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
              color: Color.fromRGBO(1, 4, 30, 1),
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
}