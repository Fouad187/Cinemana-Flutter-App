import 'package:cinema/Screens/Admin/all_cinema.dart';
import 'package:cinema/Screens/Admin/home_tap.dart';
import 'package:cinema/Screens/Auth/login_screen.dart';
import 'package:cinema/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant.dart';

class AdminHomeScreen extends StatefulWidget {
  static String id='AdminHomeScreenid';

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int selectedIndex=0;
  final taps=[
    HomeTap(),
    MyCinemaTap(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        backgroundColor: Kcolor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Kcolor,
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex=index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'All Cinema',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Kcolor,
              ),
              child: Column(
                children: [
                  Expanded(child: SvgPicture.asset('images/logo3.svg', width: 200, height: 200,)),
                  Center(child: Text('Admin',style:TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,color: Colors.white)),),
                ],
              ),
            ),
            ListTile(
              title: Text('Log out', style: TextStyle(color: Colors.black),),
              leading: Icon(Icons.logout, color: Kcolor),
              onTap: () async {
                Auth auth=Auth();
                await auth.signOut();
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
              },
            ),
          ],
        ),
      ),
      body: taps[selectedIndex],
    );
  }
}
