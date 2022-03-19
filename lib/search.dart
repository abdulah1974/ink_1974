import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ink/search_user.dart';
import 'dart:io'; // for using HttpClient
import 'dart:convert'; // for using json.decode()
import 'package:like_button/like_button.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http2;
import 'package:http/http.dart' as http3;
import 'Photo.dart';
import 'comment.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
class search extends StatefulWidget {
  late int id;
  late String email;
  late String pas;

  search(int id2, String emails, String passwords){
    id=id2;
    email=emails;
    pas=passwords;
  }

  @override
  _accountState createState() => _accountState(id,email,pas);
}

class _accountState extends State<search> {
  late int id;
  late String email;
  late String pas;
  _accountState(int id2,String emails, String passwords){
    id=id2;
    email=emails;
    pas=passwords;
  }

 // "https://www.instagram.com/static/images/ico/favicon-192.png/68d99ba29cc8.png"
  late File _image = new File('your initial file');

 // List<String> _list=["h","https://www.instagram.com/static/images/ico/favicon-192.png/68d99ba29cc8.png"];



  List _loadedPhotos = [];
  List lis=[];

  late IconData icon;
  late IconData icon2;

  int _rateCount=0;
  void aa() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:3/trnd"));
    var jsondata = jsonDecode(response.body);

    setState(() {
      _loadedPhotos = jsondata;
      for(var a=0;a<_loadedPhotos.length;a++){
        print(_loadedPhotos[a]["id"]);
      }

    });
  }

  List<IconData> _icons = [
// The underscore declares a variable as private in dart.
    Icons.favorite,
    Icons.favorite_border_outlined,
  ];
  List<Color> _colors = [

    Colors.white,
    Colors.red,
  ];
  double _scaleFactor = 1.0;
  late Color color;
  late Color color2;
  late bool _isLiked=true;
  void getlike() async {
    var response = await http2
        .get(Uri.parse("http://192.168.100.42:2000/getlike2?post_id=3"),);

    var json = jsonDecode(response.body);

        setState(() {
        lis=json;
        if(lis!=null)
        {

          _isLiked=true;
          _rateCount += 1;
        print("c");

        }else {
          _isLiked=false;
          _rateCount =0;
        print("j");

        }
    });

  }







  ShakeAnimationController _shakeAnimationController =
  new ShakeAnimationController();



  void like() async {
    var response = await http3
        .get(Uri.parse("http://192.168.100.42:2000/like?post_id=3&email=ink@gmail.com&password=ink"),);

    var json = jsonDecode(response.body);


    setState(() {
      lis=json;

    });
  }
  @override
  void initState() {
    aa();
    getlike();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(1, 4, 30, 1),

          actions: [
            Container(
              width: 45,
              child: IconButton(icon:Icon(Icons.search,size: 30), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => search_user(id,email,pas)),
                );

              },)
            ),

          ],
          title: Text('Trinds'),
        ),
        body: ListView.builder(
            itemCount: _loadedPhotos.length,

            physics: BouncingScrollPhysics(),

            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Visibility(
                    visible:_loadedPhotos[index]["image"]==null?false:true,
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
                                  image: NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+_loadedPhotos[index]["profile_photo"]),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _loadedPhotos[index]["username"],
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(
                              width: 184,
                            ),
                            IconButton(
                              onPressed: () {
                               button();
                              },
                              icon: Icon(Icons.more_vert),
                              iconSize: 23,
                              color: Colors.white,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image.network(
                          "http://192.168.100.42:2020/get_trnd2_image?path="!=null?"http://192.168.100.42:2020/get_trnd2_image?path="+_loadedPhotos[index]["image"].toString():"",
                          fit: BoxFit.fill,
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
                                  Icons.favorite,
                                  color: isLiked ? Colors.red: Colors.white,
                                  size: 30,
                                );
                              },
                              size: 33,
                              likeCount: 0,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => comment(_loadedPhotos[index]["id"],id)),
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




                  Card(
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
                                  image:NetworkImage("http://192.168.100.42:2020/get_trnd2_image?path="+_loadedPhotos[index]["profile_photo"]),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _loadedPhotos[index]["username"],
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(
                              width: 220,
                            ),
                            Flexible(
                              child:IconButton(
                                onPressed: () {
                                  button();
                                },
                                icon: Icon(Icons.more_vert),
                                iconSize: 23,
                                color: Colors.white,
                              ),
                            )

                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(_loadedPhotos[index]['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            )),
                        Row(
                          children: [
                            ShakeAnimationWidget(

                              shakeAnimationController:_shakeAnimationController,
                              shakeAnimationType: ShakeAnimationType.RoateShake,
                              isForward: false,
                              shakeCount: 0,
                              shakeRange: 0.2,
                              child: Theme(
                                  data: ThemeData(splashColor: Color.fromRGBO(1, 4, 30, 1),),
                                  child: Material(
                                    elevation: 0,
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.hardEdge,
                                    color: Colors.transparent,
                                    child: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Icon(
                                          _isLiked?Icons.favorite:Icons.favorite_border_outlined,
                                          color: _isLiked ? Colors.red : Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      onTap: () {
                                        if(_isLiked){
                                          setState(() {
                                            _isLiked = false;
                                            like();

                                            _rateCount -= 1;
                                          });
                                        }else{
                                          setState(() {
                                            _isLiked = true;
                                            like();
                                            _rateCount += 1;
                                          });
                                        }
                                        if (_shakeAnimationController.animationRunging) {
                                          ///Stop jiggling animation
                                          _shakeAnimationController.stop();
                                        } else {

                                          _shakeAnimationController.start(shakeCount: 1);
                                        }
                                      },
                                    ),
                                  )),
                            ),

                            Text(_rateCount.toString(),style: TextStyle(color: Colors.white),),

                            SizedBox(
                              width: 15,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => comment(_loadedPhotos[index]["id"],id)),
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
                ],
              );
            }));
  }
  void button() {
    showModalBottomSheet<String>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled:true,
      builder: (BuildContext ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
              color:  Color.fromRGBO(1, 4, 30, 1),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),

          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 350,child: Icon(Icons.arrow_drop_down,size: 40,color: Colors.white,),)
                ],
              ),
              SizedBox(height: 30,),
              Column(
                children: [
                  InkWell(
                    child:Center(
                      child: Text("Report the post",style: TextStyle(fontSize: 25,color: Colors.white),),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  Divider(height: 15,color: Colors.white),
                  InkWell(
                      child: Center(
                        child: Text("Report account",style: TextStyle(fontSize: 25,color: Colors.white),),
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      }

                  ),


                  Divider(height: 15,color: Colors.white),
                  InkWell(
                    child:Center(
                      child: Text("Close",style: TextStyle(fontSize: 25,color: Colors.white),),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),

                  Divider(height: 15,color: Colors.white),
                ],
              ),


            ],
          ),

        );
      },
    );
  }

}

