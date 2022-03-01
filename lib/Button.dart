import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:ink/home.dart';
import 'package:ink/search.dart';

import 'account.dart';
import 'add_post.dart';
import 'favorite.dart';
class Button extends StatefulWidget {
  late int id;

  Button(int id2){
    id=id2;
  }

  @override
  _ButtonState createState() => _ButtonState(id);
}

class _ButtonState extends State<Button> {

  late int id;

  _ButtonState(int id2){
    id=id2;
  }







  void cc()
  {
    print("myid"+id.toString());
  }


  int _currentIndex=0;

  List<Widget> _widgetOptions1 = <Widget>[];


  late bool sel=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cc();
    _widgetOptions1=_widgetOptions1 = <Widget>[

      home(id),
      search(),
      add_post(),
      favorite(id),
      account(id),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      body: Center(
        child: _widgetOptions1.elementAt(_currentIndex),
      ),
      bottomNavigationBar: _buildNotificationBadge(),
    );

  }
  Widget _buildNotificationBadge() {

    return CustomNavigationBar(

      iconSize: 30.0,
      selectedColor:Colors.white,
      strokeColor: Color(0x30040307),
      unSelectedColor: Colors.white70,

      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      items: [
        CustomNavigationBarItem(

          icon: Icon(Icons.home,size: 32),
          //  badgeCount: _badgeCounts[0],
          //   showBadge: _badgeShows[0],
        ),

        CustomNavigationBarItem(

          icon:Icon(Icons.search,size: 30),
          //     badgeCount: _badgeCounts[2],
          //       showBadge: _badgeShows[2],
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline_sharp),
          //badgeCount: _badgeCounts[3],
          //   showBadge: _badgeShows[3],
        ),
        CustomNavigationBarItem(
          icon:Icon(Icons.favorite,size: 30,),

          //   badgeCount: _badgeCounts[4],
          //   showBadge: _badgeShows[4],
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined,size: 30,),

        ),
      ],
        currentIndex:_currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex=index;

        });
      },
    );
  }


}