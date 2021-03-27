import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Services/admin_services.dart';
import 'package:cinema/Widgets/all_cinema_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyCinemaTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Cinema').where('status' , isEqualTo: 'Accepted').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            {
              List<DocumentSnapshot> documents=snapshot.data.docs;
              return ListView(
                children: documents.map((cinema) {
                  Cinema c = Cinema(
                    status: cinema['status'],
                    id: cinema['id'],
                    image: cinema['image'],
                    cinemaName: cinema['cinemaname'],
                    address: cinema['address'],
                    rating: cinema['rating'],
                  );
                  return AllCinemaCard(docid: cinema.id, cinema: c,);
                }).toList(),
              );
            }
          else
            {
              return Center(child: Text('Loading...'),);
            }

        },

      ),
    );
  }
}
