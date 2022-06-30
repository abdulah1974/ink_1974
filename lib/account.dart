import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http3;
import 'package:ink/model_acont/model.dart';
import 'package:ink/settings.dart';
import 'Following.dart';
import 'comment.dart';
import 'edit_profile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_button/flutter_button.dart';
import 'package:readmore/readmore.dart';
import 'number of followrs.dart';
import 'package:scale_button/scale_button.dart';
class account extends StatefulWidget {
  late  int id;
  late String email;
  late String paswd;
  account(int ids, String emails, String passwords){
    id=ids;
    email=emails;
    paswd=passwords;
  }

  @override
  _accountState createState() => _accountState(id,email,paswd);
}

class _accountState extends State<account> {

  late  int id;
  late String email;
  late String paswd;
  _accountState(int ids,String emails, String passwords){
    id=ids;
    email=emails;
    paswd=passwords;
  }
  List numbers = [1.4];

  late File _image = new File('your initial file');
  int _rateCount=0;
  late bool _isLiked=true;

  final picker = ImagePicker();


  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  bool showImageWidget = true;

  Widget lis = Center(
      child: SpinKitThreeBounce(
    color: Colors.white,
    size: 24.0,
  ));

  @override
  void initState() {
    super.initState();
    aa();
    pio();

    Followers();
    followings();
    print(paswd);

    //_fetchData();
  }

  List pip = [];
  void pio() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/getpio?id="+id.toString()),);

    var json = jsonDecode(response.body);


    setState(() {
      pip = json;

    });
  }

  List follow = [];
  void followings() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/getfollower?fan_id="+id.toString()),);

    var json = jsonDecode(response.body);


    setState(() {
      follow = json;


    });
  }

  List Following2 = [];
  void   Followers() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/getfollowing6?account_id="+id.toString()),);

    var json = jsonDecode(response.body);


    setState(() {
      Following2 = json;

    });
  }
  List _loadedPhotos = [];


  bool isLoading = false;

  int count=0;
  /*
  Future<bool> onLikeButtonTapped(bool isLiked,  int lik) async {
    {

      if(isLiked){


          likes(lik);



      }else{



        likes(lik);



      }



      return !isLiked;
    }
  }

   */


  void aa() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/my_user_Post?id="+id.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      _loadedPhotos = jsondata;
      for(int i=0;i<_loadedPhotos.length;i++){
       //  s=_loadedPhotos[_loadedPhotos.length - 1 -i]["likes"];
      //  count=_loadedPhotos[i]["likes"];

      // buttonlikre=_loadedPhotos[i]["IsLike"];
      }
    });

  }

  List _list=[];
  Future<bool> aa2()async{
    for(var i=_list.length;i<pip.length+20;i++)
    {
      Future.delayed(Duration(seconds: i+1),(){
        setState(() {
          _list.add(new modele_acont(username:pip[i]["username"],profile_photo:pip[i]["profile_photo"]));


        });
      });
    }
    return true;
  }
  Future refreshList() async {


    await Future.delayed(const Duration(seconds: 1));
    setState(() {

      // get_private();

      // follower();

      print("refreshList");


    });

    return null;
  }


  List delets = [];
  void deletpost(index) async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/delete?post_id=$index&email=abdullah@gmail.com&password=123456"),);

    var json = jsonDecode(response.body);


    setState(() {
      delets = json;


    });
  }
late  List name=[];


  bool buttonlikre=false;

  List<int> selectedIndexList = [];
  var result;
      void  vv(){
        List products = [1,7,3];
         result = Map.fromIterable(products, key: (v) => v[0], value: (v) => v[1]);
        print(result);

      }


  late int myid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:const Color.fromRGBO(1, 4, 30, 1),
      appBar: AppBar(
        backgroundColor:const Color.fromRGBO(1, 4, 30, 1),

        title:Row(
          children: [
            for(var i=0;i<pip.length;i++)
              Text(pip[i]["username"] !=null ? pip[i]["username"] : "" ,style:const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                highlightColor:Color.fromRGBO(1, 4, 30, 1),
                icon: Icon(Icons.settings),
                onPressed: () {
                  print("hi");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => settings(email,paswd)),
                  );

                },
              )),
        ],



      ),

      body:_loadedPhotos.length>0?RefreshIndicator(
        onRefresh:refreshList,
        color: Colors.white,
        backgroundColor: const Color.fromRGBO(1, 4, 30, 1),
        child: Container(

          child:CustomScrollView(
            physics:const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    for(var v=0;v<pip.length;v++)
                      Container(

                        child:Center(
                          child:Container(

                            child: Center(
                              child:pip[v]["profile_photo"]==null?

                              Container(
                                child: Center(child: Text(charAt(pip[v]["username"], 0),style: const TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),),
                                width: 100,
                                height: 100,

                                decoration:const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,


                                ),

                              ):Center(

                                  child:Container(

                                    width: 100,
                                    height: 100,

                                    decoration: BoxDecoration(

                                      shape: BoxShape.circle,
                                      image: DecorationImage(

                                        fit: BoxFit.cover,

                                        image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+pip[v]["profile_photo"],),


                                      ),

                                    ),

                                  )
                              ),
                            ),


                          ),
                        ),
                      ),

                    const SizedBox(height: 10,),
                    for(var i=0;i<pip.length;i++)
                      Expanded(
                        child:Center(
                          child:ReadMoreText( pip[i]["bio"]!=null ? pip[i]["bio"] :"ً" ,style:const TextStyle(color: Colors.white,fontSize: 14),
                            trimLines: 5,
                            colorClickableText: Colors.white,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'show less',


                          ),

                        ),
                      ),

                    /*
                  Center(
                   child:Text(pip[i]["bio"]!=null ? pip[i]["bio"] : "" ,style: TextStyle(color: Colors.black,fontSize: 14),),
                  ),

                   */
                    const  SizedBox(height: 5,),
                    Expanded(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(child:Text(_loadedPhotos.length.toString(),style: TextStyle(color: Colors.white,fontSize: 15,), textAlign: TextAlign.center,),)  ,


                          ///Text(pip.length.toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                          Expanded(child:Text(Following2.length.toString(),style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.center),),


                          Expanded(child:Text(k_m_b_generator(follow.length),style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.center),),

                        ],
                      ),

                    ),
                    Expanded(

                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          const SizedBox(
                            child: Text("   Posts",style: TextStyle(color: Colors.white,fontSize: 14)),

                          ),

                          ///  SizedBox(width: 86,),
                          InkWell(
                            child:const Text("   Followers",style: TextStyle(color: Colors.white,fontSize: 14),),
                            onTap: (){
                               Navigator.push(context,MaterialPageRoute(builder: (context) =>number(id)));
                            },

                          ),
                          ///  SizedBox(width: 74,),
                          InkWell(
                            child:const Text("Following",style: TextStyle(color: Colors.white,fontSize: 14),),
                            onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)  =>followinges(id)));
                            },
                          ),

                        ],
                      ),

                    ),


                    const SizedBox(height: 10,),
                    Expanded(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(

                              onPressed: () {

                                setState(() {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => edit_profile(id,email,paswd)),
                            );


                                });
                              },
                              style: ButtonStyle(
                                  side: MaterialStateProperty.all(const BorderSide(
                                      width: 0.5, color:Colors.white)),

                                  foregroundColor:MaterialStateProperty.all(Colors.white),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 14)),
                                  textStyle: MaterialStateProperty.all(
                                      const TextStyle(fontSize: 20))),
                              child:const Text("Edit profile"),
                            ),
                          ],
                        )
                    ),



                  ],
                ),
              ),
              SliverList(
                delegate:SliverChildBuilderDelegate(

                      (BuildContext context, int index) {

                    return   _loadedPhotos[_loadedPhotos.length - 1 -index]["image"]!=null||_loadedPhotos[_loadedPhotos.length - 1 -index]["title"]!=null?ListTile(

                      title:Column(

                        children: [
                          Visibility(
                            visible: _loadedPhotos[_loadedPhotos.length - 1 -index]["image"] == null ? false : true,
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Row(
                                    children: [

                                      Container(

                                        child:Center(
                                          child:Container(

                                            child: Center(
                                              child:_loadedPhotos[index]["profile_photo"]==null?

                                              Container(
                                                child: Center(child: Text(charAt(_loadedPhotos[index]["account_name"], 0),style:const TextStyle(color: Colors.white,fontSize: 20),),),
                                                width: 110,
                                                height: 110,

                                                decoration:const BoxDecoration(
                                                  color: Colors.blue,
                                                  shape: BoxShape.circle,


                                                ),

                                              ):Center(

                                                  child:Container(

                                                    width: 40,
                                                    height: 40,

                                                    decoration: BoxDecoration(

                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(

                                                        fit: BoxFit.cover,

                                                        image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+_loadedPhotos[index]["profile_photo"],),


                                                      ),

                                                    ),

                                                  )
                                              ),
                                            ),


                                          ),
                                        ),
                                      ),
                                      /*
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(

                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                              _loadedPhotos[_loadedPhotos.length -1 -index]["profile_photo"],),
                                      ),

                                    ),

                                  ),

                                   */

                                      Expanded(
                                        child: Container(
                                          padding:const EdgeInsets.all(10),
                                          child: Text(
                                            _loadedPhotos[_loadedPhotos.length - 1 -index]["account_name"]!=null?_loadedPhotos[_loadedPhotos.length - 1 -index]["account_name"]:"",
                                            style:
                                            const TextStyle(color: Colors.white, fontSize: 15),
                                          ),
                                        ),
                                      ),


                                      Container(
                                        width: 30,

                                        child:IconButton(
                                          splashRadius: 18,

                                          onPressed: () {
                                                  showModalBottomSheet<String>(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder:
                                                        (BuildContext ctx) {
                                                      return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                        decoration: BoxDecoration(
                                                            color: Color
                                                                .fromRGBO(15, 3,
                                                                    50, 1.0),
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20))),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 350,
                                                                  child: Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    size: 40,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Column(
                                                              children: [
                                                                InkWell(
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Delete  post",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    deletpost(_loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"]);

                                                                    setState(
                                                                        () {
                                                                      _loadedPhotos.removeAt(_loadedPhotos.length -1-index);

                                                                    });
                                                                  },
                                                                ),
                                                                Divider(
                                                                    height: 15,
                                                                    color: Colors
                                                                        .white),
                                                                InkWell(
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Close",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                                Divider(
                                                                    height: 15,
                                                                    color: Colors
                                                                        .white),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                          icon:const Icon(Icons.more_vert),
                                          iconSize: 23,
                                          color: Colors.white,
                                        ),
                                      ),

                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Image.network(
                                    "http://192.168.100.42:2000/get_trnd2_image?path="!=
                                        null
                                        ? "http://192.168.100.42:2000/get_trnd2_image?path="+
                                        _loadedPhotos[_loadedPhotos.length - 1 -index]["image"].toString()
                                        : "http://192.168.100.42:2000/get_trnd2_image?path=",
                                    fit: BoxFit.cover,
                                    height: 350,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  Row(
                                    children: [
                                      /*
                                      LikeButton(
                                          circleColor:const CircleColor(
                                              start: Color(0xff0e1313),
                                              end: Color(0xfff60e0e)),
                                          bubblesColor:const BubblesColor(
                                            dotPrimaryColor: Color(0xff33b5e5),
                                            dotSecondaryColor: Color(0xff000000),
                                          ),

                                          likeBuilder: (bool isLiked) {



                                           print(isLiked);
                                            return Icon(

                                              _loadedPhotos[_loadedPhotos.length - 1 -index]["IsLike"] != isLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_border_outlined,
                                              color: _loadedPhotos[_loadedPhotos.length - 1 -index]["IsLike"] != isLiked
                                                  ? Colors.red
                                                  : Colors.white,
                                              size: 30,
                                            );
                                          },
                                          likeCount:_loadedPhotos[_loadedPhotos.length - 1 -index]["likes"],
                                          size: 33,
                                          onTap: (isLiked) async {




                                            return onLikeButtonTapped(
                                              isLiked,_loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"],
                                            );
                                          }
                                      ),

                                       */
                                     /*
                                      LikeButton(
                                        icon:Icons.favorite,
                                        deactiveColor:Colors.white,
                                        activeColor: Colors.red,
                                        deactiveSize: 30,
                                        activeSize: 35,
                                        curve: Curves.linear,
                                        onTap: () {

                                          setState((){

                                            if(!selectedIndexList.contains(index)==_loadedPhotos[_loadedPhotos.length - 1 -index]["IsLike"]) {
                                              print(s);
                                              s++;
                                             buttonlikre=!buttonlikre;
                                              selectedIndexList.remove(index);
                                            } else {
                                              selectedIndexList.add(index);
                                              buttonlikre=!buttonlikre;
                                              s--;
                                             print(s);


                                            }
                                          });

                                        },
                                      ),

                                      */
                                    /*
                                      ScaleButton(
                                        duration: Duration(milliseconds: 55),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child:buttonlikre?Icon(Icons.favorite,size: 30,color: Colors.red,):Icon(Icons.favorite_border,size: 30,color: Colors.white,),
                                        ),
                                        onTap: (){


                                          setState((){

                                            buttonlikre=!buttonlikre;

                                          });
                                        },
                                      ),

                                     */


                                      number_like(_loadedPhotos[_loadedPhotos.length -1-index]["post_id"],id,email,paswd,_loadedPhotos[_loadedPhotos.length -1-index]["IsLike"],_loadedPhotos[_loadedPhotos.length -1-index]["likes"]),

                                    ],
                                  ),

                               /*
                                  Row(
                                    children: [
                                      SizedBox(width: 5,),
                                      number_like(),
                                      SizedBox(width: 2,),
                                      Text("likes",style:const TextStyle(fontSize: 16,color: Colors.white,fontWeight:FontWeight.bold )),
                                    ],
                                  ),

                                */

                                  const  SizedBox(height: 5,),
                                  Row(
                                    children:
                                    [
                                      const  SizedBox(width: 5,),
                                      Text(
                                        _loadedPhotos[_loadedPhotos.length - 1 -index]["time"]!=null ?_loadedPhotos[_loadedPhotos.length - 1 -index]["time"]:"",
                                        style:TextStyle(color: Colors.white54, fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),

                                ],
                              ),
                            ),

                          ),

                          Visibility(
                            visible:  _loadedPhotos[_loadedPhotos.length - 1 -index]["title"] == null ? false : true,
                            child:Column(

                              children: [

                                Row(
                                  children: [
                                    Container(

                                      child:Center(
                                        child:Container(

                                          child: Center(
                                            child:_loadedPhotos[_loadedPhotos.length - 1 -index]["profile_photo"]==null?

                                            Container(
                                              child: Center(child: Text(charAt(_loadedPhotos[_loadedPhotos.length - 1 -index]["account_name"], 0),style:const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
                                              width: 40,
                                              height: 40,

                                              decoration:const BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle,


                                              ),

                                            ):Center(

                                                child:Container(

                                                  width: 40,
                                                  height: 40,

                                                  decoration: BoxDecoration(

                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(

                                                      fit: BoxFit.cover,

                                                      image:NetworkImage("http://192.168.100.42:2000/get_trnd2_image?path="+_loadedPhotos[_loadedPhotos.length - 1 -index]["profile_photo"],),


                                                    ),

                                                  ),

                                                )
                                            ),
                                          ),


                                        ),
                                      ),
                                    ),
                                    /*
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(

                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                              _loadedPhotos[index]["profile_photo"],),
                                      ),

                                    ),

                                  ),

                                   */
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child:Text(
                                        _loadedPhotos[_loadedPhotos.length - 1 -index]["account_name"]!=null?_loadedPhotos[_loadedPhotos.length - 1 -index]["account_name"]:"",
                                        style:
                                        TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
                                      ),),



                                    Container(
                                      width: 30,

                                      child:IconButton(
                                        splashRadius: 18,

                                        onPressed: () {
                                         print("k");
                                         showModalBottomSheet<String>(
                                           backgroundColor:
                                           Colors.transparent,
                                           context: context,
                                           isScrollControlled: true,
                                           builder:
                                               (BuildContext ctx) {
                                             return Container(
                                               height: MediaQuery.of(
                                                   context)
                                                   .size
                                                   .height *
                                                   0.2,
                                               decoration: BoxDecoration(
                                                   color: Color
                                                       .fromRGBO(15, 3,
                                                       50, 1.0),
                                                   borderRadius: BorderRadius.only(
                                                       topLeft: Radius
                                                           .circular(
                                                           20),
                                                       topRight: Radius
                                                           .circular(
                                                           20))),
                                               child: Column(
                                                 children: [
                                                   Row(
                                                     children: [
                                                       SizedBox(
                                                         width: 350,
                                                         child: Icon(
                                                           Icons
                                                               .arrow_drop_down,
                                                           size: 40,
                                                           color: Colors
                                                               .white,
                                                         ),
                                                       )
                                                     ],
                                                   ),
                                                   SizedBox(
                                                     height: 25,
                                                   ),
                                                   Column(
                                                     children: [
                                                       InkWell(
                                                         child: Center(
                                                           child: Text(
                                                             "Delete  post",
                                                             style: TextStyle(
                                                                 fontSize:
                                                                 25,
                                                                 color:
                                                                 Colors.white),
                                                           ),
                                                         ),
                                                         onTap: () {
                                                           Navigator.pop(
                                                               context);
                                                           deletpost(_loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"]);

                                                           setState(
                                                                   () {
                                                                 _loadedPhotos.removeAt(_loadedPhotos.length -1-index);

                                                               });
                                                         },
                                                       ),
                                                       Divider(
                                                           height: 15,
                                                           color: Colors
                                                               .white),
                                                       InkWell(
                                                         child: Center(
                                                           child: Text(
                                                             "Close",
                                                             style: TextStyle(
                                                                 fontSize:
                                                                 25,
                                                                 color:
                                                                 Colors.white),
                                                           ),
                                                         ),
                                                         onTap: () {
                                                           Navigator.pop(
                                                               context);
                                                         },
                                                       ),
                                                       Divider(
                                                           height: 15,
                                                           color: Colors
                                                               .white),
                                                     ],
                                                   ),
                                                 ],
                                               ),
                                             );
                                           },
                                         );
                                        },
                                        icon:const Icon(Icons.more_vert),
                                        iconSize: 23,
                                        color: Colors.white,
                                      ),
                                    ),

                                  ],
                                ),
                                const  SizedBox(
                                  height: 10,
                                ),

                                Text(_loadedPhotos[_loadedPhotos.length - 1 -index]['title']==null?_loadedPhotos[_loadedPhotos.length - 1 -index]['title'].toString():_loadedPhotos[_loadedPhotos.length - 1 -index]['title'],
                                    style:const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),

                                Row(
                                  children: [
                                    /*
                                    Button3D(
                                      style: StyleOf3dButton(
                                        backColor: Color.fromRGBO(1, 4, 30, 1),
                                        topColor:Color.fromRGBO(1, 4, 30, 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 50,
                                      width: 30,
                                      onPressed: () {
                                        setState(() {

                                          if(buttonlikre==true){
                                            count--;
                                            buttonlikre=!buttonlikre;

                                          }else{
                                            print("kk");
                                            count++;
                                            buttonlikre=!buttonlikre;
                                            print(like);
                                          }

                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        child:buttonlikre?Icon(Icons.favorite,color: Colors.red,size: 30,):Icon(Icons.favorite_border,color: Colors.white,size: 30,),
                                      ),
                                    ),

                                     */
                                  
                                    /*
                                    LikeButton(
                                      circleColor:const CircleColor(
                                          start: Color(0xff0e1313),
                                          end: Color(0xfff60e0e)),
                                      bubblesColor:const BubblesColor(
                                        dotPrimaryColor: Color(0xff33b5e5),
                                        dotSecondaryColor: Color(0xff000000),
                                      ),
                                      likeBuilder: (bool isLiked) {
                                        return Icon(
                                          _loadedPhotos[_loadedPhotos.length - 1 -index]["IsLike"] != isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,

                                          color: _loadedPhotos[_loadedPhotos.length - 1 -index]["IsLike"] != isLiked
                                              ? Colors.red
                                              : Colors.white,
                                          size: 30,
                                        );
                                      },

                                      size: 33,

                                      onTap: (isLiked) {

                                        return onLikeButtonTapped(
                                          isLiked, _loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"],
                                        );

                                      },

                                    ),

                                     */

                                    number_like(_loadedPhotos[_loadedPhotos.length -1-index]["post_id"],id,email,paswd,_loadedPhotos[_loadedPhotos.length -1-index]["IsLike"],_loadedPhotos[_loadedPhotos.length -1-index]["likes"]),
                                   /*

                                    const SizedBox(
                                      width: 6,
                                    ),
                                    IconButton(

                                      onPressed: () {


                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  comment(_loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"],id,email,paswd)),
                                        );
                                      },
                                      icon:const Icon(
                                        Icons.mode_comment_outlined,
                                        size: 30,
                                      ),
                                      color: Colors.white,
                                      splashRadius: 0.5,
                                    ),

                                    */


                                  ],
                                ),

                                const SizedBox(height: 5),
                                Row(
                                  children:
                                  [
                                    const SizedBox(width: 5),
                                    Text(
                                      _loadedPhotos[_loadedPhotos.length - 1 -index]["time"]!=null?_loadedPhotos[_loadedPhotos.length - 1 -index]["time"]:"",
                                      style:const TextStyle(color: Colors.white54, fontSize: 10),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ):Column(
                      children: [


                        const SizedBox(height: 100,),


                        Container(

                          child:const Center(child: Icon(Icons.no_photography_outlined,size: 120,color: Colors.white,),),

                        ),
                        Container(

                          child:const Center(child: Text("No Posts yet",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),

                        ),
                      ],
                    );
                  },
                  // Or, uncomment the following line:
                  childCount: _loadedPhotos.length,

                ),
              ),

            ],
          ),
        ),
      ):Center(
        child:CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          color: Colors.white,
          strokeWidth: 1,

        ),
      ),
    );
  }
  /*
  void button(index) {
    showModalBottomSheet<String>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled:true,
      builder: (BuildContext ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
              color:  Color.fromRGBO(15, 3, 50, 1.0),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),

          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 350,child: Icon(Icons.arrow_drop_down,size: 40,color: Colors.white,),)
                ],
              ),
              SizedBox(height: 25,),
              Column(
                children: [
                  InkWell(
                    child:Center(
                      child: Text("Delete  post",style: TextStyle(fontSize: 25,color: Colors.white),),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                      deletpost(index);
                    },
                  ),

                  Divider(height: 15,color: Colors.white),
                  InkWell(
                    child:Center(
                      child: Text("Close",style: TextStyle(fontSize: 25,color: Colors.white),),
                    ),
                    onTap: (){


                      Navigator.pop(context);



                    },
                  ),

                  Divider(height: 15,color: Colors.white),
                ],
              ),


            ],
          ),

        );
      },
    );

  }


   */
  String charAt(String subject, int position) {
    if (subject is! String ||
        subject.length <= position ||
        subject.length + position < 0) {
      return '';
    }

    int _realPosition = position < 0 ? subject.length + position : position;

    return subject[_realPosition];
  }
  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }


}
class number_like extends StatefulWidget {
  late int id;
  late int myid;
  late String email;
  late String pasword;
  late bool like;
  late int number_lik;
  number_like(int id2, int myids, String emails, String peas,bool liks,int number_like2){
    id=id2;
    myid=myids;
    email=emails;
    pasword=peas;
    like=liks;
    number_lik=number_like2;
  }

  @override
  State<number_like> createState() => _PostState(id,myid,email,pasword,like,number_lik);
}

class _PostState extends State<number_like> {
  late int id;
  late int myid;
  late String email;
  late String pasword;
  late bool like;
  late int number_lik;
  _PostState(int id2, int myids, String emails, String peas,bool liks,int number_like2){
    id=id2;
    myid=myids;
    email=emails;
    pasword=peas;
    like=liks;
    number_lik=number_like2;
  }

  var i = 0;
  bool likeee=false;
  List apilike=[];
  void likes(var index) async {
    var response = await http.get(Uri.parse("http://192.168.100.42:2000/like?post_id="+index.toString()+"&email="+email+"&password="+pasword));

    var jsondata = jsonDecode(response.body);

    setState(() {
      apilike = jsondata;
      print("hhh");
    });

  }
  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [

              IconButton(
                onPressed: (){

                  setState((){

                    if(like!=likeee) {

                      likeee=!likeee;
                      number_lik--;
                      likes(id);
                      print(id);
                    } else {
                      likeee=!likeee;
                      likes(id);
                      number_lik++;
                      print(id);


                    }

                  });

                },
                icon:likeee!=like?Icon(Icons.favorite,size: 30,color: Colors.red,):Icon(Icons.favorite_border,size: 30,color: Colors.white,),
                splashRadius: 0.1,
              ),
              IconButton(

                highlightColor:Color.fromRGBO(1, 4, 30, 1),
                onPressed: () {


                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>comment(id,myid,email,pasword)),

                  );


                },
                icon:const Icon(
                  Icons.comment_outlined,
                  size: 30,
                ),
                splashRadius: 0.5,
                color: Colors.white,
              ),
            ],
          ),

          Row(
            children: [
              SizedBox(width: 5,),
              Text(k_m_b_generator(number_lik),style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold )),
              SizedBox(width: 2,),
              Text("likes",style:const TextStyle(fontSize: 16,color: Colors.white,fontWeight:FontWeight.bold )),
            ],
          ),

        ],
      ),
    );
  }
}




