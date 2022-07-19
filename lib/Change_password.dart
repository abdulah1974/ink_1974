import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
class Change_password extends StatefulWidget {
  late String email;
  late String password;
  Change_password(this.email,this.password);

  @override
  State<Change_password> createState() => _Change_passwordState(email,password);
}

class _Change_passwordState extends State<Change_password> {
  late String email;
  late String password;

  _Change_passwordState(this.email, this.password);

  TextEditingController change_password = TextEditingController();
  TextEditingController change_password2 = TextEditingController();
  List change_passwordState = [];

  void change_passworde() async {
    var response = await http
        .get(Uri.parse(
        "http://192.168.100.42:2000/change_password?change_password=" +
            change_password.text + "&email=" + email + "&password=" +
            password),);

    var json = jsonDecode(response.body);


    setState(() {
      change_passwordState = json;
    });
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _counter;

  void logout() {
    _counter = _prefs.then((SharedPreferences prefs) {
      //  print("c:"+ prefs.getInt('Email').toString());
      return prefs.remove("Email").toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(email);
    print(password);
  }

  bool bol = true;
  String _name = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 20,
            //     highlightColor: Colors.transparent,
            //     splashColor: Colors.transparent,
            icon: Icon(Icons.arrow_back, size: 30), onPressed: () {
            Navigator.pop(context);
          },),
          actions: [
             IconButton(
              splashRadius: 20,
              //     highlightColor: Colors.transparent,
              //     splashColor: Colors.transparent,
              icon: Icon(Icons.where_to_vote, size: 30), onPressed: () {


                if (change_password.text== change_password2.text&&change_password.text.length>=7&&change_password2.text.length>=7) {

                    print("yes");
                    Navigator.pop(context);



                  /*
              change_passworde();
              logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MyApp(),
                ),
                    (route) => false,
              );

               */
                }else{
                  Flushbar(
                    margin: EdgeInsets.all(50),
                    borderRadius: BorderRadius.circular(8),
                    message:'Make sure the password matches',
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ).show(context);


              }
            },),
          ],
          backgroundColor: Color.fromRGBO(1, 4, 30, 1),
          title: Text("Change password"),
        ),
        body: Center(
          child:Card(
            shadowColor: Colors.white,
            semanticContainer: true,


            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              height: 210,
              width: 350,
             child: Center(
               child:Column(
                 children: [
                   SizedBox(height: 35,),
                   Container(

                     child: TextFormField(
                       controller: change_password2,
                       cursorColor: Colors.black,

                       ///  onChanged: (text) => setState(() => text),
                       //  initialValue: pip[0]["username"],
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                       ),
                       decoration: InputDecoration(
                         floatingLabelBehavior: FloatingLabelBehavior.always,
                         labelStyle: TextStyle(
                             fontWeight: FontWeight.bold,
                             color: Colors.black),

                         hintText: 'New password',
                         contentPadding: EdgeInsets.fromLTRB(
                             20.0, 3.0, 23.0, 12.0),
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(8.0)),

                         ///  errorText: _errorText,
                         focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10.0),
                             borderSide: BorderSide(

                               color: Colors.black,
                               width: 3,
                             )
                         ),

                       ),
                       onChanged: (v) {
                         if (change_password.text == change_password2.text) {
                           bol = false;
                         }
                       },
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                       keyboardType: TextInputType.text,

                       /// validator: (val) => val!.length < 6 ? 'Password too short.' : null,
                       validator: (text) {
                         if (text == null || text.isEmpty) {
                           return 'Can\'t be empty';
                         }
                         if (text.length < 7) {
                           return 'Too short';
                         }
                         return null;
                       },


                     ),
                     width: 300,

                   ),
                   SizedBox(height: 35,),
                   Container(
                     child: TextFormField(
                       cursorColor: Colors.black,
                       controller: change_password,

                       ///     initialValue: pip[0]["bio"],

                       style: TextStyle(
                         fontWeight: FontWeight.bold,


                       ),
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                       keyboardType: TextInputType.text,

                       /// validator: (val) => val!.length < 6 ? 'Password too short.' : null,
                       validator: (text) {
                         if (text == null || text.isEmpty) {
                           return 'Can\'t be empty';
                         } else {

                         }
                         if (text.length < 7) {
                           return 'Too short';
                         }
                         return  null;
                       },
                       decoration: InputDecoration(


                         labelStyle: TextStyle(
                             fontWeight: FontWeight.bold,
                             color: Colors.black),

                         hintText: 'Confirm the password',
                         contentPadding: EdgeInsets.fromLTRB(
                             20.0, 3.0, 23.0, 12.0),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(8.0),


                         ),

                         focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10.0),
                             borderSide: BorderSide(
                               color: Colors.black,
                               width: 3,
                             )
                         ),
                       ),

                     ),
                     width: 300,

                   ),

                 ],
               ),
             ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
        )
    );
  }

}