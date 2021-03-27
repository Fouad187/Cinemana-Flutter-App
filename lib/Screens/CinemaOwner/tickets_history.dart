import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Models/ticket_model.dart';
import 'package:cinema/Providers/user_data.dart';
import 'package:cinema/Widgets/user_ticket_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';


class TicketHistoryScreen extends StatelessWidget {
  static String id='TicketHistoryScreenid';
  @override
  Widget build(BuildContext context) {
    Cinema cinema=Provider.of<UserData>(context).cinema;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets'),
        centerTitle: true,
        backgroundColor: Kcolor,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Tickets').where('id' , isEqualTo: cinema.id).orderBy('date' , descending: true).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                  {
                    List<DocumentSnapshot> documents=snapshot.data.docs;
                    if(documents.length>0)
                    {
                      return ListView(
                        children: documents.map((tic)  {
                          Ticket ticket=Ticket.fromJson(tic.data());
                          return UserTicketCard(ticket: ticket);
                        }).toList(),
                      );
                    }
                    else
                    {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: SvgPicture.asset('images/empty.svg', width: 200, height: 200,)),
                          SizedBox(height: 10,),
                          Text('Empty Tickets' , style: TextStyle(fontSize: 18),),
                        ],
                      );
                    }
                  }
                  else
                  {
                    return Center(child: Text('Loading....'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
