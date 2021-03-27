import 'package:cinema/Models/film_model.dart';
import 'package:cinema/Models/user_model.dart';
import 'package:cinema/Providers/user_data.dart';
import 'package:cinema/Widgets/my_film_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class MyFilmsScreen extends StatelessWidget {
  static String id='MyFilmsScreenid';
  @override
  Widget build(BuildContext context) {
    UserModel user=Provider.of<UserData>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: Text('Films'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Films').where('id' , isEqualTo: user.id).where('status' , isEqualTo: 'Accepted').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData)
            {
              List<DocumentSnapshot> documents=snapshot.data.docs;
              return ListView(
                children: documents.map((film)
                {

                  Film myfilm=Film(
                    id: film['id'],
                    status: film['status'],
                    name: film['name'],
                    image: film['image'],
                    cinemaname: film['cinemaname'],
                    category: film['category'],
                    description: film['description'],
                    rating: film['rating'],
                  );
                  return MyFilmCard(film: myfilm, docid: film.id,);
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
