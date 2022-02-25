import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:ink/Button.dart';
import 'package:ink/modeling.dart';
import 'package:ink/modeling2.dart';
import 'package:ink/models/joke.dart';
import 'package:ink/models/model.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http3;
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'JokeController.dart';
import 'model_acont/bool.dart';


class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<favorite> {
  late List<String> monthModel;

  List follow = [];

  void follower() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2001/getfollowing6666?account_id=2"),);

    var json = jsonDecode(response.body);


    setState(() {
      follow = json;

    });
  }






  List like=[];
  void getlike() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2001/getMylikes?user_id=2"),);
    var json = jsonDecode(response.body);
    setState(() {
      like = json;

      print("kk");
    });

  }

  late String amount;
  double get total {
    double amt = (amount as double);

    return (amt + (100) * amt);
  }
  final  controller = Get.put(JokeController());
  List<modeiling> _list=[];
  Future<bool> data1()async{
    for(var i=_list.length;i<like.length+20;i++)
    {
      Future.delayed(Duration(seconds: i+1),(){
        setState(() {
     ///   _list.add(new model(name: '', id: '', us: '', user:follow[i]["username"] , img: follow[i]["profile_photo"]));
        _list.add(new modeiling(username2:like[i]["username"],profile_photo2:like[i]["profile_photo"], IsLike: false,imageing:like[i]["image"],title:like[i]["title"] ));
        });
      });
    }
    return true;
  }
  Future<bool> data2()async{
    for(var i=_list.length;i<follow.length+20;i++)
    {
      Future.delayed(Duration(seconds: i+1),(){
        setState(() {
      _list.add(new modeiling(username:follow[i]["username"],profile_photo:follow[i]["profile_photo"],IsLike:follow[i]["like"],id:follow[i]["id"]));

           print(follow[i]["IsLike"]);
        });
      });
    }
    return true;
  }



  late Future futureAlbum;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
   getlike();
      data1();
    follower();
    data2();
  //  data1();



  }
  Widget lis = Center(
      child: SpinKitThreeBounce(
        color: Colors.white,
        size: 24.0,
      ));

  List<bool> selectedControl =  [];
  List<int> selectedIndexList =[];
  List followings=[];
  int? _destinationIndex;
  void following(var i) async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2001/follow?email=abdullah@gmail.com&password=abd&account_id="+i.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      followings = jsondata;



    });

  }
  late List<bool2> listing;
  late int selectedIndex;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Color.fromRGBO(1, 4, 30, 1),

      appBar: AppBar(

        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        centerTitle: true,
        title: Text('Notifications'),
      ),
      body: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 0.0),

        child:_buildPlayerModelList(),
      ),
    );
  }

  Widget _buildPlayerModelList() {

         return ListView.builder(
           itemCount:_list.length,
           scrollDirection: Axis.vertical,

           physics: BouncingScrollPhysics(),


           itemBuilder: (BuildContext context, int index) {

             return  Card(
               color: Color.fromRGBO(1, 4, 30, 1),
               child: Column(
                 children: [

                   Column(
                     children: [

                       Visibility(
                         visible: _list[index].username2!=null?true:false,
                         child:Row(
                           children: [
                             SizedBox(width: 15,),

                             Container(
                               width: 40,
                               height: 40,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 image: DecorationImage(
                                   fit: BoxFit.cover,
                                   image: NetworkImage(
                                     "http://192.168.100.42:2001/get_trnd2_image?path=" +
                                         _list[index].profile_photo2.toString(),),
                                 ),
                               ),
                             ),
                             SizedBox(width: 13,),

                             Column(
                               children: [
                                 ///  _list[i].id!=null?_list[i].id:""
                                 SizedBox(width: 83,
                                   child: Text(
                                     _list[index].username2.toString(),
                                     style: TextStyle(fontSize: 16,
                                       fontWeight: FontWeight.w900,
                                       color: Colors.white,

                                     ),

                                   ),
                                 ),


                                   Text(
                                     "There is a like",
                                     style: TextStyle(fontSize: 14,
                                         fontWeight: FontWeight.w100,
                                         color: Colors.white),
                                   ),









                               ],
                             ),


                             SizedBox(width: 165,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if(!selectedIndexList.contains(index)) {

                                    selectedIndexList.add(index);
                                    print("hhh");


                                  } else {

                                    selectedIndexList.remove(index);


                                    print("ccc");
                                  }
                                });
                              },
                              child:Icon(
                                selectedIndexList.contains(index)?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down_sharp,
                                size: 30,
                                color: Colors.white,
                              ),
                            )
                           ],
                         ),

                       ),


                       Visibility(
                         visible:selectedIndexList.contains(index)?true:false,
                         child: Column(
                           children: [
                             Visibility(
                               visible: _list[index].imageing!=null?true:false,
                                 child:Container(
                                   width: 700,
                                   height: 300,
                                   decoration: BoxDecoration(

                                     image: DecorationImage(

                                       image: NetworkImage(
                                         "http://192.168.100.42:2001/get_trnd2_image?path=" +
                                             _list[index].imageing.toString(),),
                                     ),
                                   ),
                                 ),
                             ),
                             Visibility(
                               visible: _list[index].title!=null?true:false,
                               child:Container(

                                 child:Text(_list[index].title.toString(),style: TextStyle(fontSize: 18,color: Colors.white),),

                               ),
                             ),
                           ],
                         )
                       ),
                       Visibility(
                         visible: _list[index].profile_photo!=null?true:false,
                         child:Row(
                           children: [
                             SizedBox(width: 15,),
                             Container(
                               width: 40,
                               height: 40,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 image: DecorationImage(
                                   fit: BoxFit.cover,
                                   image: NetworkImage(
                                     "http://192.168.100.42:2001/get_trnd2_image?path=" +
                                         _list[index].profile_photo.toString(),),
                                 ),
                               ),
                             ),
                             SizedBox(width: 13,),
                             Column(
                               children: [
                               ///  _list[i].id!=null?_list[i].id:""
                                 SizedBox(width: 100,
                                   child:Text(
                                     _list[index].username.toString(),
                                     style: TextStyle(fontSize: 16,
                                       fontWeight: FontWeight.w900,
                                       color: Colors.white,

                                     ),

                                   ),
                                 ),


                                 Row(
                                   children: [
                                     Text(
                                       "There is a Follow",
                                       style: TextStyle(fontSize: 14,
                                           fontWeight: FontWeight.w100,
                                           color: Colors.white),
                                     ),

                                   ],
                                 ),

                               ],
                             ),

                             _list[index].IsLike!=true?SizedBox(width: 95,):SizedBox(width: 75,),
                          Expanded(
                            child:TextButton(

                            onPressed: () {

                              setState(() {

                                _list[index].IsLike=!_list[index].IsLike;
                                following(_list[index].id);


                                /*
                                if(!selectedIndexList.contains(index)) {
                               /// following(_list[index].id);
                                  selectedIndexList.add(index);
                                  print("hhh");


                                } else {

                                 selectedIndexList.remove(index);
                                //  following(_list[index].id);
                                  print(_list[index].id);
                                  print("ccc");
                                }

                                 */



                              });
                            },
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(_list[index].IsLike!=true?BorderSide(
                                    width: 2, color:Colors.white):BorderSide(
                                    width: 2, color:Colors.blue)),

                                foregroundColor:MaterialStateProperty.all(_list[index].IsLike!=true?Colors.white:Colors.blue),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 20))),
                            child: Text(_list[index].IsLike!=true?"Follow":"Following"),
                          ),),




                           ],
                         ),
                       ),

                     ],
                   ),

                 ],
               ),
             );
           },
         );


  }


}



