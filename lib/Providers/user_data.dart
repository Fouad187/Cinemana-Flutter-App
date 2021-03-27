import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier
{
  UserModel user=UserModel();
  Cinema cinema=Cinema();

  setUser(UserModel mod)
  {
    this.user=mod;
  }

  setCinema(Cinema cin)
  {
    this.cinema=cin;
  }


}