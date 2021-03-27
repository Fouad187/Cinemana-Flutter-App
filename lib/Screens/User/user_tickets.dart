import 'package:cinema/Models/ticket_model.dart';
import 'package:cinema/Models/user_model.dart';
import 'package:cinema/Providers/user_data.dart';
import 'package:cinema/Widgets/user_ticket_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';


class UserTicketScreen extends StatelessWidget {
  static String id='UserTicketScreenid';
  @override
  Widget build(BuildContext context) {
    UserModel user=Provider.of<UserData>(context).user;

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
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Tickets').where('senderid' , isEqualTo: user.id).orderBy('date' , descending: true).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                  {
                    List<DocumentSnapshot> documents=snapshot.data.docs;
                    if(documents.length>0)
                    {
                      return ListView(
                        children: documents.map((tic)  {
                          Ticket ticket=Ticket.fromJson(tic.data());
                          return UserTicketCard(ticket: ticket,);
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
                          Text('You didn\'t book any ticket' , style: TextStyle(fontSize: 18),),
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
