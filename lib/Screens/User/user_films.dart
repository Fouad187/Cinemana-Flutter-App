import 'package:cinema/Services/user_services.dart';
import 'package:cinema/Widgets/film_card.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';


class UserFilmsScreen extends StatelessWidget {
  static String id='UserFilmsScreenid';
  UserServices userServices=UserServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Films'),
        centerTitle: true,
        backgroundColor: Kcolor,
      ),
      body: FutureBuilder(
        future: userServices.GetAllFilms(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            {
              return Padding(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 5 ,
                    childAspectRatio:0.6,
                ),
                itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return FilmCard(film: snapshot.data[index],);
                  },
                ),
              );
            }
          else
            {
              return Center(child: Text('Loading.....'));
            }
        },
      ),
    );
  }
}
