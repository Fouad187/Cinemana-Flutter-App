import 'package:cinema/Models/snacks_model.dart';
import 'package:cinema/Models/user_model.dart';
import 'package:cinema/Providers/user_data.dart';
import 'package:cinema/Widgets/my_snacks_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';


class MySnacksScreen extends StatelessWidget {
  static String id='MySnacksScreenid';
  @override
  Widget build(BuildContext context) {
    UserModel user=Provider.of<UserData>(context).user;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Kcolor,
          title: Text('Snacks'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Snacks').where('id' , isEqualTo: user.id).where('status' , isEqualTo: 'Accepted').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData)
            {
              List<DocumentSnapshot> documents=snapshot.data.docs;
              return ListView(
                children: documents.map((snack)
                {

                  Snacks mysnacks=Snacks(
                    id: snack['id'],
                    status: snack['status'],
                    name: snack['name'],
                    image: snack['image'],
                    cinemaname: snack['cinemaname'],
                    price: snack['price'],
                  );
                  return MySnacksCard(snack: mysnacks, docid: snack.id,);
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
