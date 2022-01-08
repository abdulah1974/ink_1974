import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
class search_user extends StatefulWidget {
  const search_user({Key? key}) : super(key: key);

  @override
  _search_userState createState() => _search_userState();
}

class _search_userState extends State<search_user> {
  TextEditingController _textController = TextEditingController();

  static List<String> mainDataList = [
  "Apple",
  "Apricot",
  "Banana",
  "Blackberry",
  "Coconut",
  "Date",
  "Fig",
  "Gooseberry",
  "Grapes",
  "Lemon",
  "Litchi",
  "Mango",
  "Orange",
  "Papaya",
  "Peach",
  "Pineapple",
  "Pomegranate",
  "Starfruit"
];
  List<String> newDataList = List.from(mainDataList);

  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        title: Text("Search"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              cursorColor: Colors.white,
              controller: _textController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Search Here...',
              ),
              onChanged: onItemChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: newDataList.length,
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
                            width: 10,

                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage("https://www.instagram.com/static/images/ico/favicon-192.png/68d99ba29cc8.png"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            newDataList[index],
                            style:
                            TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          SizedBox(
                            width: 184,
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),

                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}