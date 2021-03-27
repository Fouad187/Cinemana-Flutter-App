import 'package:cinema/Models/film_model.dart';
import 'package:cinema/Screens/User/film_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';


class FilmCard extends StatelessWidget {
  Film film;
  FilmCard({this.film});
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => FilmDescription(film: film,),));
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            width: 155,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Hero(
                    tag: film.image,
                    child: Container(
                      width: 155,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(film.image),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(film.name , style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Icon(Icons.star , color: Kcolor , size: 16,),
                          Icon(Icons.star , color: Kcolor , size: 16,),
                          Icon(Icons.star , color: Kcolor , size: 16,),
                          Icon(Icons.star , color: Kcolor , size: 16,),
                          Icon(Icons.star , color: Kcolor , size: 16,),
                        ],
                      ),
                      Text('(${film.rating} Reviews)' , style: TextStyle(color: Colors.grey),),
                      Text(film.cinemaname , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
