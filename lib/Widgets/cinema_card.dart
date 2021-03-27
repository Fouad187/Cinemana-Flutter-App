import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Screens/User/cinema_desripiton.dart';
import 'package:flutter/material.dart';

import '../constant.dart';


class CinemaCard extends StatelessWidget {
  Cinema cinema;
  CinemaCard({this.cinema});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => CinemaDescripiton(cinema: cinema,),));
      },
      child: Padding(
        padding: EdgeInsets.only(bottom:10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width-40,
                child: Image.asset('images/max.jpg',fit: BoxFit.cover,),
              ),
              Positioned(
                left: 0.0,
                bottom: 0.0,
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width-40,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.black12,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter
                      )
                  ),
                ),
              ),
              Positioned(
                left: 10.0,
                bottom: 10.0,
                right: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cinema.cinemaName , style: TextStyle(color: Colors.white , fontSize: 18 ,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text(cinema.address , style: TextStyle(color: Colors.white , fontSize: 15),),
                        Row(
                          children: [
                            Icon(Icons.star , color: Kcolor , size: 16,),
                            Icon(Icons.star , color: Kcolor , size: 16,),
                            Icon(Icons.star , color: Kcolor , size: 16,),
                            Icon(Icons.star , color: Kcolor , size: 16,),
                            Icon(Icons.star , color: Kcolor , size: 16,),
                            SizedBox(width: 10,),
                            Text('(${cinema.rating} Reviews)' , style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(cinema.minticketprice, style: TextStyle(color: Colors.orangeAccent , fontSize: 22 , fontWeight: FontWeight.bold),),
                        Text('Min Ticket' , style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
