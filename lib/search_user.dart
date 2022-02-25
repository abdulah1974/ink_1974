import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:http/http.dart' as http3;
import 'package:ink/Button.dart';

import 'model_search.dart';
class search_user extends StatefulWidget {
  const search_user({Key? key}) : super(key: key);

  @override
  _search_userState createState() => _search_userState();
}

class _search_userState extends State<search_user> {

  List results = [];

  List rows = [];
  String query = '';
  late TextEditingController tc;

  @override
  void initState() {
    super.initState();
    tc = TextEditingController();


  }

  void search() async {
    var response = await http3.get(Uri.parse("http://192.168.100.42:2001/serch?username="+tc.text),);

    var json = jsonDecode(response.body);

    setState(() {
      rows = json;

    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(

        backgroundColor:Color.fromRGBO(1, 4, 30, 1),


        actions: [
          Container(

            width: 310,
            child:  TextField(
              style: Theme.of(context).primaryTextTheme.button,
              decoration: InputDecoration(



                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7))),

                suffixIcon: Icon(Icons.search),
                hintText: "Search",
                hintStyle: TextStyle( color: Colors.white),
              ),

              controller: tc,
              onChanged: (v) {
                setState(() {
                  query = v;
                  setResults(query);
                  search();
                });
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
                      return ListTile(
                        leading:Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage("http://192.168.100.42:2001/get_trnd2_image?path="+results[ind]["profile_photo"]),
                            ),
                          ),
                        ),
                        title: Text(results[ind]['username'],style: TextStyle(color: Colors.white),),
                        onTap: () {
                          setState(() {
                            tc.text = results[ind]['username'];
                            query = results[ind]['username'];
                            setResults(query);
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
}



