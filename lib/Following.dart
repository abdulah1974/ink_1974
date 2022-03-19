import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http3;
class following extends StatefulWidget {
  int? id;
  following(this.id);

  @override
  _numberState createState() => _numberState(id);
}

class _numberState extends State<following> {
  int? id;
  _numberState(this.id);
/// http://192.168.100.42:2000/getfollower?fan_id=1
  List follow = [];
  void follower() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/getfollower?fan_id="+id.toString()),);

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
        title: Text("Following"),
      ),
      body:Following()
    );
  }
  Widget Following()
  {
    return  follow.length>0?ListView.builder(

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

                    child:Center(
                      child:Container(

                        child: Center(
                          child:follow[index]["profile_photo"]==null?

                          Container(
                            child: Center(child: Text(charAt(follow[index]["username"].toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),),
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

                                    image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+follow[index]["profile_photo"],),


                                  ),

                                ),

                              )
                          ),
                        ),


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
        }):Center(child: Text("Following",style: TextStyle(color: Colors.white,fontSize: 25),),);
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
