import 'dart:io';

import 'package:cinema/Models/film_model.dart';
import 'package:cinema/Models/hall_model.dart';
import 'package:cinema/Models/snacks_model.dart';
import 'package:cinema/Models/user_model.dart';
import 'package:cinema/Providers/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class OwnerServices
{

  void AddNewFilm({String name , String category , String description , String rating , File image , context}) async
  {
    UserModel user=Provider.of<UserData>(context , listen: false).user;

    final ref=FirebaseStorage.instance.ref().child('Films_posters').child('${name+user.id}.jpg');
    await ref.putFile(image);
    final url=await ref.getDownloadURL();


    Film film=Film(
      id: user.id,
      cinemaname: user.name,
      name: name,
      category: category,
      description: description,
      rating: rating,
      image: url,
      status: 'Accepted',
    );


    await FirebaseFirestore.instance.collection('Films').doc().set(film.toJson());

  }

  void AddNewHall({String name , String numbers , String air , File image ,String kind, String ticketprice,context}) async
  {
    UserModel user=Provider.of<UserData>(context , listen: false).user;
    final ref=FirebaseStorage.instance.ref().child('Hall_images').child('${name+user.id}.jpg');
    await ref.putFile(image);
    final url=await ref.getDownloadURL();
    Hall hall=Hall(
      name: name,
      image: url,
      id: user.id,
      cinemaname: user.name,
      air: air,
      numbers: numbers,
      status: 'Accepted',
      ticketprice: ticketprice,
      kind: kind,
    );

    await FirebaseFirestore.instance.collection('Halls').doc().set(hall.toJson());

  }

  void AddNewSnacks({String name , String price, File image , context}) async
  {
    UserModel user=Provider.of<UserData>(context , listen: false).user;
    final ref=FirebaseStorage.instance.ref().child('Snacks_image').child('${name+user.id}.jpg');
    await ref.putFile(image);
    final url=await ref.getDownloadURL();

    Snacks snacks=Snacks(
      name: name,
      price: price,
      image: url,
      cinemaname: user.name,
      id: user.id,
      status: 'Accepted'
    );
    await FirebaseFirestore.instance.collection('Snacks').doc().set(snacks.toJson());

  }

}