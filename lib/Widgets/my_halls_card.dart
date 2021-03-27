import 'package:cinema/Models/hall_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class MyHallsCard extends StatelessWidget {
  final Hall hall;
  final docid;
  MyHallsCard({this.hall , this.docid});
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
                          image: NetworkImage(hall.image),
                          fit: BoxFit.fill
                      )
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${hall.name} Hall', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                      SizedBox(height: 10,),
                      Text('${hall.numbers} Seats' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
                      SizedBox(height: 10,),
                      Text(hall.kind, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                      SizedBox(height: 10,),
                      Text('${hall.air} Air-con', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                      SizedBox(height: 10,),
                      Text('${hall.ticketprice} LE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                    ],
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                        onTap: () async{
                          try {
                            await FirebaseFirestore.instance.collection(
                                'Halls').doc(docid).delete();
                          }
                          catch (e)
                          {
                            print(e);
                          }
                        },
                        child: Icon(Icons.delete , color: Kcolor,)),
                    SizedBox(height: 10,),
                    /*GestureDetector(
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
