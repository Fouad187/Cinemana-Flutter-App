import 'package:cinema/Models/film_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class MyFilmCard extends StatelessWidget {
  final Film film;
  final docid;
  MyFilmCard({this.film , this.docid});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12 , right: 12 ,top: 5),
      child: GestureDetector(
        onTap: (){

        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(film.image),
                          fit: BoxFit.fill
                      )
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(film.name, style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                      SizedBox(height: 10,),
                      Text(film.category , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
                      SizedBox(height: 10,),
                      Text(film.cinemaname, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                      SizedBox(height: 10,),
                      Text('${film.rating} Rating', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                        onTap: () async{
                          try {
                            await FirebaseFirestore.instance.collection(
                                'Films').doc(docid).delete();
                          }
                          catch (e)
                          {
                            print(e);
                          }
                        },
                        child: Icon(Icons.delete , color: Kcolor,)),
                    SizedBox(height: 10,),
                 /*   GestureDetector(
                        onTap: (){

                        },
                        child: Icon(Icons.edit)),

                  */
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
