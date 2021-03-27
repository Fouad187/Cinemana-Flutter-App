import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Models/film_model.dart';
import 'package:cinema/Models/hall_model.dart';
import 'package:cinema/Models/snacks_model.dart';
import 'package:cinema/Services/user_services.dart';
import 'package:cinema/Widgets/film_card.dart';
import 'package:cinema/Widgets/hall_card.dart';
import 'package:cinema/Widgets/snack_card.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';


class CinemaDescripiton extends StatefulWidget {
  Cinema cinema;
  CinemaDescripiton({this.cinema});

  @override
  _CinemaDescripitonState createState() => _CinemaDescripitonState();
}

class _CinemaDescripitonState extends State<CinemaDescripiton> {
  List<Film> films=[];
  List<Snacks> snacks=[];
  List<Hall> halls=[];
  UserServices userServices=UserServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Getdata();

  }
  Getdata() async
  {
    films=await userServices.GetFilmbyid(widget.cinema.id);
    halls=await userServices.GetHall(widget.cinema.id);
    snacks=await userServices.GetSnacksbyid(widget.cinema.id);

    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(widget.cinema.cinemaName),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
              height: 200,
              child: Image(image: AssetImage('images/max.jpg') , fit: BoxFit.fill,),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.cinema.cinemaName , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.location_on , color: Kcolor,),
                    SizedBox(width: 10,),
                    Text(widget.cinema.address , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.rate_review , color: Kcolor,),
                    SizedBox(width: 10,),
                    Text(widget.cinema.rating , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
                    SizedBox(width: 5,),
                    Text('Rating', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.favorite , color: Kcolor,),
                    SizedBox(width: 10,),
                    Text('Accepted by Admin', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
                  ],
                ),
                SizedBox(height: 20,),
                Text('Cinema Films', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),
                films !=null ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: films.length,
                    itemBuilder: (context, index) {
                      if(films.length==0)
                        {
                          return Center(child: Text('The Cinema didnt have any films yet'),);
                        }
                      else
                        {
                        return FilmCard(film: films[index],);
                      }
                  },),
                ) : Container(),
                SizedBox(height: 20,),
                Text('Cinema Halls', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),
                halls !=null ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: halls.length,
                    itemBuilder: (context, index) {
                      return HallCard(hall: halls[index],);
                    },),
                ) : Container(),
                SizedBox(height: 20,),
                Text('Cinema Snacks', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),
                snacks !=null ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snacks.length,
                    itemBuilder: (context, index) {
                      return SnacksCard(snacks: snacks[index],);
                    },),
                ) : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
