import 'dart:ffi';

import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Models/film_model.dart';
import 'package:cinema/Models/hall_model.dart';
import 'package:cinema/Models/snacks_model.dart';
import 'package:cinema/Models/ticket_model.dart';
import 'package:cinema/Models/user_model.dart';
import 'package:cinema/Providers/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class UserServices
{

  Future<List<Film>> GetNewFilm() async
  {
    List<Film> film=[];
     await FirebaseFirestore.instance.collection('Films').limit(10).get().then((value) => {

       for(int i=0 ; i<value.docs.length; i++)
         {
           film.add(Film.fromJson(value.docs[i].data())),
         }

     });
     return film;
  }

  Future<List<Cinema>> GetPopularCinema() async
  {
    List<Cinema> cinema=[];
    await FirebaseFirestore.instance.collection('Cinema').where('status' , isEqualTo: 'Accepted').limit(10).get().then((value)
    {
      for(int i=0 ; i<value.docs.length ; i++)
        {
          cinema.add(Cinema.fromJson(value.docs[i].data()));
        }
    });

    return cinema;
  }

 Future<List<Hall>> GetHall(String id) async
 {
   List<Hall> halls=[];
   await FirebaseFirestore.instance.collection('Halls').where('id' , isEqualTo: id).get().then((value) {
     for(int i=0 ; i<value.docs.length ; i++)
       {
         halls.add(Hall.fromJson(value.docs[i].data()));
       }
   });
   return halls;
 }
 Future<List<Film>> GetFilmbyid(String id) async
 {
   List<Film> film=[];
   await FirebaseFirestore.instance.collection('Films').where('id' , isEqualTo: id).get().then((value) => {

     for(int i=0 ; i<value.docs.length; i++)
       {
         film.add(Film.fromJson(value.docs[i].data())),
       }

   });
   return film;
 }

 Future<List<Snacks>> GetSnacksbyid(String id) async
 {
   List<Snacks> snack=[];
   await FirebaseFirestore.instance.collection('Snacks').where('id' , isEqualTo: id).get().then((value) => {

     for(int i=0 ; i<value.docs.length; i++)
       {
         snack.add(Snacks.fromJson(value.docs[i].data())),
       }

   });
   return snack;
 }
 Future<Cinema> GetCinemaById(String id) async
 {
   Cinema cinema=Cinema();
   await FirebaseFirestore.instance.collection('Cinema').doc(id).get().then((value) {

     cinema=Cinema.fromJson(value.data());
   });

   return cinema;
 }
 void AddTicket({String id, String filmname, String cinemaname, String cinemaadress , String hallname, String time , String position,String numberofseats,String snackname,String numberofsnacks ,String ticketdate, int total , context}) async
 {
   UserModel user=Provider.of<UserData>(context , listen: false).user;
   Ticket ticket=Ticket(
     id: id,
     senderId: user.id,
     filmName: filmname,
     cinemaName: cinemaname,
     cinemaAddress: cinemaadress,
     hallName: hallname,
     filmTime: time,
     position: position,
     numberofSeats: numberofseats,
     numberofsnacks: numberofsnacks,
     snacksName: snackname,
     date: DateTime.now(),
     ticketdate: ticketdate,
     total: total,
     status: 'In Review',
   );

   await FirebaseFirestore.instance.collection('Tickets').doc().set(ticket.toJson());
 }

  Future<List<Cinema>> GetAllCinemaa() async
  {
    List<Cinema> cinema=[];
    await FirebaseFirestore.instance.collection('Cinema').where('status' , isEqualTo: 'Accepted').get().then((value)
    {
      for(int i=0 ; i<value.docs.length ; i++)
      {
        cinema.add(Cinema.fromJson(value.docs[i].data()));
      }
    });

    return cinema;
  }

  Future<List<Cinema>> getCinemaByCity(String city) async
  {
    if(city=='All')
      {
        return GetAllCinemaa();
      }
    else {
      List<Cinema> cinema=[];
      await FirebaseFirestore.instance.collection('Cinema').where('status' , isEqualTo: 'Accepted').where('city', isEqualTo: city).get().then((value)
      {
        for(int i=0 ; i<value.docs.length ; i++)
        {
          cinema.add(Cinema.fromJson(value.docs[i].data()));
        }
      });
      return cinema;
    }
  }

  Future<List<Film>> GetAllFilms() async
  {
    List<Film> film=[];
    await FirebaseFirestore.instance.collection('Films').get().then((value) => {

      for(int i=0 ; i<value.docs.length; i++)
        {
          film.add(Film.fromJson(value.docs[i].data())),
        }

    });
    return film;
  }
}