import 'package:cinema/Models/ticket_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserTicketCard extends StatelessWidget {
  Ticket ticket;

  UserTicketCard({this.ticket});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Film Name : ${ticket.filmName}' , style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text('Cinema : ${ticket.cinemaName}' , style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text('Hall Name : ${ticket.hallName}', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text('Position : ${ticket.position}', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text('Time : ${ticket.filmTime}', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Snack : ${ticket.snacksName}' , style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text('Seats : ${ticket.numberofSeats}', style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text('Snacks N : ${ticket.numberofsnacks}', style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text('Address : ${ticket.cinemaAddress}', style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text('Total : ${ticket.total} LE', style: TextStyle(fontWeight: FontWeight.bold),),

                  ],
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: 200,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ticket.status =='In Review' ? Colors.yellow : ticket.status=='Accepted' ? Colors.green : Colors.red,
              ),
              child: Center(child: Text(ticket.status , style: TextStyle(color: ticket.status=='In Review' ? Colors.black : Colors.white),)),
            ),
            ticket.status=='Rejected' ? SizedBox(height: 10,) : Container(),
            ticket.status=='Rejected' ? Center(child: Text('Your Money was recovered' , style: TextStyle(color: Colors.black , fontSize: 18),)):Container(),

          ],
        ),
      ),
    );
  }
}
