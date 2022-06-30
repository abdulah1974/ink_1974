import 'dart:convert';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:ink/singup.dart';
import 'package:http/http.dart' as http;
import 'Button.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('Email');
  var password = prefs.getString('password');
  var id=prefs.getInt("id");
  runApp(MaterialApp( builder: (_, child) => Portal(child: child!),  debugShowCheckedModeBanner: false,home:email==null? MyApp():Button(id!,email,password.toString()),));

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



  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _counter;

late int id;
List _login = [];
void login() async {
  var response = await http
      .get(Uri.parse("http://192.168.100.42:2000/login?email="+Email.text+"&password="+Password.text));
  var jsondata = jsonDecode(response.body);

  setState(() {
    _login = jsondata;
     print(_login[0]["id"]);
    for(var i=0;i<_login.length;i++)
    if (response.statusCode == 200) {
      if (response.body == _login[i]["id"]) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("err"),
        ));

      } else {

        _incrementCounter();
        id=_login[i]["id"];
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Button(_login[i]["id"],email,pass),
          ),
              (route) => false,
        );

      }
    }


  });
}

Future<void> _incrementCounter() async {
  final SharedPreferences prefs = await _prefs;

  setState(() {
    _counter = prefs.setString('Email', Email.text).then((bool success) {
      return _counter;
    });
    _counter = prefs.setString('password', Email.text).then((bool success) {
      return _counter;
    });
    _counter = prefs.setInt('id', id).then((bool success) {
      return _counter;
    });
  });
}



TextEditingController Email = TextEditingController();
TextEditingController Password = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();



   Email.text;
    Password.text;
  }

 late  String email= Email.text;
 late  String pass=   Password.text;



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      body:ListView.builder(

          itemCount:1,
          itemBuilder:(_,index){
            return Column(

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
                            controller:Email,
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
                            controller:Password,
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
                            /*
                            for(var i=0;i<_login.length;i++)
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Button(_login[i]["id"],email,pass),
                              ),
                                  (route) => false,
                            );

                             */
                            login();
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
            );
          }),
    );
  }
}