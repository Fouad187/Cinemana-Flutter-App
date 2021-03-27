import 'package:flutter_svg/avd.dart';

class Cinema
{
  String id;
  String cinemaName;
  String image;
  String address;
  String rating;
  String status;
  String minticketprice;
  String city;
  Cinema({this.id, this.cinemaName, this.image, this.address, this.rating , this.status ,this.city , this.minticketprice});

  Cinema.fromJson(Map<dynamic,dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else
      {
        id=map['id'];
        cinemaName=map['cinemaname'];
        image=map['image'];
        address=map['address'];
        rating=map['rating'];
        status=map['status'];
        city=map['city'];
        minticketprice=map['minticketprice'];
      }
  }

  toJson()
  {
    return {
      'id' : id,
      'cinemaname':cinemaName,
      'image':image,
      'address':address,
      'rating' : rating,
      'status':status,
      'city':city,
      'minticketprice':minticketprice,
    };
  }
}