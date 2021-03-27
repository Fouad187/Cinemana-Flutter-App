import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Models/film_model.dart';
import 'package:cinema/Models/hall_model.dart';
import 'package:cinema/Models/snacks_model.dart';
import 'package:cinema/Screens/User/book.dart';
import 'package:cinema/Services/user_services.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';


class FilmDescription extends StatelessWidget {
  Film film;
  FilmDescription({this.film});
  @override
  Widget build(BuildContext context) {
    UserServices userServices=UserServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text(film.name),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Hero(
            tag: film.image,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 320,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(film.image),
                  fit: BoxFit.fill
                )
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(left: 20 , right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(film.name , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w800),),
                SizedBox(height: 20,),
                Text(film.description , style: TextStyle(fontSize: 18),),
                SizedBox(height: 20,),
                Text('Category : ${film.category}' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w500),),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.star , color: Kcolor , size: 16,),
                    Icon(Icons.star , color: Kcolor , size: 16,),
                    Icon(Icons.star , color: Kcolor , size: 16,),
                    Icon(Icons.star , color: Kcolor , size: 16,),
                    Icon(Icons.star , color: Kcolor , size: 16,),
                    SizedBox(width: 10,),
                    Text('(${film.rating} Rating)' , style: TextStyle(fontSize: 20,color: Colors.grey),),
                  ],
                ),
                SizedBox(height: 20,),
                Text('Cinema Name : ${film.cinemaname}' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w500),),
                SizedBox(height: 40,),
                Center(
                  child: FlatButton(onPressed: () async
                  {
                    try {
                      Cinema cin= await userServices.GetCinemaById(film.id);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen(cinema: cin,film: film,)));

                    }
                    catch (e) {

                    }

                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text('Book This Film' , style: TextStyle(color: Colors.white),),
                    color: Kcolor,
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
