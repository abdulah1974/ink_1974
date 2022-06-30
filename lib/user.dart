import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ink/Following.dart';
import 'package:ink/number%20of%20followrs.dart';
import 'package:ink/user_model.dart';
import 'package:like_button/like_button.dart';
import 'comment.dart';
import 'package:http/http.dart' as http3;
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http2;
import 'package:readmore/readmore.dart';
class users extends StatefulWidget {
  late int id;
  late int myid;
  late String emails;
  late String peas;
  users(int n,int x, String email,String paswrd) {
    id = n;
    myid=x;
    emails=email;
    peas=paswrd;


  }


  @override
  _userState createState() => _userState(id,myid,emails,peas);
}

class _userState extends State<users> {
  late int id;
  late int myid;
  late String emails;
  late String peas;
    _userState(int n,int x, String email,String paswrd) {
    id = n;
    myid=x;
    emails=email;
    peas=paswrd;
  }




 late List<bool> foolow=[true];
  int _rateCount=0;
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



  void numFormatter(num) {
    if(num > 999 && num < 1000000){
      return (num/1000)+ 'K'; // convert to K for number from > 1000 < 1 million
    }else if(num > 1000000){
      return (num/1000000) + 'M'; // convert to M for number from > 1 million
    }else if(num < 900){
      return num; // if value < 1000, nothing to do
    }
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
  void initState() {
    // TODO: implement initState
    super.initState();
    print("mmmmmmm:"+emails.toString());
    print("cccccc:"+id.toString());
    print("peas:"+peas.toString());
    pio();
    int num = 1100;

    var myNumber = k_m_b_generator(num);

    print(myNumber);
     aa();
    follower();
    data();
    getFollowers();
    getfollowings();
    _requests();


    userfollow_or_unfollow();
}
  List _loadedPhotos = [];
  Future<bool> onLikeButtonTapped(bool isLiked,  int lik) async {
    {
      if (isLiked) {


        _rateCount -= 1;
        like(lik);
        print(_loadedPhotos[lik]["post_id"]);
      } else {
        like(lik);

        _rateCount += 1;

      }
      return !isLiked;
    }
  }

  void aa() async {
    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/userid?id="+id.toString()+"&myid="+myid.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      _loadedPhotos = jsondata;


    });

  }

  List following = [];
  List<int> selectedIndexList =[];
  void follow() async {

    var response = await http
        .get(Uri.parse("http://192.168.100.42:2000/follow?email="+emails+"&password="+peas+"&account_id="+id.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      following = jsondata;


    });

  }


  List follows = [];
///يجيب اليوزر نيم
  void follower() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/getfollowing6666?account_id="+myid.toString()),);

    var json = jsonDecode(response.body);


    setState(() {
      follows = json;

    });
  }

  List likes=[];
  void like(var index) async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/like?post_id="+index.toString()+"&email="+emails+"&password="+peas),);

    var json = jsonDecode(response.body);


    setState(() {
      likes = json;
    });
  }
 List<use_model> _list=[];
  Future<bool> data()async{
    for(var i=_list.length;i<follow_unfollow.length+20;i++)
    {
      Future.delayed(Duration(seconds: i+1),(){
        setState(() {

          _list.add(new use_model(foloowing:follow_unfollow[i]["like"]));
        });
      });
    }
    return true;
  }


  var follow_unfollow=[];
  void userfollow_or_unfollow() async {
    var response = await http3
        .get(Uri.parse(
        "http://192.168.100.42:2000/userfollow_or_unfollow?fan_id=$myid&account_id="+id.toString()),);

    var json = jsonDecode(response.body);


    setState(() {
      follow_unfollow = json;
      print(follow_unfollow);

    });
  }

  List getFollowing = [];
  void   getFollowers() async {
    var response = await http2
        .get(Uri.parse(
        "http://192.168.100.42:2000/getfollowing6?account_id="+id.toString()),);

    var json = jsonDecode(response.body);


    setState(() {
      getFollowing = json;

    });
  }
  List getfollowrs = [];
  void getfollowings() async {
    var response = await http2
        .get(Uri.parse(
        "http://192.168.100.42:2000/getfollower?fan_id="+id.toString()),);

    var json = jsonDecode(response.body);


    setState(() {
      getfollowrs = json;


    });
  }
   List _follow_requests =[];

  void follow_requests()async{
    var response = await http2.get(Uri.parse("http://192.168.100.42:2000/follow_requests?account_id=$id&email=$emails&password="+peas),);

    var json = jsonDecode(response.body);

    setState(() {
      _follow_requests = json;


    });
  }

 //يعرف اذا ضايفه في الركوست او لا
  List requests=[];
  void  _requests()async{
    var response = await http2.get(Uri.parse("http://192.168.100.42:2000/follow_true?fan_id=$myid&account_id="+id.toString()),);

    var json = jsonDecode(response.body);

    setState(() {
      requests = json;


    });
  }



  bool descTextShowFlag = false;


  String convertToAgo(DateTime input){
    Duration diff = DateTime.now().difference(input);

    if(diff.inDays >= 1){
      return '${diff.inDays} day(s) ago';
    } else if(diff.inHours >= 1){
      return '${diff.inHours} hour(s) ago';
    } else if(diff.inMinutes >= 1){
      return '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1){
      return '${diff.inSeconds} second(s) ago';
    } else {
      return 'just now';
    }
  }



  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        leading:IconButton(
          splashRadius: 20,

          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              aa();
              print("hh");
            });

          }

        ),
        title:Row(
          children: [
            for(var i=0;i<pip.length;i++)
              Text(pip[i]["username"] !=null ? pip[i]["username"] : "" ,style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
          ],
        ),

      ),

      body:_loadedPhotos.length>0?Container(

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
                              child: Center(child: Text(charAt(pip[v]["username"].toUpperCase(),0),style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),),
                              width: 100,
                              height: 100,

                              decoration: BoxDecoration(
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

                  SizedBox(height: 10,),
                  for(var i=0;i<pip.length;i++)
                    Expanded(
                      child:Center(
                      child:ReadMoreText( pip[i]["bio"]!=null ? pip[i]["bio"] :"ً" ,style: TextStyle(color: Colors.white,fontSize: 14),
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
                  Expanded(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Container(
                          child:GestureDetector(
                            child:Text(getFollowing.length.toString(),style: TextStyle(color: Colors.white,fontSize: 14),),
                            onTap: (){
                             Navigator.push(context,MaterialPageRoute(builder: (context) =>number(id)));

                            },

                          ),

                        ),


                        GestureDetector(
                          child:Text(getfollowrs.length.toString(),style: TextStyle(color: Colors.white,fontSize: 14),),
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)  =>followinges(id)));
                          },
                        ),

                      ],
                    ),
                  ),
                  Expanded(

                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [



                        Container(
                          child:GestureDetector(
                            child:Text("Followers",style: TextStyle(color: Colors.white,fontSize: 14),),
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) =>number(id)));
                            },

                          ),

                        ),
                        /*
                      Container(
                        width: 10,
                        height: 16,
                        child:VerticalDivider(color: Colors.white70, thickness: 1,),
                      ),

                       */


                        GestureDetector(
                          child:Text("Following",style: TextStyle(color: Colors.white,fontSize: 14),),
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)  =>followinges(id)));
                          },
                        ),

                      ],
                    ),

                  ),

                  for(var i=0;i<requests.length;i++)
                  for(var c=0;c<follow_unfollow.length;c++)
                    _loadedPhotos[c]["private"]==null?Center(
                      child:TextButton(
                        onPressed: () {
                          setState(() {
                            foolow[0]=!foolow[0];
                            follow();
                          });
                        },
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(foolow[0]!=follow_unfollow[c]["like"]?BorderSide(
                                width: 2, color:Colors.white):BorderSide(
                                width: 2, color:Colors.blue)),

                            foregroundColor:MaterialStateProperty.all(foolow[0]!=follow_unfollow[c]["like"]?Colors.white:Colors.blue),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 20))),
                        child: Text(foolow[0]!=follow_unfollow[c]["like"]?"Follow":"Following"),
                      ),
                    ):Center(
                      child:TextButton(
                        onPressed: () {
                          setState(() {
                            foolow[0]=!foolow[0];

                            if(follow_unfollow[c]["like"]==true){
                              follow();

                            }else{

                              follow_requests();
                            }
                            // follow();
                          });
                        },
                        style:follow_unfollow[c]["like"]!=true?ButtonStyle(
                            side: MaterialStateProperty.all(foolow[0]!=requests[i]["request"]?BorderSide(
                                width: 2, color:Colors.white):BorderSide(
                                width: 2, color:Colors.blue)),

                            foregroundColor:MaterialStateProperty.all(foolow[0]!=requests[i]["request"]?Colors.white:Colors.blue),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 20))):ButtonStyle(
                            side: MaterialStateProperty.all(foolow[0]!=follow_unfollow[c]["like"]?BorderSide(
                                width: 2, color:Colors.white):BorderSide(
                                width: 2, color:Colors.blue)),

                            foregroundColor:MaterialStateProperty.all(foolow[0]!=follow_unfollow[c]["like"]?Colors.white:Colors.blue),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 20))),
                        child: follow_unfollow[c]["like"]!=true?Text(foolow[0]!=requests[i]["request"]?"Follow":"Requested"):Text(foolow[0]!=follow_unfollow[c]["like"]?"Follow":"Following"),
                      ),
                    ),
                ],
              ),
            ),

           for(int s=0;s<follow_unfollow.length;s++)
             follow_unfollow[s]["like"]!=true?SliverList(
              delegate:_loadedPhotos[s]["private"]==null?SliverChildBuilderDelegate(

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
                                              child: Center(child: Text(charAt(_loadedPhotos[index]["account_name"]!=null?_loadedPhotos[index]["account_name"].toUpperCase():"",0),style: TextStyle(color: Colors.white,fontSize: 20),),),
                                              width: 110,
                                              height: 110,

                                              decoration: BoxDecoration(
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
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          _loadedPhotos[_loadedPhotos.length - 1 -index]["account_name"]!=null?_loadedPhotos[_loadedPhotos.length - 1 -index]["account_name"]:"",
                                          style:
                                          TextStyle(color: Colors.white, fontSize: 15),
                                        ),
                                      ),
                                    ),


                                    Container(
                                      width: 30,

                                      child:IconButton(
                                        splashRadius: 18,

                                        onPressed: () {
                                           button();
                                        },
                                        icon: Icon(Icons.more_vert),
                                        iconSize: 23,
                                        color: Colors.white,
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(
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
                                        circleColor: CircleColor(
                                            start: Color(0xff0e1313),
                                            end: Color(0xfff60e0e)),
                                        bubblesColor: BubblesColor(
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
                                        likeCount: _loadedPhotos[_loadedPhotos.length - 1 -index]["likes"],
                                        onTap: (isLiked) {

                                          return onLikeButtonTapped(
                                            isLiked,_loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"],
                                          );
                                        }
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    IconButton(

                                      highlightColor:Color.fromRGBO(1, 4, 30, 1),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  comment(_loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"],myid,emails,peas)),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.comment_outlined,
                                        size: 30,
                                      ),
                                      splashRadius: 0.5,
                                      color: Colors.white,
                                    ),
                                  */

                                number_like(_loadedPhotos[_loadedPhotos.length -1-index]["post_id"],myid,emails,peas,_loadedPhotos[_loadedPhotos.length -1-index]["IsLike"],_loadedPhotos[_loadedPhotos.length -1-index]["likes"]),

                                  ],
                                ),
                                ///     pip[i]["username"] !=null ? pip[i]["username"] : ""
                                Row(
                                  children:
                                  [
                                    SizedBox(width: 5,height: 20,),
                                    Text(
                                      _loadedPhotos[_loadedPhotos.length - 1 -index]["time"]!=null ?_loadedPhotos[_loadedPhotos.length - 1 -index]["time"]:"",
                                      style:TextStyle(color: Colors.white54, fontSize: 10),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),

                              ],
                            ),
                          ),

                        ),

                        Visibility(
                          visible:  _loadedPhotos[index]["title"] == null ? false : true,
                          child:Column(

                            children: [

                              Row(
                                children: [
                                  Container(

                                    child:Center(
                                      child:Container(

                                        child: Center(
                                          child:_loadedPhotos[index]["profile_photo"]==null?

                                          Container(
                                            child: Center(child: Text(charAt(_loadedPhotos[index]["account_name"]!=null?_loadedPhotos[index]["account_name"].toUpperCase():"",0),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
                                            width: 40,
                                            height: 40,

                                            decoration: BoxDecoration(
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
                                              _loadedPhotos[index]["profile_photo"],),
                                      ),

                                    ),

                                  ),

                                   */
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child:Text(
                                      _loadedPhotos[index]["account_name"]!=null?_loadedPhotos[index]["account_name"]:"",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
                                    ),),



                                  Container(
                                    width: 30,

                                    child:IconButton(
                                      splashRadius: 18,

                                      onPressed: () {
                                        // button();
                                      },
                                      icon: Icon(Icons.more_vert),
                                      iconSize: 23,
                                      color: Colors.white,
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Text(_loadedPhotos[index]['title']==null?_loadedPhotos[index]['title'].toString():_loadedPhotos[index]['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  )),

                              Row(
                                children: [
                                /*
                                  LikeButton(
                                    circleColor: CircleColor(
                                        start: Color(0xff0e1313),
                                        end: Color(0xfff60e0e)),
                                    bubblesColor: BubblesColor(
                                      dotPrimaryColor: Color(0xff33b5e5),
                                      dotSecondaryColor: Color(0xff000000),
                                    ),
                                    likeBuilder: (bool isLiked) {
                                      return Icon(
                                        _loadedPhotos[index]["IsLike"] != isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,

                                        color: _loadedPhotos[index]["IsLike"] != isLiked
                                            ? Colors.red
                                            : Colors.white,
                                        size: 30,
                                      );
                                    },

                                    size: 33,
                                    likeCount: _loadedPhotos[_loadedPhotos.length - 1 -index]["likes"],
                                    onTap: (isLiked) {
                                      return onLikeButtonTapped(
                                        isLiked, _loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"],
                                      );
                                    },

                                  ),
                                  // Text(_rateCount.toString(),style: TextStyle(color: Colors.white),),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  IconButton(

                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                comment(_loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"],myid,emails,peas)),
                                      );

                                    },
                                    icon: Icon(
                                      Icons.comment_outlined,
                                      size: 30,
                                    ),
                                    color: Colors.white,
                                    splashRadius: 0.5,
                                  ),

                                 */
                                  number_like(_loadedPhotos[_loadedPhotos.length -1-index]["post_id"],myid,emails,peas,_loadedPhotos[_loadedPhotos.length -1-index]["IsLike"],_loadedPhotos[_loadedPhotos.length -1-index]["likes"]),

                                ],
                              ),
                              Row(
                                children:
                                [
                                  SizedBox(width: 5,height: 20,),
                                  Text(
                                    _loadedPhotos[index]["time"]!=null?_loadedPhotos[index]["time"]:"",
                                    style:TextStyle(color: Colors.white54, fontSize: 10),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ):Column(
                    children: [


                      SizedBox(height: 100,),


                      Container(
                        child:Center(child: Icon(Icons.no_photography_outlined,size: 120,color: Colors.white,),),

                      ),
                      Container(
                        child:Center(child: Text("No Posts yet",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),

                      ),
                    ],
                  );
                },
                // Or, uncomment the following line:
                childCount: _loadedPhotos.length,

              ):SliverChildBuilderDelegate(

                    (BuildContext context, int index) {
                  return  Column(
                    children: [


                      SizedBox(height: 100,),


                      Container(
                        child:Center(child: Icon(Icons.lock,size: 120,color: Colors.white,),),

                      ),
                      Container(
                        child:Center(child: Text("This Account \n   is Private",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),

                      ),
                    ],
                  );
                },
                // Or, uncomment the following line:
                childCount: _loadedPhotos.length,

              ),
            ):SliverList(
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
                                               child: Center(child: Text(charAt(_loadedPhotos[index]["account_name"]!=null?_loadedPhotos[index]["account_name"].toUpperCase():"",0),style: TextStyle(color: Colors.white,fontSize: 20),),),
                                               width: 110,
                                               height: 110,

                                               decoration: BoxDecoration(
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
                                         padding: EdgeInsets.all(10),
                                         child: Text(
                                           _loadedPhotos[_loadedPhotos.length - 1 -index]["account_name"]!=null?_loadedPhotos[_loadedPhotos.length - 1 -index]["account_name"]:"",
                                           style:
                                           TextStyle(color: Colors.white, fontSize: 15),
                                         ),
                                       ),
                                     ),


                                     Container(
                                       width: 30,

                                       child:IconButton(
                                         splashRadius: 18,

                                         onPressed: () {
                                           button();
                                         },
                                         icon: Icon(Icons.more_vert),
                                         iconSize: 23,
                                         color: Colors.white,
                                       ),
                                     ),

                                   ],
                                 ),
                                 SizedBox(
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
                                     circleColor: CircleColor(
                                         start: Color(0xff0e1313),
                                         end: Color(0xfff60e0e)),
                                     bubblesColor: BubblesColor(
                                       dotPrimaryColor: Color(0xff33b5e5),
                                       dotSecondaryColor: Color(0xff000000),
                                     ),
                                     likeBuilder: (bool isLiked) {
                                       return Icon(
                                         _loadedPhotos[index]["IsLike"] != isLiked
                                             ? Icons.favorite
                                             : Icons.favorite_border_outlined,

                                         color: _loadedPhotos[index]["IsLike"] != isLiked
                                             ? Colors.red
                                             : Colors.white,
                                         size: 30,
                                       );
                                     },

                                     size: 33,
                                     likeCount: _loadedPhotos[_loadedPhotos.length - 1 -index]["likes"],
                                     onTap: (isLiked) {
                                       return onLikeButtonTapped(
                                         isLiked, _loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"],
                                       );
                                     },

                                   ),


                                   // Text(_rateCount.toString(),style: TextStyle(color: Colors.white),),

                                   SizedBox(
                                     width: 15,
                                   ),
                                   IconButton(

                                     onPressed: () {
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) =>
                                                 comment(_loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"],myid,emails,peas)),
                                       );
                                     print("hhh");
                                     },
                                     icon: Icon(
                                       Icons.comment_outlined,
                                       size: 30,
                                     ),
                                     color: Colors.white,
                                     splashRadius: 0.5,
                                   ),
                                   */
                                     number_like(_loadedPhotos[_loadedPhotos.length -1-index]["post_id"],myid,emails,peas,_loadedPhotos[_loadedPhotos.length -1-index]["IsLike"],_loadedPhotos[_loadedPhotos.length -1-index]["likes"]),

                                   ],
                                 ),
                                 ///     pip[i]["username"] !=null ? pip[i]["username"] : ""
                                 Row(
                                   children:
                                   [
                                     SizedBox(width: 5),
                                     Text(
                                       _loadedPhotos[_loadedPhotos.length - 1 -index]["time"]!=null ?_loadedPhotos[_loadedPhotos.length - 1 -index]["time"]:"",
                                       style:TextStyle(color: Colors.white54, fontSize: 10),
                                     ),
                                   ],
                                 ),
                                 SizedBox(height: 5),

                               ],
                             ),
                           ),

                         ),

                         Visibility(
                           visible:  _loadedPhotos[index]["title"] == null ? false : true,
                           child:Column(

                             children: [

                               Row(
                                 children: [
                                   Container(

                                     child:Center(
                                       child:Container(

                                         child: Center(
                                           child:_loadedPhotos[index]["profile_photo"]==null?

                                           Container(
                                             child: Center(child: Text(charAt(_loadedPhotos[index]["account_name"]!=null?_loadedPhotos[index]["account_name"].toUpperCase():"",0),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
                                             width: 40,
                                             height: 40,

                                             decoration: BoxDecoration(
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

                                               ),
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
                                   SizedBox(
                                     width: 10,
                                   ),
                                   Expanded(
                                     child:Text(
                                       _loadedPhotos[index]["account_name"]!=null?_loadedPhotos[index]["account_name"]:"",
                                       style:
                                       TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
                                     ),),



                                   Container(
                                     width: 30,

                                     child:IconButton(
                                       splashRadius: 18,

                                       onPressed: () {
                                         button();
                                       },
                                       icon: Icon(Icons.more_vert),
                                       iconSize: 23,
                                       color: Colors.white,
                                     ),
                                   ),

                                 ],
                               ),
                               SizedBox(
                                 height: 10,
                               ),

                               Text(_loadedPhotos[index]['title']==null?_loadedPhotos[index]['title'].toString():_loadedPhotos[index]['title'],
                                   style: TextStyle(
                                     color: Colors.white,
                                     fontSize: 15,
                                   )),

                               Row(
                                 children: [
                                    /*
                                   LikeButton(
                                     circleColor: CircleColor(
                                         start: Color(0xff0e1313),
                                         end: Color(0xfff60e0e)),
                                     bubblesColor: BubblesColor(
                                       dotPrimaryColor: Color(0xff33b5e5),
                                       dotSecondaryColor: Color(0xff000000),
                                     ),
                                     likeBuilder: (bool isLiked) {
                                       return Icon(
                                         _loadedPhotos[index]["IsLike"] != isLiked
                                             ? Icons.favorite
                                             : Icons.favorite_border_outlined,

                                         color: _loadedPhotos[index]["IsLike"] != isLiked
                                             ? Colors.red
                                             : Colors.white,
                                         size: 30,
                                       );
                                     },

                                     size: 33,
                                     likeCount: _loadedPhotos[_loadedPhotos.length - 1 -index]["likes"],
                                     onTap: (isLiked) {
                                       return onLikeButtonTapped(
                                         isLiked, _loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"],
                                       );
                                     },

                                   ),


                                   // Text(_rateCount.toString(),style: TextStyle(color: Colors.white),),

                                   SizedBox(
                                     width: 15,
                                   ),
                                   IconButton(

                                     onPressed: () {
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) =>
                                                 comment(_loadedPhotos[_loadedPhotos.length - 1 -index]["post_id"],myid,emails,peas)),
                                       );
                                     print("hhh");
                                     },
                                     icon: Icon(
                                       Icons.comment_outlined,
                                       size: 30,
                                     ),
                                     color: Colors.white,
                                     splashRadius: 0.5,
                                   ),
                                   */
                                   number_like(_loadedPhotos[_loadedPhotos.length -1-index]["post_id"],myid,emails,peas,_loadedPhotos[_loadedPhotos.length -1-index]["IsLike"],_loadedPhotos[_loadedPhotos.length -1-index]["likes"]),

                                 ],
                               ),
                               Row(
                                 children:
                                 [
                                   SizedBox(width: 5),
                                   Text(
                                     _loadedPhotos[index]["time"]!=null?_loadedPhotos[index]["time"]:"",
                                     style:TextStyle(color: Colors.white54, fontSize: 10),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 5),
                             ],
                           ),
                         ),

                       ],
                     ),
                   ):Column(
                     children: [


                       SizedBox(height: 100,),


                       Container(
                         child:Center(child: Icon(Icons.no_photography_outlined,size: 120,color: Colors.white,),),

                       ),
                       Container(
                         child:Center(child: Text("No Posts yet",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),

                       ),
                     ],
                   );
                 },
                 // Or, uncomment the following line:
                 childCount: _loadedPhotos.length,

               )
             ),
          ],
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

  void button() {
    showModalBottomSheet<String>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled:true,
      builder: (BuildContext ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
              color: Color
                  .fromRGBO(15, 3,
                  50, 1.0),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),

          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 350,child: Icon(Icons.arrow_drop_down,size: 40,color: Colors.white,),)
                ],
              ),
              SizedBox(height: 30,),
              Column(
                children: [
                  InkWell(
                    child:Center(
                      child: Text("Report the post",style: TextStyle(fontSize: 25,color: Colors.white),),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  Divider(height: 15,color: Colors.white),
                  InkWell(
                      child: Center(
                        child: Text("Report account",style: TextStyle(fontSize: 25,color: Colors.white),),
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      }

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

  String k_m_b_generator22(num) {
    if(num > 999 && num < 99999){
      return "${(num / 1000)}";
    }
      return num.toString();
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


