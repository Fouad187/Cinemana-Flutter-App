import 'package:cinema/Models/hall_model.dart';
import 'package:flutter/material.dart';


class HallCard extends StatelessWidget {
  Hall hall;
  HallCard({this.hall});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context) => FilmDescription(film: film,),));
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
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                      width: 160,
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(hall.image),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                SizedBox(height: 5,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hall.name , style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text(hall.kind , style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text('${hall.air} Air-conditioned', style: TextStyle(fontWeight: FontWeight.bold ,),),
                      SizedBox(height: 5,),
                      Text('${hall.numbers} Seats' , style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text('${hall.ticketprice} LE For Ticket' , style: TextStyle(fontWeight: FontWeight.bold),),
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
