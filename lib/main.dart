import 'package:flutter/material.dart';
import 'package:ink/singup.dart';

import 'Button.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static const Color black26 = Color(0x42000000);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      body: Center(

          child:ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Center(
                child: Text("WELCOME TO INK",style: TextStyle(color: Colors.white,height: 6,fontSize: 25, fontWeight: FontWeight.bold,),),
              ),
              SizedBox(height: 100,),
              Card(
                shadowColor: Colors.white,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child:Container(
                  height: 300,
                  width: 350,
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Container(
                        child:TextField(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),

                            hintText: 'Email',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 3.0, 23.0, 12.0),
                            border:OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),

                          ),
                        ),
                        width: 300,

                      ),
                      SizedBox(height: 30,),
                      Container(
                        child:TextField(
                          style: TextStyle(


                            fontWeight: FontWeight.bold,
                          ),

                          decoration: InputDecoration(

                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),

                            hintText: 'Password',
                            contentPadding: EdgeInsets.fromLTRB(20.0, 3.0, 23.0, 12.0),
                            border:OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),

                          ),
                        ),
                        width: 300,

                      ),
                      SizedBox(height: 30,),
                      MaterialButton(
                        height: 50,
                        minWidth: 120,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(12)),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Button(),
                            ),
                                (route) => false,
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        color: Color.fromRGBO(1, 4, 30, 1),
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        child: Text("SingUP"),
                        onTap: (){
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => singup(),
                            ),
                                (route) => false,
                          );
                        },
                      )
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
            ],
          )
      ),
    );
  }
}