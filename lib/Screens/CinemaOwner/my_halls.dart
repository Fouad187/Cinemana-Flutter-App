import 'package:cinema/Models/hall_model.dart';
import 'package:cinema/Models/user_model.dart';
import 'package:cinema/Providers/user_data.dart';
import 'package:cinema/Widgets/my_halls_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
class MyHallScreen extends StatelessWidget {
  static String id='MyHallScreenid';
  @override
  Widget build(BuildContext context) {
    UserModel user=Provider.of<UserData>(context).user;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Kcolor,
          title: Text('Halls'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Halls').where('id' , isEqualTo: user.id).where('status' , isEqualTo: 'Accepted').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData)
            {
              List<DocumentSnapshot> documents=snapshot.data.docs;
              return ListView(
                children: documents.map((hall)
                {

                  Hall  myhall=Hall(
                    id: hall['id'],
                    status: hall['status'],
                    name: hall['name'],
                    image: hall['image'],
                    cinemaname: hall['cinemaname'],
                    kind: hall['kind'],
                    air: hall['air'],
                    numbers: hall['numbers'],
                    ticketprice: hall['tikcetprice'],
                  );
                  return MyHallsCard(hall: myhall, docid: hall.id,);
                }).toList(),
              );
            }
            else
            {
              return Center(child: Text('Loading...'));
            }
          },
        )
    );
  }
}
