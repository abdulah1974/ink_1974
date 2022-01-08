import 'package:flutter/material.dart';
import 'package:ink/search_user.dart';
import 'dart:io'; // for using HttpClient
import 'dart:convert'; // for using json.decode()
import 'package:like_button/like_button.dart';
import 'package:http/http.dart' as http;
import 'Photo.dart';
import 'comment.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<search> {

 // "https://www.instagram.com/static/images/ico/favicon-192.png/68d99ba29cc8.png"
  late File _image = new File('your initial file');

 // List<String> _list=["h","https://www.instagram.com/static/images/ico/favicon-192.png/68d99ba29cc8.png"];



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


  @override
  void initState() {

    _fetchData();
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
                      builder: (context) => search_user()),
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
                    visible:_loadedPhotos[index]["thumbnailUrl"]==null?false:true,
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
                                  image: FileImage(_image),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "abdullah",
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
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
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
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
                ],
              );
            }));
  }
}
