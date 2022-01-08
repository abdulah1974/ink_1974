import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'comment.dart';
import 'edit_profile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:like_button/like_button.dart';

class account extends StatefulWidget {
  const account({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  List numbers = [1.4];

  late File _image = new File('your initial file');

  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  Widget lis = Center(
      child: SpinKitThreeBounce(
    color: Colors.white,
    size: 24.0,
  ));

  @override
  void initState() {
    super.initState();
    aa();
    //_fetchData();
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
    });
  }

  late bool _hasMore;

  void aa() async {
    var response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var jsondata = jsonDecode(response.body);

    setState(() {
      _loadedPhotos = jsondata;
    });
    lis = ListView.builder(
        itemCount: _loadedPhotos.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
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
                                image: FileImage(_image),
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
                        _loadedPhotos[index]["thumbnailUrl"],
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
                              image: FileImage(_image),
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
                    Text(_loadedPhotos[index]['title'],
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
        });
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
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(

                  background: Container(

                    child: Container(

                      color: Color.fromRGBO(1, 4, 30, 1),
                      padding: EdgeInsets.all(16.0),
                      child:Column(
                        children: [
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
                          SizedBox(height: 10,),

                          Row(
                            children: [
                              SizedBox(width: 17,),
                              Text("10",style: TextStyle(color: Colors.white,fontSize: 20),),
                              SizedBox(width: 98,),
                              Text("100k",style: TextStyle(color: Colors.white,fontSize: 20),),
                              SizedBox(width: 92,),
                              Text("100k",style: TextStyle(color: Colors.white,fontSize: 20),),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 10,),
                              Text("Posts",style: TextStyle(color: Colors.white,fontSize: 14),),
                              SizedBox(width: 86,),
                              Text("Followers",style: TextStyle(color: Colors.white,fontSize: 14),),
                              SizedBox(width: 74,),
                              Text("Following",style: TextStyle(color: Colors.white,fontSize: 14),),
                            ],
                          )
                        ],
                      )
                    ),

                  ),
                ),
                // title: const Text('Title'),

                expandedHeight: 300,
                forceElevated: innerBoxIsScrolled,

              ),
            ];
          },
          body: lis,
        ),
    );
  }
}
