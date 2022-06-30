import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marquee/marquee.dart';
class follow_requests extends StatefulWidget {
  const follow_requests({Key? key}) : super(key: key);

  @override
  State<follow_requests> createState() => _follow_requestsState();
}

class _follow_requestsState extends State<follow_requests> {

  //جلب جميع طلبات الركوست
 List get_follow_requests = [];
 void follow_requests() async {
   var response = await http.get(Uri.parse("http://192.168.100.42:2000/get_follow_requests?account_id=23"));

   var jsondata = jsonDecode(response.body);

   setState(() {
     get_follow_requests = jsondata;
     for(int i=0;i<get_follow_requests.length;i++){

       print(get_follow_requests[i]["username"].toString().length);

     }

   });

 }

 String? pppp;
 //  جلب جميع طلبات الركوست +يستخدم في  الموفقه على الركوست+ والحذف +اجلب منه account_id
 List get_follow_requests__ = [];
 void follow_requests__() async {
   var response = await http.get(Uri.parse("http://192.168.100.42:2000/get_follow_requests?account_id=23"));

   var jsondata = jsonDecode(response.body);

   setState(() {
     get_follow_requests__ = jsondata;

   //  print(sss.length);


   });

 }
 //الموافقه على طلب الركوست
 List den_follow_requests = [];
 void den_follow_request(var i) async {
   var response = await http.get(Uri.parse("http://192.168.100.42:2000/den_follow_requests?account_id="+i.toString()+"&email=abdullah@gmail.com&password=123456"));

   var jsondata = jsonDecode(response.body);

   setState(() {
     den_follow_requests = jsondata;


   });

 }

 List delete_follow_requests_ = [];
 void delete_follow_requests(var i) async {
   var response = await http.get(Uri.parse("http://192.168.100.42:2000/delete_follow_requests?account_id="+i.toString()+"&email=abdullah@gmail.com&password=123456"));

   var jsondata = jsonDecode(response.body);

   setState(() {
     delete_follow_requests_ = jsondata;


   });

 }




 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    follow_requests();
    follow_requests__();



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          splashRadius: 20,
          //     highlightColor: Colors.transparent,
          //     splashColor: Colors.transparent,
          icon:Icon(Icons.arrow_back,size: 30), onPressed: () {
          Navigator.pop(context);

          },
        ),
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        title: Text("Follow requests"),
      ),

      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      body:  ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: get_follow_requests.length,
          itemBuilder:(_,index){
            return Column(
              children: [

               ListTile(
                 title: Container(
                   height: 20,
                   child:get_follow_requests[index]["username"].toString().length>21?Marquee(
                     text:get_follow_requests[index]["username"],
                     style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                     scrollAxis: Axis.horizontal,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     blankSpace: 20.0,
                     velocity: 100.0,
                     pauseAfterRound: Duration(seconds: 1),
                     startPadding: 10.0,
                     accelerationDuration:Duration(seconds: 1),
                     accelerationCurve: Curves.linear,
                     decelerationDuration: Duration(seconds: 1),
                     decelerationCurve: Curves.easeOut,
                   ):Text(get_follow_requests[index]["username"],style: TextStyle(color: Colors.white),),
                 ),
                 subtitle:Text(get_follow_requests[index]["time"],style: TextStyle(color: Colors.white60),),

                 leading:Container(
                   width: 40,
                   height: 40,
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     image: DecorationImage(
                       fit: BoxFit.cover,
                       image: NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+get_follow_requests[index]["profile_photo"]),

                     ),
                   ),
                 ),


                 trailing: Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                      IconButton(
                          splashRadius: 25,
                          onPressed: () {
                            setState(() {
                              get_follow_requests.removeAt(index);
                              delete_follow_requests(get_follow_requests__[index]["account_id"].toString());
                            });
                          },
                          icon: Icon(
                            Icons.clear_outlined,
                            color: Colors.white,
                          )),
                      IconButton(
                          splashRadius: 25,
                          onPressed: () {
                            setState(() {
                                get_follow_requests.removeAt(index);

                              den_follow_request(get_follow_requests__[index]["account_id"].toString());

                            });
                          },
                          icon: Icon(
                            Icons.done,
                            color: Colors.white,
                          )),

                    ],
                 ),


               ),


              ],
            );
          }),
    );
  }
}
