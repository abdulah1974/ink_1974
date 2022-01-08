import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<favorite> {
  late List<String> monthModel;
  final planetThumbnail = new   Container(
    width: 40.0,
    height: 40.0,

    decoration: BoxDecoration(
      shape: BoxShape.circle,

      image: DecorationImage(


        image:NetworkImage(
            "https://mhtwyat.com/wp-content/uploads/2021/03/%D8%A7%D8%AC%D9%85%D9%84-%D8%B5%D9%88%D8%B1-%D8%B9%D9%86-%D8%A7%D9%84%D8%A7%D9%85-2021-3.jpg",

        ),
      ),
    ),
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        centerTitle: true,
        title: Text('Expansion Tile Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),

        child: ListView.builder(
              itemCount: 10,
          scrollDirection: Axis.vertical,

          physics: BouncingScrollPhysics(),

          itemBuilder: (BuildContext context, int index) {
            return _buildPlayerModelList();
          },
        ),
      ),
    );
  }

  Widget _buildPlayerModelList() {
    return Card(
      color: Color.fromRGBO(1, 4, 30, 1),
      child: Column(
        children: [
          ExpansionTile(
            collapsedIconColor: Colors.white,
            leading: planetThumbnail,
            title: Text(
              "abdullah",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w900,color: Colors.white),
            ),
            subtitle:Text(
              "liked your post",
              style: TextStyle(fontSize:14, fontWeight: FontWeight.w100,color: Colors.white),
            ),
            children: <Widget>[
              ListTile(
                title: Text(
                  "hi",
                  style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),
                ),


              )
            ],
          ),
          ExpansionTile(
            collapsedIconColor: Colors.white,
            leading:planetThumbnail,
            title: Text(
              "abdullah",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w900,color: Colors.white),
            ),
            subtitle:Text(
              "liked your post",
              style: TextStyle(fontSize:14, fontWeight: FontWeight.w100,color: Colors.white),
            ),
            children: <Widget>[
              ListTile(
                title: Image.network("https://www.mexatk.com/wp-content/uploads/2015/03/%D8%B5%D9%88%D8%B1-%D8%AD%D8%B1%D9%81i.gif"),


              )
            ],
          ),
        ],
      )
    );
  }
}