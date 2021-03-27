
import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Models/user_model.dart';
import 'package:cinema/Providers/model_hud.dart';
import 'package:cinema/Providers/user_data.dart';
import 'package:cinema/Screens/Admin/admin_home.dart';
import 'package:cinema/Screens/CinemaOwner/owner_home.dart';
import 'package:cinema/Screens/User/user_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
class Auth
{

  FirebaseAuth _auth=FirebaseAuth.instance;
  final CollectionReference _userCollection=FirebaseFirestore.instance.collection('Users');
  final CollectionReference _cinemaCollection=FirebaseFirestore.instance.collection('Cinema');



  void Signin({String email , String password , context}) async
 {
     await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
       _userCollection.doc(value.user.uid).get().then((value2) {
         var type = (value2)['type'];
         UserModel userModel=UserModel(
           email: (value2)['email'],
           id: value.user.uid,
           name: (value2)['name'],
           type: (value2)['type'],
         );
         final instance = Provider.of<Modelhud>(context, listen: false);
         Provider.of<UserData>(context , listen: false).setUser(userModel);

         if(type=='User')
           {
             Navigator.pushNamed(context, UserHomeScreen.id);
             instance.changeisLoading(false);
           }
         else if (type=='Cinema Owner')
           {
             _cinemaCollection.doc(value.user.uid).get().then((cinemaa) {
               if((cinemaa)['status']=='In Review')
                 {
                   _auth.signOut();
                   Fluttertoast.showToast(msg: 'Your Request In Review You can Login after accepted' , toastLength: Toast.LENGTH_LONG);
                   instance.changeisLoading(false);
                 }
               else {
                 Cinema cinema = Cinema(
                   rating: (cinemaa)['rating'],
                   address: (cinemaa)['address'],
                   cinemaName: (cinemaa)['cinemaname'],
                   image: (cinemaa)['image'],
                   id: value.user.uid,
                   status: (cinemaa)['status'],
                 );
                 Provider.of<UserData>(context, listen: false).setCinema(
                     cinema);
                 Navigator.pushNamed(context, OwnerHomeScreen.id);
                 instance.changeisLoading(false);
               }
             });
           }
         else
           {
             Navigator.pushNamed(context, AdminHomeScreen.id);
             instance.changeisLoading(false);
           }

       });
     });
 }
  void CreateAccount({String name,String email , String password,String type ,String city,context}) async {

      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user) async {
        UserModel usermodel=UserModel(
          id: user.user.uid,
          name: name,
          email: email,
          type: type,
          city: city,
        );
        await Adduserdata(usermodel);
        Provider.of<UserData>(context , listen: false).setUser(usermodel);
      });

  }

  Future<void> Adduserdata(UserModel userModel) async {
    return await _userCollection.doc(userModel.id).set(userModel.toJson());
  }



  void CreateCinema({String name,String email , String password, String type, String address,String minticketprice , String rating,String city , context}) async
  {

    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user) async {
      UserModel usermodel=UserModel(
        id: user.user.uid,
        name: name,
        email: email,
        type: type,
        city: city,
      );
      await Adduserdata(usermodel);
      Cinema cinema=Cinema(
        id: user.user.uid,
        rating: rating,
        image: 'mm',
        address: address,
        cinemaName: name,
        status: 'In Review',
        city: city,
        minticketprice: minticketprice
      );
      await _cinemaCollection.doc(usermodel.id).set(cinema.toJson());
      Provider.of<UserData>(context , listen: false).setUser(usermodel);
      Provider.of<UserData>(context , listen: false).setCinema(cinema);
    });

  }

  void signOut() async
  {
    await _auth.signOut();
  }


}