import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:ink/home.dart';
import 'package:ink/search.dart';

import 'account.dart';
import 'add_post.dart';
import 'favorite.dart';
class Button extends StatefulWidget {
  const Button({Key? key}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  int _currentIndex=0;

  static const List<Widget> _widgetOptions = <Widget>[

    home(),
    search(),
    add_post(),
    favorite(),
    account(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 4, 30, 1),
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: _buildNotificationBadge(),
    );

  }
  Widget _buildNotificationBadge() {

    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor:Colors.white,
      strokeColor: Color(0x30040307),
      unSelectedColor: Colors.white60,
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
          icon: Icon(  Icons.favorite,size: 30,),

          //   badgeCount: _badgeCounts[4],
          //   showBadge: _badgeShows[4],
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.account_circle,size: 30,),
        ),
      ],
        currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {

          _currentIndex=index;
        });
      },
    );
  }


}