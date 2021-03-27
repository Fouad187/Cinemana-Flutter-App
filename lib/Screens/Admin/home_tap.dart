import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Widgets/request_review_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class HomeTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 10 , right: 10 , top: 10),
        child: Column(
          children: [
            Text('Requests' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
            Divider(),
            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Cinema').where('status' , isEqualTo: 'In Review').snapshots(),
                    builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.hasData)
                        {
                          List<DocumentSnapshot> documents=snapshot.data.docs;
                          if(documents.length > 0) {
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
                                return RequestReviewCard(
                                  cinema: c, docid: cinema.id,);
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
                                   Text('Empty Requests' , style: TextStyle(fontSize: 18),),
                                 ],
                               );
                            }

                        }
                      else {
                        return Center(child: Text('Loading....'));
                      }
                    },

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
