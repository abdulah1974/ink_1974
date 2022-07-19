import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
class help extends StatefulWidget {
  const help({Key? key}) : super(key: key);

  @override
  State<help> createState() => _helpState();
}

class _helpState extends State<help> {
  TextEditingController help = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        title: Text("Help",),

        leading: IconButton(
          splashRadius: 20,
          //     highlightColor: Colors.transparent,
          //     splashColor: Colors.transparent,
          icon: Icon(Icons.arrow_back, size: 30), onPressed: () {
          Navigator.pop(context);
        },),
        actions: [
          IconButton(
              onPressed: (){
                if(help.text!=""){

                  Navigator.pop(context);
                }else{
                  Flushbar(
                    margin: EdgeInsets.all(50),
                    borderRadius: BorderRadius.circular(8),
                    message:'Make sure the password matches',
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ).show(context);
                }


              },
            icon:Icon(Icons.add_task),
            splashRadius: 20,

          ),
        ],
      ),
      body:ListView(

          physics: BouncingScrollPhysics(),
        children: [
          Container(


            child: Center(
              child: Text("Hello dear, here you can report a problem with the ink application, and you can also put forward an idea We can refer the idea. If the idea is useful and benefits the community, we can add the feature to the application.Thank you.",style: TextStyle(color: Colors.white,fontSize: 16,)),
            ),

          ),

          SizedBox(height: 10,),
          TextField(
            controller: help,
            autofocus: true,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            cursorWidth: 1,
            keyboardType: TextInputType.multiline,
            maxLines: 7,
            decoration: InputDecoration(

              counterStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white24),
              hintText: "Ask the problem here...",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(

              //  borderSide:BorderSide(width: 1, color: Colors.white),

              ),



            ),

          ),


        ],
      ),
    );
  }
}
