import 'package:cinema/Models/cinema_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class RequestReviewCard extends StatelessWidget {
  Cinema cinema;
  String docid;

  RequestReviewCard({this.cinema , this.docid});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children:[
              Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage('images/logo.png'),
                          fit: BoxFit.fill
                      )
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cinema.cinemaName, style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                      SizedBox(height: 10,),
                      Text(cinema.address , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
                      SizedBox(height: 10,),
                      Text(cinema.rating, style: TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
                    ],
                  ),
                ),
              ],
            ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection(
                          'Cinema').doc(docid).update(
                          {'status': 'Accepted'});
                    },
                    child: Text('Accept'),
                    color: Colors.green,
                  ),
                  SizedBox(width: 15,),
                  FlatButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection(
                          'Cinema').doc(docid).update(
                          {'status': 'Refused'});
                    },
                    child: Text('Refused'),
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
