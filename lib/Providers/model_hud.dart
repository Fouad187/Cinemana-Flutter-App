
import 'package:flutter/cupertino.dart';

class Modelhud extends ChangeNotifier
{

  bool ischange = false ;

  changeisLoading(bool value)
  {
    ischange=value;
    notifyListeners();
  }
}