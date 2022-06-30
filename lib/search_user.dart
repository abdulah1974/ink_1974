import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http3;
import 'package:ink/user.dart';

class search_user extends StatefulWidget {
  late int id;
  late String emails;
  late String paswrd;
  search_user(int id2, String email, String pas){
    id=id2;
    emails=email;
    paswrd=pas;
  }

  @override
  _search_userState createState() => _search_userState(id,emails,paswrd);
}

class _search_userState extends State<search_user> {
  late int id;
  late String emails;
  late String paswrd;
  _search_userState(int id2,String email, String pas)
  {
    id=id2;
    emails=email;
    paswrd=pas;
  }


  List results = [];

  List rows = [];
 late String query = "";
  late TextEditingController tc;

  @override
  void initState() {
    super.initState();
    tc = TextEditingController();
   print("_search:"+id.toString());


  }


  void search() async {
    var response = await http3.get(Uri.parse("http://192.168.100.42:2000/serch2?username="+tc.text+"&id="+id.toString()),);

    var json = jsonDecode(response.body);

    setState(() {
      rows = json;
      //  print(results[0]['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(

        backgroundColor:Color.fromRGBO(1, 4, 30, 1),
        leading: new Container(

          child: IconButton(
            splashRadius: 20.8,

            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        actions: [
          Container(

            width: 310,
            child:  TextField(
              autofocus: true,
              style: Theme.of(context).primaryTextTheme.button,
              decoration: InputDecoration(

                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(

                      color:Colors.transparent,
                      width: 3,
                    ),
                ),
                suffixIcon: Icon(Icons.search,color: Colors.white,),

                hintText: "Search",
                hintStyle: TextStyle( color: Colors.white),
              ),
              cursorColor: Colors.white,
              cursorWidth: 1,
              controller: tc,
              onChanged: (v) {
                query = v;
                setResults(query);
                search();
              },
            ),
          ),
        ],

      ),
      body: Container(
        color: Color.fromRGBO(1, 4, 30, 1),
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              children: [

                Container(
                  color:Color.fromRGBO(1, 4, 30, 1),
                  child: query.isEmpty
                      ?Center(

                    child: Text("Looking for people",style:TextStyle(color: Colors.white,height: 24,)),
                    )
                      : ListView.builder(
                    shrinkWrap: true,
                    itemCount: results.length,
                    itemBuilder: (con, ind) {
                      return   ListTile(
                         title:Row(
                           children: [
                             Container(

                               child:Center(
                                 child:Container(

                                   child: Center(
                                     child:results[ind]["profile_photo"]==null?

                                     Container(
                                       child: Center(child: Text(charAt(results[ind]["username"].toUpperCase(),0),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                       width: 38,
                                       height: 38,

                                       decoration: BoxDecoration(
                                         color: Colors.blue,
                                         shape: BoxShape.circle,


                                       ),

                                     ):Center(

                                         child:Container(
                                           width: 38,
                                           height: 38,
                                           decoration: BoxDecoration(

                                             shape: BoxShape.circle,
                                             image: DecorationImage(

                                               fit: BoxFit.cover,

                                               image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+results[ind]["profile_photo"],),


                                             ),

                                           ),

                                         )
                                     ),
                                   ),


                                 ),
                               ),
                             ),
                             SizedBox(width: 3,),
                             Text(results[ind]['username'],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                           ],
                         ),

                        onTap: () {
                          setState(() {
                           // tc.text = results[ind]['username'];
                            query = results[ind]['username'];
                            setResults(query);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => users(results[ind]["id"],id,emails,paswrd)),
                            );



                          });
                        },

                      );



                    },
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  void setResults(String query) {
    results = rows
        .where((elem) =>elem['username']
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();


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




