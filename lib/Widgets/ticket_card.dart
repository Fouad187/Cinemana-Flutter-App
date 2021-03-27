import 'package:cinema/Models/ticket_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  Ticket ticket;
  String docid;
  TicketCard({this.ticket, this.docid});
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
                      Text('Hall Name : ${ticket.hallName}', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text('Position : ${ticket.position}', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text('Time : ${ticket.filmTime}', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text('Time : ${ticket.ticketdate}', style: TextStyle(fontWeight: FontWeight.bold),),
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
                    Text('Total : ${ticket.total} LE', style: TextStyle(fontWeight: FontWeight.bold),),

                  ],
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection(
                          'Tickets').doc(docid).update(
                          {'status': 'Accepted'});
                    },
                    child: Text('Accept' , style: TextStyle(color: Colors.white),),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: 15,),
                FlatButton(
                    onPressed: () async{
                      await FirebaseFirestore.instance.collection(
                          'Tickets').doc(docid).update(
                          {'status': 'Rejected'});
                    },
                    child: Text('Reject' , style: TextStyle(color: Colors.white),),
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
