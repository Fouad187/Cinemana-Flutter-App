import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Services/user_services.dart';
import 'package:cinema/Widgets/cinema_card.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class UserCinemaScreen extends StatefulWidget {
  static String id='UserCinemaScreenid';

  @override
  _UserCinemaScreenState createState() => _UserCinemaScreenState();
}

class _UserCinemaScreenState extends State<UserCinemaScreen> {
  List<Cinema> cinema;
  UserServices userServices=UserServices();
  String selectedcity='All';
  getcinema() async
  {
    cinema=await userServices.getCinemaByCity(selectedcity);
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcinema();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Cinema'),
        centerTitle: true,
        backgroundColor: Kcolor,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 10,left: 20 ,right: 20),
        children: [
          Row(
            children: [
              Text('Filter by city : ' , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              DropdownButton(items: getitem(allcities), value:selectedcity, onChanged: (value){
                setState(() {
                  selectedcity=value;
                  getcinema();
                });
              }),
            ],
          ),
          cinema != null ?
          Column(
            children: cinema.map((e) => CinemaCard(cinema: e,)).toList(),
          ) : Container(),
        ],
      )
    );
  }
}
