import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Models/user_model.dart';
import 'package:cinema/Providers/user_data.dart';
import 'package:cinema/Screens/Auth/login_screen.dart';
import 'package:cinema/Screens/CinemaOwner/add_film.dart';
import 'package:cinema/Screens/CinemaOwner/add_hall.dart';
import 'package:cinema/Screens/CinemaOwner/add_snacks.dart';
import 'package:cinema/Screens/CinemaOwner/cinema_home.dart';
import 'package:cinema/Screens/CinemaOwner/my_films.dart';
import 'package:cinema/Screens/CinemaOwner/my_halls.dart';
import 'package:cinema/Screens/CinemaOwner/my_snacks.dart';
import 'package:cinema/Screens/CinemaOwner/tickets_history.dart';
import 'package:cinema/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';


class OwnerHomeScreen extends StatefulWidget {
  static String id='OwnerHomeScreen';

  @override
  _OwnerHomeScreenState createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  int selectedIndex=0;

  final taps=[
    CinemaHome(),
    AddFilm(),
    AddHall(),
    AddSnacks(),
  ];
  @override
  Widget build(BuildContext context) {
    UserModel user=Provider.of<UserData>(context).user;
    Cinema cinema=Provider.of<UserData>(context).cinema;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(user.name),
      ),
      drawer: Drawer(
        child: Scaffold(
          body: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Kcolor,
                ),
                child: Column(
                  children: [
                    Expanded(child: SvgPicture.asset('images/logo3.svg', width: 200, height: 200,)),
                    Center(child: Text(user.name, style:TextStyle( fontSize: 25 , fontWeight: FontWeight.bold ,color: Colors.white),)),
                    Center(child: Text(cinema.status,style:TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,color: Colors.white)),),
                  ],
                ),
              ),
              ListTile(
                title: Text('My Films', style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.movie, color: Kcolor),
                onTap: (){
                  Navigator.pushNamed(context, MyFilmsScreen.id);
                },
              ),
              ListTile(
                title: Text('My Halls', style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.fiber_new, color: Kcolor),
                onTap: (){
                  Navigator.pushNamed(context, MyHallScreen.id);
                },
              ),
              ListTile(
                title: Text('My Snacks', style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.fastfood, color: Kcolor),
                onTap: (){
                  Navigator.pushNamed(context, MySnacksScreen.id);
                },
              ),
              ListTile(
                title: Text('Tickets', style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.rate_review, color: Kcolor),
                onTap: (){
                  Navigator.pushNamed(context,TicketHistoryScreen.id);
                },
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
            label: 'Add Film',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fiber_new),
            label: 'Add Hall',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Add Snacks',
          ),
        ],
      ),
      body: taps[selectedIndex],
    );
  }
}
