import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ink/user_model.dart';
import 'package:like_button/like_button.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'comment.dart';
import 'package:http/http.dart' as http3;
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
class user extends StatefulWidget {
  late int id;
  late int myid;
  late String emails;
  late String peas;
  user(int n,int x, String email,String paswrd) {
    id = n;
    myid=x;
    emails=email;
    peas=paswrd;


  }

  @override
  _userState createState() => _userState(id,myid,emails,peas);
}

class _userState extends State<user> {
  late int id;
  late int myid;
  late String emails;
  late String peas;
  _userState(int n,int x, String email,String paswrd) {
    id = n;
    myid=x;
    emails=email;
    peas=paswrd;
  }




 late List<bool> foolow=[true];
  int _rateCount=0;
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



@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("mmmmmmm:"+myid.toString());
    print("cccccc:"+id.toString());
    pio();

     aa();
    follower();
    data();

    userfollow_or_unfollow();
}
  List _loadedPhotos = [];
  Future<bool> onLikeButtonTapped(bool isLiked,  var lik) async {
    {
      if (isLiked) {


        _rateCount -= 1;
        like(lik);
        print(_loadedPhotos[lik]["post_id"]);
      } else {
        like(lik);
        _rateCount += 1;

      }
      return !isLiked;
    }
  }

  void aa() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/userid?id="+id.toString()+"&myid="+myid.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      _loadedPhotos = jsondata;


    });

  }

  List following = [];
  List<int> selectedIndexList =[];
  void follow() async {

    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/follow?email="+emails+"&password="+peas+"&account_id="+id.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      following = jsondata;


    });

  }


  List follows = [];
///يجيب اليوزر نيم
  void follower() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/getfollowing6666?account_id="+myid.toString()),);

    var json = jsonDecode(response.body);


    setState(() {
      follows = json;

    });
  }

  List likes=[];
  void like(index) async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/like?post_id=$index&email=abdullah@gmail.com&password=ffff"),);

    var json = jsonDecode(response.body);


    setState(() {
      likes = json;
    });
  }
 List<use_model> _list=[];
  Future<bool> data()async{
    for(var i=_list.length;i<follow_unfollow.length+20;i++)
    {
      Future.delayed(Duration(seconds: i+1),(){
        setState(() {

          _list.add(new use_model(foloowing:follow_unfollow[i]["like"]));
        });
      });
    }
    return true;
  }


  var follow_unfollow=[];
  void userfollow_or_unfollow() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/userfollow_or_unfollow?fan_id=$myid&account_id="+id.toString()),);

    var json = jsonDecode(response.body);


    setState(() {
      follow_unfollow = json;
      print(follow_unfollow);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),

      body: CustomScrollView(
        physics: BouncingScrollPhysics(),

        slivers: <Widget>[
       for(var i=0;i<pip.length;i++)
         SliverAppBar(
        floating: true,
           leading: new Container(

             child: IconButton(
               splashRadius: 20.8,

               icon: new Icon(Icons.arrow_back),
               onPressed: () => Navigator.of(context).pop(),
             ),
           ),
        title:Text(pip[i]["username"] !=null ? pip[i]["username"] : "" ,style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        expandedHeight: 280,

         flexibleSpace: FlexibleSpaceBar(

          background:  Column(
            children: [
              SizedBox(height: 30,),

              SizedBox(height:50),
              Container(

                child:Center(
                  child:Container(

                    child: Center(
                      child:pip[i]["profile_photo"]==null?

                      Container(
                        child: Center(child: Text(charAt(pip[i]["username"].toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),),
                        width: 100,
                        height: 100,

                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,


                        ),

                      ):Center(

                          child:Container(

                            width: 100,
                            height: 100,

                            decoration: BoxDecoration(

                              shape: BoxShape.circle,
                              image: DecorationImage(

                                fit: BoxFit.cover,

                                image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+pip[i]["profile_photo"],),


                              ),

                            ),

                          )
                      ),
                    ),


                  ),
                ),
              ),
              /*
              Container(
                width: 110,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "http://192.168.100.42:2000/get_trnd2_image?path=" +
                          pip[i]["profile_photo"],),
                  ),
                ),
              ),

               */
              SizedBox(height: 10,),
              Visibility(
                 visible: pip[i]["bio"] == null ? false : true,
                  child: Center(

                    child: Text(pip[i]["bio"] !=null ? pip[i]["bio"] : "" ,style: TextStyle(color: Colors.white,fontSize: 14),),
                  ),
              ),
              SizedBox(height: 20,),
              for(var c=0;c<follow_unfollow.length;c++)
              TextButton(
                onPressed: () {
                  setState(() {
                    foolow[0]=!foolow[0];
                    follow();
                  });
                },
                style: ButtonStyle(
                    side: MaterialStateProperty.all(foolow[0]!=follow_unfollow[c]["like"]?BorderSide(
                        width: 2, color:Colors.white):BorderSide(
                        width: 2, color:Colors.blue)),

                    foregroundColor:MaterialStateProperty.all(foolow[0]!=follow_unfollow[c]["like"]?Colors.white:Colors.blue),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 20))),
                child: Text(foolow[0]!=follow_unfollow[c]["like"]?"Follow":"Following"),
              ),
            ],
          ),
        ),
      ),
          //3

          SliverList(

            delegate: SliverChildBuilderDelegate(

                  (_, int index) {
                ///    int rev=_loadedPhotos.length -1 -index;
                return ListTile(

                  title: Column(

                    children: [
                      Visibility(
                        visible: _loadedPhotos[_loadedPhotos.length - 1 -index]["image"] == null ? false : true,
                        child: Card(
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
                                            child: Center(child: Text(charAt(_loadedPhotos[index]["account_name"].toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 20),),),
                                            width: 110,
                                            height: 110,

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
                                  /*
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(

                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                              _loadedPhotos[_loadedPhotos.length -1 -index]["profile_photo"],),
                                      ),

                                    ),

                                  ),

                                   */

                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        _loadedPhotos[_loadedPhotos.length - 1 -index]["account_name"],
                                        style:
                                        TextStyle(color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),


                                  Container(
                                    width: 30,

                                    child:IconButton(
                                      splashRadius: 18,

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
                                "http://192.168.100.42:2000/get_trnd2_image?path="!=
                                    null
                                    ? "http://192.168.100.42:2000/get_trnd2_image?path="+
                                    _loadedPhotos[_loadedPhotos.length - 1 -index]["image"].toString()
                                    : "http://192.168.100.42:2000/get_trnd2_image?path=",
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
                                      likeCount: _loadedPhotos[index]["likes"],
                                      onTap: (isLiked) {

                                        return onLikeButtonTapped(
                                          isLiked,_loadedPhotos[index]["post_id"],
                                        );
                                      }
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
                                                comment(_loadedPhotos[index]["post_id"],id)),
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
                              Row(
                                children:
                                [
                                  SizedBox(width: 5),
                                  Text(
                                    _loadedPhotos[index]["time"],
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
                          margin: EdgeInsets.all(1),
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

                                    child:Center(
                                      child:Container(

                                        child: Center(
                                          child:_loadedPhotos[index]["profile_photo"]==null?

                                          Container(
                                            child: Center(child: Text(charAt(_loadedPhotos[index]["account_name"].toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
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
                                  /*
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(

                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                              _loadedPhotos[index]["profile_photo"],),
                                      ),

                                    ),

                                  ),

                                   */
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _loadedPhotos[index]["account_name"],
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 200,

                                  ),
                                  Flexible(
                                    child: IconButton(
                                      splashRadius: 18,

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
                                        isLiked, _loadedPhotos[index]["post_id"],
                                      );
                                    },

                                  ),

                                  // Text(_rateCount.toString(),style: TextStyle(color: Colors.white),),

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
                                                comment(_loadedPhotos[index]["post_id"],myid)),
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
                              Row(
                                children:
                                [
                                  SizedBox(width: 5),
                                  Text(
                                    _loadedPhotos[index]["time"],
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
                      ///    margin: EdgeInsets.all(10),
                        ),
                      ),

                    ],
                  ),
                );
              },
              childCount: _loadedPhotos.length,
            ),
          )
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
