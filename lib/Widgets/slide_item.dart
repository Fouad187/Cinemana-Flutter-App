import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class Slide extends StatelessWidget {
  const Slide({@required this.image , @required this.title , @required this.description});

  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            child: SvgPicture.asset(image, width: size.width*0.7, height: size.height*0.4,)),
        Text(title, style: TextStyle(color: Color(0xFFFE724C) , fontWeight: FontWeight.bold , fontSize: 22),),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.only(left: 20 , right: 20),
          child: Text(description,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],

    );
  }
}
final List<Slide> slidelist=
[
  Slide(image : 'images/films.svg', title :'Movies', description :'Find all kinds of Movies from any category and know more details about the Movie and his Avaliable Tickets'),
  Slide(image : 'images/cinemaowner.svg', title: 'Cinema Owner ', description: 'Add Your Cinema with Location , Films and avaliable tickets to users'),
  Slide(image : 'images/booking.svg', title : 'Booking', description: 'Booking from any cinema and see avaliable tickets in any party'),

];