import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ink/Change_password.dart';
import 'package:ink/about_ink.dart';
import 'package:ink/help.dart';
import 'package:ink/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
class settings extends StatefulWidget {
  late String email;
  late String password;
  settings(this.email,this.password);

  @override
  State<settings> createState() => _settingsState(email,password);
}

class _settingsState extends State<settings> {


  late String email;
  late String password;
  _settingsState(this.email,this.password);
     bool isSwitched=false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _counter;
  void logout(){
    _counter = _prefs.then((SharedPreferences prefs) {
    //  print("c:"+ prefs.getInt('Email').toString());
      return prefs.remove("Email").toString();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(password);
    get_private();

  }
  List private = [];
  int prver_=0;
  void get_private() async {
    var response = await http
        .get(Uri.parse(
        "http://192.168.100.42:2000/get_private?email="+email+"&password="+password.toString()),);

    var json = jsonDecode(response.body);


    setState(() {
      private = json;
      for(int i=0;i<private.length;i++){
        if(private[i]["private"]!=null){
          isSwitched=true;
        }else{
          isSwitched=false;
        }

      }

    });
  }
  List private_pubilcs = [];
  void private_pubilc() async {
    var response = await http
        .get(Uri.parse(
        "http://192.168.100.42:2000/private?private=1&email="+email+"&password="+password.toString()),);

    var json = jsonDecode(response.body);

    setState(() {
      private_pubilcs = json;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      appBar: AppBar(
        leading:IconButton(
          splashRadius: 20,
          //     highlightColor: Colors.transparent,
          //     splashColor: Colors.transparent,
          icon:Icon(Icons.arrow_back,size: 30), onPressed: () {
          Navigator.pop(context);

        },),
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          SizedBox(height: 5,),
          Row(
         children: [
           Container(
             padding: EdgeInsets.only(left: 10),
             alignment: Alignment.topLeft,

             child: InkWell(
               splashColor: Colors.transparent,
               highlightColor: Colors.transparent,
               onTap: (){},
               child: Icon(Icons.account_circle_outlined,size: 23,color: Colors.white,),
             ),
           ),
           Container(
             padding: EdgeInsets.only(left: 10),
             alignment: Alignment.topLeft,
             child: InkWell(
               splashColor: Colors.transparent,
               highlightColor: Colors.transparent,
               onTap: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context) =>Change_password(email,password)));
               },
               child:  Text("Change password",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
             ),
           ),
         ],
        ),
          SizedBox(height: 25,),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,

                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){},
                  child: Icon(Icons.info_outline_rounded,size: 23,color: Colors.white,),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>about_ink()));
                  },
                  child:  Text("About ink",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){},
                  child: Icon(Icons.lock_outlined,size: 23,color: Colors.white,),
                ),
              ),

              Container(

                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){
                  },
                  child:  Text("Private",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 188),
                child:Switch(
                  inactiveTrackColor: Colors.white54,
                  activeTrackColor: Colors.blue,
                  activeColor: Colors.blue,
                  value:isSwitched,
                  onChanged: (value) {
                    setState(() {
                      print(isSwitched);
                      isSwitched = value;
                      private_pubilc();
                    });
                  },
                )
              ),

            ],
          ),

          SizedBox(height: 20,),
          Row(
            children: [
              Container(

                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,

                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){},
                  child: Icon(Icons.help_outline_outlined,size: 23,color: Colors.white,),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){

                    Navigator.push(context,MaterialPageRoute(builder: (context) =>help()));
                  },
                  child:  Text("Help",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
          SizedBox(height: 25,),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: InkWell(

                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){
                    setState(() {
                      print("hh");
                      logout_();

                    });

                  },
                  child: Icon(Icons.logout,size: 23,color: Colors.red,),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){
                    setState(() {
                    logout_();

                    });
                  },
                  child:  Text("Log out",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  void logout_(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor:Color.fromRGBO(15, 3, 50, 1.0),
        title: const Text('Log out of ink?',style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel',style: TextStyle(color: Colors.white),),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MyApp(),
                ),
                    (route) => false,
              );


              logout();
            },
            child: const Text('Log out',style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    );
  }
}
