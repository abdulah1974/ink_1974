import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http3;
import 'package:ink/model_acont/model.dart';
import 'package:ink/models/model.dart';
import 'Following.dart';
import 'comment.dart';
import 'edit_profile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:like_button/like_button.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

import 'package:shimmer/shimmer.dart';

import 'number of followrs.dart';
class account extends StatefulWidget {
  const account({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  List numbers = [1.4];

  late File _image = new File('your initial file');
  int _rateCount=0;
  late bool _isLiked=true;

  final picker = ImagePicker();
  ShakeAnimationController _shakeAnimationController =
  new ShakeAnimationController();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  bool showImageWidget = true;

  Widget lis = Center(
      child: SpinKitThreeBounce(
    color: Colors.white,
    size: 24.0,
  ));

  @override
  void initState() {
    super.initState();
    aa();
    pio();

    follower();
    Following();
    //_fetchData();
  }

  List pip = [];
  void pio() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/getpio?id=2"),);

    var json = jsonDecode(response.body);


    setState(() {
      pip = json;

    });
  }

  List follow = [];
  void follower() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/getfollower?fan_id=2"),);

    var json = jsonDecode(response.body);


    setState(() {
      follow = json;


    });
  }

  List Following2 = [];
  void   Following() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/getfollowing?account_id=2"),);

    var json = jsonDecode(response.body);


    setState(() {
      Following2 = json;

    });
  }
  List _loadedPhotos = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    const API_URL = 'https://jsonplaceholder.typicode.com/photos';

    HttpClient client = new HttpClient();
    client.autoUncompress = true;

    final HttpClientRequest request = await client.getUrl(Uri.parse(API_URL));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    final HttpClientResponse response = await request.close();

    final String content = await response.transform(utf8.decoder).join();
    final List data = json.decode(content);

    setState(() {
      _loadedPhotos = data;
      if(data.length>0)
        {
          setState(() {
            showImageWidget=true;
          });
        }
    });
  }
  bool isLoading = false;
  late bool _hasMore;
  final Set _saved = new Set();
  Future<bool> onLikeButtonTapped(bool isLiked, likes) async {
    {
      if (isLiked) {
       // like(likes);

        _rateCount -= 1;
      } else {
       // like(likes);
        _rateCount += 1;
      }
      return !isLiked;
    }
  }

  void aa() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/my_user_Post?id=2"));
    var jsondata = jsonDecode(response.body);

    setState(() {
      _loadedPhotos = jsondata;

    });

  }
  List _list=[];
  Future<bool> aa2()async{
    for(var i=_list.length;i<pip.length+20;i++)
    {
      Future.delayed(Duration(seconds: i+1),(){
        setState(() {
          _list.add(new modele_acont(username:pip[i]["username"],profile_photo:pip[i]["profile_photo"]));


        });
      });
    }
    return true;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(1, 4, 30, 1),
          title: Text("abdullah"),
          actions: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.add_circle_outlined),
                  onPressed: () {
                    print("hi");

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => edit_profile()),
                    );
                  },
                )),
          ],
        ),
        body: CustomScrollView(
          physics:BouncingScrollPhysics(),
          slivers: <Widget>[

            SliverAppBar(

              backgroundColor: Color.fromRGBO(1, 4, 30, 1),
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
              background: ListView.builder(
                  physics: BouncingScrollPhysics(),
                itemCount: pip.length,
                  itemBuilder: (_,index)
                  {
                    return  Column(
                      children: [
                        Container(
                          width: 110,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                    pip[index]["profile_photo"],),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(

                          child: Text(pip[index]["bio"],style: TextStyle(color: Colors.white,fontSize: 14),),
                        ),
                        SizedBox(height: 10,),

                        Row(
                          children: [
                            SizedBox(width: 20,),

                            Text(pip.length.toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                            SizedBox(width: 98,),
                            Text(follow.length.toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                            SizedBox(width: 92,),
                            Text(Following2.length.toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Text("Posts",style: TextStyle(color: Colors.white,fontSize: 14),),
                            SizedBox(width: 86,),
                            InkWell(
                              child:Text("Followers",style: TextStyle(color: Colors.white,fontSize: 14),),
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context) =>number()));
                              },
                            ),
                            SizedBox(width: 74,),
                            InkWell(
                              child:Text("Following",style: TextStyle(color: Colors.white,fontSize: 14),),
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)  =>following()));
                              },
                            ),

                          ],
                        )
                      ],
                    );
                  }

              )
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

                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            "http://192.168.100.42:2000/get_trnd2_image?path=" +
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
                                SizedBox(
                                  height: 10,
                                ),
                                Image.network(
                                  "http://192.168.100.42:2000/get_trnd2_image?path="!=
                                      null
                                      ? "http://192.168.100.42:2000/get_trnd2_image?path="+
                                      _loadedPhotos[index]["image"].toString()
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
                                          isLiked, _loadedPhotos[index]["id"],
                                        );
                                      }
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
                                            "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                                _loadedPhotos[index]["profile_photo"],),
                                        ),

                                      ),

                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _loadedPhotos[index]["account_name"],
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 220,

                                    ),
                                    Flexible(
                                      child: IconButton(
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
                childCount: _loadedPhotos.length,
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
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
              color:  Color.fromRGBO(15, 16, 68, 1.0),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),

          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 350,child: Icon(Icons.arrow_drop_down,size: 40,color: Colors.white,),)
                ],
              ),
              SizedBox(height: 25,),
              Column(
                children: [
                  InkWell(
                    child:Center(
                      child: Text("Delete  post",style: TextStyle(fontSize: 25,color: Colors.white),),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
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



