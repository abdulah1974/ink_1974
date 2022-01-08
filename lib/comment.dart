
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class comment extends StatefulWidget {
  const comment({Key? key}) : super(key: key);

  @override
  _commentState createState() => _commentState();
}

class _commentState extends State<comment> {
  final List<String> names = <String>["منور","حلو","روعه"];
  TextEditingController nameController = TextEditingController();

  void addItemToList(){
    setState(() {
      names.insert(0,nameController.text);

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      appBar: AppBar(
        title:  Text("Comment"),
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      ),
      body:Stack(
        children: <Widget>[
          Container(
            height: 650,
            child: postComment(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(

              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 55,
              width: double.infinity,
              color:  Color.fromRGBO(1, 4, 30, 1),
              child: Row(
                children: <Widget>[


                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: nameController,
                      decoration: InputDecoration(

                          hintText: "Write Comment...",
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      addItemToList();
                      nameController.clear();
                    },
                    child: Icon(Icons.send,color: Colors.black,size: 23,),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget postComment()
       {
    return  ListView.builder(

        itemCount: names.length,
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
                    width: 40,
                    height: 40,
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
                    "abdullah",
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
              Text(
                  names[index],
                  style: TextStyle(color: Colors.white, fontSize: 15,)
              ),

            ],
          );
        });
  }


}
