import 'package:flutter/material.dart';
class about_ink extends StatefulWidget {
  const about_ink({Key? key}) : super(key: key);

  @override
  State<about_ink> createState() => _about_inkState();
}

class _about_inkState extends State<about_ink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        title: Text("About ink",),

        leading: IconButton(
          splashRadius: 20,
          //     highlightColor: Colors.transparent,
          //     splashColor: Colors.transparent,
          icon: Icon(Icons.arrow_back, size: 30), onPressed: () {
          Navigator.pop(context);
        },),
      ),
      body: Container(
        width: double.infinity,
        color: Color.fromRGBO(1, 4, 30, 1),
        child: Column(
          children: [
           Image.asset("assets/inks.jpg",height: 200,width: 200,),
           Container(
             width: 350,
             child:Text("ink is a social networking service for sharing images And the texts can be viewed by friends and you can express your opinion completely freely. The service was established in 2022 by abdullah muthanna",style: TextStyle(fontSize: 16,color: Colors.white),),
           )
          ],
        ),
      ),
    );
  }
}
