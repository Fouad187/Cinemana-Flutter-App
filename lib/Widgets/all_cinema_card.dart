import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Services/admin_services.dart';
import 'package:cinema/Services/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant.dart';


class AllCinemaCard extends StatelessWidget {
  Cinema cinema;
  String docid;
  AllCinemaCard({this.cinema , this.docid});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5 , left: 12 , right: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              GestureDetector(
                  onTap: () async{
                    try {

                      AdminServices adminServices=AdminServices();
                      await adminServices.deleteCinema(docid);
                    }
                    catch (e)
                    {
                      print(e);
                    }
                  },
                  child: Icon(Icons.delete , color: Kcolor,)),

            ],
          ),
        ),
      ),
    );
  }
}
