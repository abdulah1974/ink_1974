import 'dart:convert';
import 'dart:math';
import 'package:ink/follow_requests.dart';
import 'package:ink/modeling.dart';
import 'package:ink/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http5;
import 'package:http/http.dart' as http3;
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http2;
import 'package:http/http.dart' as http4;
import 'package:http/http.dart' as http6;//get_comment
import 'model_acont/bool.dart';
class favorite extends StatefulWidget {
  late int id;
  late String email;
  late String pasw;

  favorite(int ids, String emails, String passwords) {
    email = emails;
    pasw = passwords;
    id = ids;
  }

  @override
  _accountState createState() => _accountState(id, email, pasw);
}

class _accountState extends State<favorite>  with TickerProviderStateMixin {
  late int id;
  late String email;
  late String pasw;

  _accountState(int ids, String emails, String passwords) {
    email = emails;
    pasw = passwords;
    id = ids;
  }

  late List<String> monthModel;

  List follow = [];
  List<modeiling> _list = [];

  Future<void>  follower() async {
    var response = await http5.get(
      Uri.parse("http://192.168.100.42:2000/getfollowing6?account_id=" +
          id.toString()),
    );

    var json = jsonDecode(response.body);

    follow = json;
    for (var i = 0; i < follow.length; i++) {
      _list.add(new modeiling(
          username: follow[i]["username"],
          profile_photo: follow[i]["profile_photo"],
          IsLike: follow[i]["like"],
          id: follow[i]["id"],
          userid: follow[i]["user_id"],
          time: follow[i]["time"],
          time2: follow[i]["time2"]));
          print("GetFollower");

    }

  }

  List like = [];
  var zz;
  Future<void> getlike() async {

    var response = await http3.get(
      Uri.parse(
          "http://192.168.100.42:2000/getMylikes?user_id=" + id.toString()),
    );
    var json = jsonDecode(response.body);
    like = json;

    for (var i = 0; i < like.length; i++) {
      _list.add(new modeiling(
          username2: like[i]["username"],
          profile_photo2: like[i]["profile_photo"],
          IsLike: false,
          imageing: like[i]["image"],
          title: like[i]["title"],
          time: like[i]["time"],
          time2: like[i]["time2"]));

    }

  }

  late String amount;



  List private = [];

  Future<void> get_private() async {
    var response = await http2.get(
      Uri.parse(
          "http://192.168.100.42:2000/get_private?email=$email&password="+pasw),
    );
    var json = jsonDecode(response.body);
    setState(() {
      private = json;
      for (int i =0; i < private.length; i++) {
      //  print(private[i]["private"]);
      //  private[i]["private"]=no_post_yet;
      }
    });
  }

  late Future futureAlbum;


  List listmention =[];
  Future<void>  mention() async {

    var response = await http4.get(Uri.parse("http://192.168.100.42:2000/get_mention?user__id="+id.toString()),);

    var json = jsonDecode(response.body);

    listmention = json;

    for (var a = 0; a < listmention.length; a++) {

        _list.add(new modeiling(
          IsLike: false,
          username:listmention[a]["username"],
          profile_photo2: listmention[a]["profile_photo"],
          image_mention: listmention[a]["image"],
          title_mention: listmention[a]["title"],
          time: listmention[a]["time"],
          time2: listmention[a]["time2"],
          visible_like:listmention[a]["fan_id"].toString(),
        ));
      //  print(listmention[a]["username"]);


      print("mention");

    }


  }
  Future<void>  asyncMethod3() async {


    await  mention();
    _list.sort((a, b) {
      int aDate = DateTime.parse(b.time2 ?? '').microsecondsSinceEpoch;
      int bDate = DateTime.parse(a.time2 ?? '').microsecondsSinceEpoch;
      return aDate.compareTo(bDate);
    });

  }

  Future<void> asyncMethod2() async {

    await follower();

    _list.sort((a, b) {
      int aDate = DateTime.parse(b.time2 ?? '').microsecondsSinceEpoch;
      int bDate = DateTime.parse(a.time2 ?? '').microsecondsSinceEpoch;
      return aDate.compareTo(bDate);
    });

  }

  Future<void>  asyncMethod1() async {


    await  getlike();
    _list.sort((a, b) {
      int aDate = DateTime.parse(b.time2 ?? '').microsecondsSinceEpoch;
      int bDate = DateTime.parse(a.time2 ?? '').microsecondsSinceEpoch;
      return aDate.compareTo(bDate);
    });

  }

  Future<void>  asyncMethod0() async {


    await   getcomment();
    _list.sort((a, b) {
      int aDate = DateTime.parse(b.time2 ?? '').microsecondsSinceEpoch;
      int bDate = DateTime.parse(a.time2 ?? '').microsecondsSinceEpoch;
      return aDate.compareTo(bDate);
    });

  }


  @override
  void initState() {
    super.initState();
    asyncMethod1();
    asyncMethod2();
    asyncMethod3();
    get_private();
    asyncMethod0();

    _arrowAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation = Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);
  }


  List get_comment = [];

  Future<void> getcomment() async {
    var response = await http6.get(Uri.parse("http://192.168.100.42:2000/get_notifications_comment?user_id=6"),);

    var json = jsonDecode(response.body);
    setState(() {
      get_comment = json;
      for (int i =0; i < get_comment.length; i++) {
         print(get_comment[i]["comment"]);
           _list.add(new modeiling(
             IsLike: false,
             username:get_comment[i]["username"],
             profile_photo2: get_comment[i]["profile_photo"],
             profile_photo: get_comment[i]["image"],
             title_comeent: get_comment[i]["title"],
             comment: get_comment[i]["comment"],
             time: get_comment[i]["time"],
             time2: get_comment[i]["time2"],

           ));
           //  print(listmention[a]["username"]);


           print("mention");


      }
    });
  }


  late Animation _arrowAnimation;
  late AnimationController _arrowAnimationController;




  List<bool> selectedControl = [];
  List<int> selectedIndexList = [];
  List followings = [];
  int? _destinationIndex;

  void following(var i) async {
    var response = await http.get(Uri.parse(
        "http://192.168.100.42:2000/follow?email=" +
            email +
            "&password=" +
            pasw +
            "&account_id=" +
            i.toString()));
    var jsondata = jsonDecode(response.body);

    setState(() {
      followings = jsondata;
    });
  }

  late List<bool2> listing;
  late int selectedIndex;

  Future refreshList() async {
    await Future.delayed(Duration(seconds: 1));

    print("jj");
    setState(() {

     // asyncMethod1();
    });
    return null;
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 4, 30, 1),
        centerTitle: true,
        title: Text('Notifications'),
      ),

      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child:_list.length>0? RefreshIndicator(
            onRefresh: refreshList,
            color: Colors.white,
            backgroundColor: const Color.fromRGBO(1, 4, 30, 1),
            child: Container(
                child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                /*
                for(int i=0;i<private.length;i++)
                 SliverAppBar(
                  backgroundColor: Colors.green,
                  title: Card(
                    child: Container(
                      color:  Color.fromRGBO(1, 4, 30, 1),
                      child: Visibility(
                        visible: private[i]["private"] == null
                            ? false
                            : true,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context) =>follow_requests()));
                              },
                              icon: const Icon(Icons.add),
                              splashRadius: 0.5,
                            ),
                            const Text(
                              "Follow requests",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  floating: true,
                ),
                */



                SliverList(

                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Card(
                        child: Container(
                          color: const Color.fromRGBO(1, 4, 30, 1),
                          child: Visibility(
                            visible: private[index]["private"] == null
                                ? false
                                : true,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context) =>follow_requests()));
                                  },
                                  icon: const Icon(Icons.add),
                                  splashRadius: 0.5,
                                ),
                                const Text(
                                  "Follow requests",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: private.length,
                  ),
                ),



                SliverFillRemaining(child: cc())
              ],
            ))
        ):Center(
          child:CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            color: Colors.white,
            strokeWidth: 1,

          ),
        ),
      ),
    );
  }

  Widget cc() {
    return ListView.builder(
      itemCount: _list.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(7),

          color: const Color.fromRGBO(1, 4, 30, 1),
          child: Column(
            children: [
              Column(
                children: [

                 //like
                  Visibility(
                    visible: _list[index].username2 != null ? true : false,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            print(_list[index].id);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                        _list[index].profile_photo2.toString(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            width:13
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.57,
                              child: Text(
                                _list[index].username2.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                           SizedBox(
                             width: MediaQuery.of(context).size.width*0.57,
                            child:  Row(
                             // mainAxisSize: MainAxisSize.max,
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "There is a like",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.white),
                                ),
                                Text(
                                  _list[index].time.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.white60),
                                ),

                              ],
                            ),
                           ),



                          ],
                        ),

                        Expanded(
                          child:SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                        ),
                        //  SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              if(!selectedIndexList.contains(index)) {

                                selectedIndexList.add(index);

                              } else {
                                selectedIndexList.remove(index);
                              }
                              /*
                          _arrowAnimationController.isCompleted
                              ? _arrowAnimationController.reverse()
                              : _arrowAnimationController.forward();

                           */

                            });
                          },
                          child:selectedIndexList.contains(index)?Icon(
                            Icons.expand_less,
                            size: 30.0,
                            color: Colors.white,
                          ):Icon(
                            Icons.expand_more,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),


                      ],
                    ),
                  ),
                  //like
                  Visibility(
                      visible: selectedIndexList.contains(index) ? true : false,
                      child: Column(
                        children: [
                          Visibility(
                            visible:  _list[index].imageing != null ? true : false,
                            child: Container(
                              width: 700,
                              height: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                        _list[index].imageing.toString(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _list[index].title != null ? true : false,
                            child: Container(
                              child: Text(
                                _list[index].title.toString()== null
                                    ? ""
                                    : _list[index].title.toString(),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )),



                  //follow
                  Visibility(
                    visible: _list[index].id != null ? true : false,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                      _list[index].profile_photo.toString(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Column(
                          children: [
                            ///  _list[i].id!=null?_list[i].id:""
                            SizedBox(
                              width: 180,
                              child: Text(
                                _list[index].username.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                Text(
                                  "There is a Follow",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.white),
                                ),
                                Text(
                                  _list[index].time.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.white60),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: TextButton(

                            onPressed: () {
                              setState(() {
                                _list[index].IsLike = !_list[index].IsLike;
                                //  following(_list[index].id);

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

                                side: MaterialStateProperty.all(
                                    _list[index].IsLike != true
                                        ? const BorderSide(
                                            width: 1, color: Colors.white)
                                        : const BorderSide(
                                            width: 1, color: Colors.blue)),
                                foregroundColor: MaterialStateProperty.all(
                                    _list[index].IsLike != true
                                        ? Colors.white
                                        : Colors.blue),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 1,
                                )),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 20))),
                            child: Text(_list[index].IsLike != true
                                ? "Follow"
                                : "Following"),
                          ),
                        ),
                      ],
                    ),
                  ),



              //مينشن1
                  Visibility(
                    visible: _list[index].visible_like != null ? true : false,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            print(_list[index].id);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                      _list[index].profile_photo2.toString(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Column(
                          children: [
                            ///  _list[i].id!=null?_list[i].id:""
                            SizedBox(
                              width: 180,
                              child: Text(
                                _list[index].username.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                         Container(
                           width: 190,
                          child:Row(
                            children: [
                              Text(
                                "There is a mention",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white),
                              ),
                              Text(
                                _list[index].time.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white60),
                              ),
                            ],
                          ),

                         ),


                          ],
                        ),
                        SizedBox(width: 50,),
                      GestureDetector(
                      onTap: (){
                        setState(() {
                          if(!selectedIndexList.contains(index)) {

                            selectedIndexList.add(index);

                          } else {
                            selectedIndexList.remove(index);
                          }
                          /*
                          _arrowAnimationController.isCompleted
                              ? _arrowAnimationController.reverse()
                              : _arrowAnimationController.forward();

                           */

                        });
                      },
                      child:selectedIndexList.contains(index)?Icon(
                        Icons.expand_less,
                        size: 30.0,
                        color: Colors.white,
                      ):Icon(
                        Icons.expand_more,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),


                      ],
                    ),
                  ),

                  //مينشن
                  Visibility(
                      visible:selectedIndexList.contains(index)? true : false,
                      child: Column(
                        children: [

                          Visibility(
                            visible: _list[index].image_mention != null ? true : false,
                            child: Container(
                              width: 700,
                              height: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                        _list[index].image_mention.toString()==null?"":  "http://192.168.100.42:2000/get_trnd2_image?path=" +_list[index].image_mention.toString(),

                                  ),
                                ),
                              ),
                            ),
                          ),

                          Visibility(
                            visible: _list[index].title_mention != null ? true : false,
                            child: Container(
                              child: Text(
                                _list[index].title_mention.toString() == null
                                    ? ""
                                    : _list[index].title_mention.toString(),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),

                        ],

                      )),


                  //1تعليقات
                  Visibility(
                    visible: _list[index].comment != null ? true : false,
                    child: Column(
                      children: [
                        Row(

                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                print(_list[index].id);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                            _list[index].profile_photo2.toString()
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width:13
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.57,
                                  child: Text(
                                    _list[index].username.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                Row(
                                //  mainAxisSize: MainAxisSize.max,
                                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "There is a comment",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w100,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      _list[index].time.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w100,
                                          color: Colors.white60),

                                    ),


                                  ],
                                ),



                              ],
                            ),
                            Expanded(
                                child:SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                            ),
                          //  SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(!selectedIndexList.contains(index)) {

                                    selectedIndexList.add(index);

                                  } else {
                                    selectedIndexList.remove(index);
                                  }
                                  /*
                          _arrowAnimationController.isCompleted
                              ? _arrowAnimationController.reverse()
                              : _arrowAnimationController.forward();

                           */

                                });
                              },
                              child:selectedIndexList.contains(index)?Icon(
                                Icons.expand_less,
                                size: 30.0,
                                color: Colors.white,
                              ):Icon(
                                Icons.expand_more,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),



                          ],
                        ),


                      ],
                    ),
                  ),

                  //تعليقات2
                  Visibility(
                      visible:selectedIndexList.contains(index)? true : false,
                      child: Column(
                        children: [

                          Visibility(
                            visible:_list[index].title_comeent != null ? true : false,
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.90,
                              alignment:Alignment.center,
                              child: Text(
                                _list[index].title_comeent.toString() == null
                                    ? ""
                                    : _list[index].title_comeent.toString(),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.90,
                            child:_list[index].comment!=null?Divider(color: Colors.white60,height: 2, thickness: 1,):null,
                          ),
                          Visibility(
                            visible:_list[index].comment != null ? true : false,
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.90,
                              alignment:Alignment.bottomLeft,
                              child: Text(
                                  _list[index].comment.toString() == null
                                    ? ""
                                    : _list[index].comment.toString(),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),

                        ],

                      )),


                ],
              ),

            ],

          ),
        );
      },
    );
  }

  Widget _buildPlayerModelList() {
    return RefreshIndicator(
        color: Color.fromRGBO(1, 4, 30, 1),
        child: ListView.builder(
          itemCount: _list.length,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Color.fromRGBO(1, 4, 30, 1),
              child: Column(
                children: [
                  Visibility(
                    visible: _list[_list.length - 1 - index].private == null
                        ? false
                        : true,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          color: Colors.white,
                          onPressed: () {},
                          icon: Icon(Icons.add),
                          splashRadius: 0.5,
                        ),
                        Text(
                          "Follow requests",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Visibility(
                        visible:
                            _list[_list.length - 1 - index].username2 != null
                                ? true
                                : false,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                /*
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => user(2,id)),
                                 );

                                  */
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                          _list[_list.length - 1 - index]
                                              .profile_photo2
                                              .toString(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Column(
                              children: [
                                //  _list[i].id!=null?_list[i].id:""

                                SizedBox(
                                  width: 83,
                                  child: Text(
                                    _list[_list.length - 1 - index]
                                        .username2
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                Text(
                                  "There is a like",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 165,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (!selectedIndexList.contains(index)) {
                                    selectedIndexList.add(index);
                                    print("hhh");
                                  } else {
                                    selectedIndexList.remove(index);

                                    print("ccc");
                                  }
                                });
                              },
                              child: Icon(
                                selectedIndexList.contains(index)
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down_sharp,
                                size: 30,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible:
                              selectedIndexList.contains(index) ? true : false,
                          child: Column(
                            children: [
                              Visibility(
                                visible:
                                    _list[_list.length - 1 - index].imageing !=
                                            null
                                        ? true
                                        : false,
                                child: Container(
                                  width: 700,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                            _list[_list.length - 1 - index]
                                                .imageing
                                                .toString(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible:
                                    _list[_list.length - 1 - index].title !=
                                            null
                                        ? true
                                        : false,
                                child: Container(
                                  child: Text(
                                    _list[_list.length - 1 - index]
                                        .title
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Visibility(
                        visible:
                            _list[index].profile_photo != null ? true : false,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                print(_list[index].id);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => users(
                                          _list[index].id.toString().length,
                                          id,
                                          email,
                                          pasw)),
                                );
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "http://192.168.100.42:2000/get_trnd2_image?path=" +
                                          _list[index].profile_photo.toString(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Column(
                              children: [
                                ///  _list[i].id!=null?_list[i].id:""
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    _list[index].username.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                Row(
                                  children: [
                                    Text(
                                      "There is a Follow",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w100,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            _list[index].IsLike != true
                                ? SizedBox(
                                    width: 95,
                                  )
                                : SizedBox(
                                    width: 75,
                                  ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _list[index].IsLike = !_list[index].IsLike;
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
                                    side: MaterialStateProperty.all(
                                        _list[index].IsLike != true
                                            ? BorderSide(
                                                width: 2, color: Colors.white)
                                            : BorderSide(
                                                width: 2, color: Colors.blue)),
                                    foregroundColor: MaterialStateProperty.all(
                                        _list[index].IsLike != true
                                            ? Colors.white
                                            : Colors.blue),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10)),
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(fontSize: 20))),
                                child: Text(_list[index].IsLike != true
                                    ? "Follow"
                                    : "Following"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        onRefresh: refreshList);
  }
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
}
class show_image_titel extends StatefulWidget {
  late String image_mention;
  show_image_titel(this.image_mention);
  @override
  State<show_image_titel> createState() => _show_image_titelState(image_mention);
}

class _show_image_titelState extends State<show_image_titel>  with TickerProviderStateMixin{
  late String image_mention;
  _show_image_titelState(this.image_mention);
  late Animation _arrowAnimation;
  late AnimationController _arrowAnimationController;
  List<int> selectedIndexList = [];
  @override
  void initState() {
    super.initState();
    _arrowAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation = Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: (){
         setState(() {

           _arrowAnimationController.isCompleted
               ? _arrowAnimationController.reverse()
               : _arrowAnimationController.forward();
         });
       },
      child:AnimatedBuilder(
        animation: _arrowAnimationController,

        builder: (context, child) => Transform.rotate(
          angle: _arrowAnimation.value,
          child: Icon(
            Icons.expand_more,
            size: 30.0,
            color: Colors.white,
          ),

        ),

      ),
    );
  }
}

