import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'comment.dart';
import 'package:http/http.dart' as http3;
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
class user extends StatefulWidget {
  late int name;
  late int user_id;

  user(int n,int x) {
    name = n;
    user_id=x;
  }

  @override
  _userState createState() => _userState(name,user_id);
}

class _userState extends State<user> {
  late int name;
  late int user_id;

  _userState(int n,int x) {
    name = n;
    user_id=x;
  }




 late List<bool> foolow=[true];
  int _rateCount=0;
  List pip = [];
  void pio() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:3080/userbio?id="+name.toString()),);

    var json = jsonDecode(response.body);


    setState(() {
      pip = json;

    });
  }



@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(user_id);
    pio();

     aa();
     getfollowing();
  }
  List _loadedPhotos = [];
  Future<bool> onLikeButtonTapped(bool isLiked, index) async {
    {
      if (isLiked) {


        _rateCount -= 1;
        like(index);
      } else {
        like(likes);
        _rateCount += 1;

      }
      return !isLiked;
    }
  }
  void aa() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:3080/user?id="+name.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      _loadedPhotos = jsondata;

    });

  }

  List following = [];
  List<int> selectedIndexList =[];
  void follow() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:3080/follow?email=abdullah@gmail.com&password=abd&account_id="+user_id.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      following = jsondata;


    });

  }

  List getfollowing2 = [];

  void getfollowing() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:3080/usefollow?fan_id="+user_id.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      getfollowing2 = jsondata;


    });

  }
  List likes=[];
  void like(index) async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/like?post_id=$index&email=abdullah@gmail.com&password=abd"),);

    var json = jsonDecode(response.body);


    setState(() {
      likes = json;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),

      body: CustomScrollView(
        physics: BouncingScrollPhysics(),

        slivers: <Widget>[

          SliverAppBar(

            floating: true,
            title:Text(pip[0]["username"],style: TextStyle(color: Colors.white,fontSize: 25,)),
            backgroundColor: Color.fromRGBO(1, 4, 30, 1),
            expandedHeight: 280,
            flexibleSpace: FlexibleSpaceBar(

                background:  Column(
                  children: [
                    SizedBox(height: 30,),

                    SizedBox(height:50),
                    Container(
                      width: 110,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "http://192.168.100.42:3020/get_trnd2_image?path=" +
                                pip[0]["profile_photo"],),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 220,
                      child: Text(pip[0]["bio"],style: TextStyle(color: Colors.white,fontSize: 14),),
                    ),
                    SizedBox(height: 20,),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          foolow[0]=!foolow[0];
                         follow();
                        });
                      },
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(
                              const BorderSide(
                                  width: 2, color: Colors.white)),

                          foregroundColor:MaterialStateProperty.all(foolow[0]!=getfollowing2[0]["IsLike"]?Colors.white:Colors.red),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20)),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 25))),
                      child: Text(foolow[0]!=getfollowing2[0]["IsLike"]?"Follow":"Following"),
                    ),
                  ],
                ),
            ),
          ),
          //3
          SliverList(

            delegate: SliverChildBuilderDelegate(

                  (_, int index) {
                return ListTile(

                  title: Column(

                    children: [
                      Visibility(
                        visible: _loadedPhotos[index]["image"] == null ? false : true,
                        child: Card(
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

                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "http://192.168.100.42:3020/get_trnd2_image?path=" +
                                              pip[0]["profile_photo"],),
                                      ),

                                    ),

                                  ),

                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        pip[0]["username"],
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
                                    onTap: (isLiked) {
                                      return onLikeButtonTapped(
                                        isLiked, index,
                                      );
                                    },
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
                          margin: EdgeInsets.all(1),
                        ),
                      ),

                      Visibility(

                        visible:  _loadedPhotos[index]["title"] == null ? false : true,
                        child: Card(

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

                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "http://192.168.100.42:3020/get_trnd2_image?path=" +
                                              pip[0]["profile_photo"],),
                                      ),

                                    ),

                                  ),

                                  Expanded(
                                    child: Container(

                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        pip[0]["username"],
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
                  ),
                );
              },
              childCount:_loadedPhotos.length,
            ),
          ),
        ],
      ),
    );
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
