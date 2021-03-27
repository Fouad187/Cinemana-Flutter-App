import 'package:carousel_pro/carousel_pro.dart';
import 'package:cinema/Screens/Auth/login_screen.dart';
import 'package:cinema/Widgets/slide_item.dart';
import 'package:cinema/constant.dart';
import 'package:flutter/material.dart';
class OnboardingScreen extends StatelessWidget {
  static String id='OnboardingScreenid';
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 20 , right: 20),
                  child: Carousel(
                    images: slidelist,
                    dotBgColor: Colors.transparent,
                    dotColor: Colors.grey,
                    dotIncreasedColor: Color(0xFFFE724C),
                    dotSpacing: 30,
                    dotSize: 6,
                    autoplayDuration: Duration(seconds: 10),
                    autoplay: true,

                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30, top: 40),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20 , right: 20 ,bottom: 10),
                    child: Container(
                      width: size.width,
                      height: size.height*0.05,
                      child: FlatButton(
                        onPressed: (){
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text('Get Started' , style: TextStyle(color: Colors.white , fontSize: 18),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Kcolor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
