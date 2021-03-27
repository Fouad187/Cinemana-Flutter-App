import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Models/film_model.dart';
import 'package:cinema/Models/user_model.dart';
import 'package:cinema/Providers/user_data.dart';
import 'package:cinema/Screens/Auth/login_screen.dart';
import 'package:cinema/Screens/User/user_cinema.dart';
import 'package:cinema/Screens/User/user_films.dart';
import 'package:cinema/Screens/User/user_tickets.dart';
import 'package:cinema/Services/auth.dart';
import 'package:cinema/Services/user_services.dart';
import 'package:cinema/Widgets/cinema_card.dart';
import 'package:cinema/Widgets/film_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class UserHomeScreen extends StatefulWidget {
  static String id='UserHomeScreenid';

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserServices userServices=UserServices();
  List<Cinema> cinema;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcinema();
  }
  getcinema() async
  {
    cinema=await userServices.GetPopularCinema();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    UserModel user=Provider.of<UserData>(context).user;
    return Scaffold(
      key: _scaffoldKey,
      drawer:Drawer(
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
                    Center(child: Text(user.name, style:TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,color: Colors.white),)),
                    Center(child: Text(user.email,style:TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,color: Colors.white)),),
                  ],
                ),
              ),
              ListTile(
                title: Text('My Tickets', style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.note_add, color: Kcolor),
                onTap: (){
                  Navigator.pushNamed(context, UserTicketScreen.id);
                },
              ),
              ListTile(
                title: Text('Films', style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.movie, color: Kcolor),
                onTap: (){
                  Navigator.pushNamed(context, UserFilmsScreen.id);
                },
              ),
              ListTile(
                title: Text('Cinema' , style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.local_movies, color: Kcolor),
                onTap: (){
                     Navigator.pushNamed(context, UserCinemaScreen.id);
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
      body: ListView(
        padding: EdgeInsets.only(top: 40 , left: 20 ,right: 20),
        children: [
           Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: (){
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Icon(Icons.list, size: 40,)),
                    Text('Would You' , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    Text('like watch a film?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  ],
                ),
                Icon(Icons.notifications_none ,size: 30,),
              ],
          ),
          SizedBox(height: 20,),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(15),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: 'Search for cinema',
                suffixIcon: Icon(Icons.search , color: Colors.black,),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Films' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
              GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context,UserFilmsScreen.id);
                  },
                  child: Text('View All', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            height: 250,
            child: FutureBuilder(
              future: userServices.GetNewFilm(),
              builder: (context, snapshot) {
                if(snapshot.hasData)
                  {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return FilmCard(film: snapshot.data[index],);
                        },
                    );
                  }
                else{
                  return CircularProgressIndicator();
                }
              },
            )
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Most Popular Cinemas', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold ),),
              GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, UserCinemaScreen.id);
                  },
                  child: Text('View All', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)),
            ],
          ),
          SizedBox(height: 10,),
          cinema != null ?
          Column(
            children: cinema.map((e) => CinemaCard(cinema: e,)).toList(),
          ) : Container(),
        ],
      )
    );
  }
}
