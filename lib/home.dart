import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ink/comment.dart';
import 'package:ink/user.dart';
import 'package:like_button/like_button.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
class home extends StatefulWidget {

  const home( {Key? key}) : super(key: key);



  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  late File _image = new File('your initial file');
    String name="abdullah";


  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        centerTitle: true,

        title: InkWell(
          onTap: (){
            scrollController.animateTo( //go to top of scroll
                0,  //scroll offset to go
                duration: Duration(milliseconds: 500), //duration of scroll
                curve:Curves.fastOutSlowIn //scroll type
            );
          },
          child:Text("Ink", style: GoogleFonts.pacifico(fontSize: 25),),
        )
      ),
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      body: ListView.builder(
        controller: scrollController,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
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
                                image: NetworkImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                         InkWell(
                           child:Text(
                             "abdullah",
                             style:
                             TextStyle(color: Colors.white, fontSize: 15),
                           ),
                           onTap: (){
                             Navigator.push(context,MaterialPageRoute(builder: (context) => user(name)));
                           },
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
                        "https://www.instagram.com/static/images/ico/favicon-192.png/68d99ba29cc8.png",
                        fit: BoxFit.fill,
                      ),
                      Row(
                        children: [
                          LikeButton(

                            circleColor:
                            CircleColor(start: Color(0xff0e1313), end: Color(
                                0xfff60e0e)),
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
                          SizedBox(width: 15,),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => comment()),
                              );
                            },
                            icon: Icon(Icons.comment_outlined, size: 30,),

                            color: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            child:Text(
                              "abdullah",
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => user(name)));
                            },
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
                      Text(
                          "hi  in ink",
                          style: TextStyle(color: Colors.white, fontSize: 15,)
                      ),
                      Row(
                        children: [
                          LikeButton(
                            circleColor:
                            CircleColor(start: Color(0xff0e1313), end: Color(
                                0xfff60e0e)),
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
                          SizedBox(width: 15,),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => comment()),
                              );
                            },
                            icon: Icon(Icons.comment_outlined, size: 30,),
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
          }),
    );
  }

  void button() {
     showModalBottomSheet<String>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled:true,
      builder: (BuildContext ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),

          child: Column(
            children: [
               Row(
                 children: [
                  SizedBox(width: 350,child: Icon(Icons.arrow_drop_down,size: 40,),)
                 ],
               ),
             SizedBox(height: 30,),
             Column(
               children: [
                 ListView.builder(itemBuilder: (BuildContext context, int index){
                   return  Column(
                     children: [


                     ],
                   );
                 })

               ],
             )


            ],
          )
        );
      },
    );
  }
}