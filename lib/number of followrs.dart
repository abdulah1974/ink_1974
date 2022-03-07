import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ink/Following.dart';
import 'package:http/http.dart' as http3;
class number extends StatefulWidget {
  const number({Key? key}) : super(key: key);

  @override
  _numberState createState() => _numberState();
}

class _numberState extends State<number> {
  List follow = [];
  void follower() async {
    var response = await http3

        .get(Uri.parse(
        "http://192.168.100.42:3000/getfollower?fan_id=2"),);

    var json = jsonDecode(response.body);


    setState(() {
      follow = json;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    follower();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        title: Text("Followers"),
      ),
      body: Followers(),
    );
  }
  Widget Followers()
  {
    return follow.length>0? ListView.builder(

        itemCount: follow.length,
        physics: BouncingScrollPhysics(),
        itemBuilder:(BuildContext context, int index){
          return  Column(
            children: [
              SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  SizedBox(

                    width: 13,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          "http://192.168.100.42:3000/get_trnd2_image?path=" +
                              follow[index]["profile_photo"],),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),

                  Text(
                    follow[index]["username"],
                    style:
                    TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    width: 184,
                  ),


                ],
              ),

              Divider(height: 15),
            ],
          );
        }):Center(child: Text("Followers",style: TextStyle(color: Colors.white,fontSize: 25),),);
  }
}
