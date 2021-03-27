import 'package:cinema/Models/snacks_model.dart';
import 'package:flutter/material.dart';


class SnacksCard extends StatelessWidget {
  Snacks snacks;
  SnacksCard({this.snacks});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       // Navigator.push(context, MaterialPageRoute(builder: (context) => FilmDescription(film: film,),));
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                      width: 150,
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(snacks.image),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                SizedBox(height: 5,),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snacks.name , style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text('${snacks.price} LE' , style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
