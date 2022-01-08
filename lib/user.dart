import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'comment.dart';
class user extends StatefulWidget {
  late String name;

  user(String n) {
    name = n;
  }

  @override
  _userState createState() => _userState(name);
}

class _userState extends State<user> {
  late String name;

  _userState(String n) {
    name = n;
  }

  String follow="follow";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),

      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[

            SliverAppBar(
              floating: true,
              flexibleSpace: FlexibleSpaceBar(

                background: Container(
                  color: Color.fromRGBO(1, 4, 30, 1),
                  child: Container(
                      color: Color.fromRGBO(1, 4, 30, 1),
                      padding: EdgeInsets.all(16.0),
                      child:Column(
                        children: [
                          SizedBox(height: 30,),
                          Text(name,style: TextStyle(color: Colors.white,fontSize: 25),),
                          SizedBox(height:20 ,),
                          Container(
                            width: 110,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: 220,
                            child: Text("hhhhghht5ff66kkl8hhyyhhhhghht5ff66kkl8hhyyhhhhghht5ff66kkl8hhyyhhhhghht5ff66kkl8hhyy",style: TextStyle(color: Colors.white,fontSize: 14),),
                          ),
                          SizedBox(height: 20,),
                          TextButton(
                            onPressed: () {
                           setState(() {
                             follow="Following";
                           });
                            },
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                    const BorderSide(
                                        width: 2, color: Colors.white)),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 25))),
                            child: Text(follow),
                          ),
                        ],
                      )),
                ),
              ),
              // title: const Text('Title'),

              expandedHeight: 320,
              forceElevated: innerBoxIsScrolled,

            ),
          ];
        },
        body: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Visibility(
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
                                  fit: BoxFit.fill,
                                  image: NetworkImage(""),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "abdullah",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(
                              width: 184,
                            ),
                            IconButton(
                              onPressed: () {
                                PopupMenuItem<int>(
                                  value: 0,
                                  child: Text(
                                    "Setting",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
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
                          "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg",
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
                                  color: isLiked ? Colors.red : Colors.white,
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
                                      builder: (context) => comment()),
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
                                image: NetworkImage(""),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "abdullah",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          SizedBox(
                            width: 184,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_vert),
                            iconSize: 23,
                            color: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("jjj",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                      Row(
                        children: [
                          LikeButton(
                            circleColor: CircleColor(
                                start: Color(0xff0e1313), end: Color(0xfff60e0e)),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff000000),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.favorite,
                                color: isLiked ? Colors.red : Colors.white,
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
                                    builder: (context) => comment()),
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
          },
        ),
      ),
    );
  }

}
