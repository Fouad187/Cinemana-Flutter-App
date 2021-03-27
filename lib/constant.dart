import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color Kcolor =Color(0xFFD20309);


List<String> cities=[
  'Riyadh',
  'Jeddah',
  'Dammam',
  'Medina',
  'Cairo',
  'Alex',
  '6 October',
  'Al Khobar',
  'Najran',
  'Abha',
  'Dhahran',
  'Mansoura',
  'Giza',
  'Tabuk',
  'Al-Kharij',
  'Taif',
];
List<String> allcities=[
  'All',
  'Riyadh',
  'Jeddah',
  'Dammam',
  'Medina',
  'Cairo',
  'Alex',
  '6 October',
  'Al Khobar',
  'Najran',
  'Abha',
  'Dhahran',
  'Mansoura',
  'Giza',
  'Tabuk',
  'Al-Kharij',
  'Taif',
];


List<DropdownMenuItem> getitem(List<String> list)
{
  List<DropdownMenuItem> dropdownmenuitem=[];
  for(int i=0 ; i<list.length; i++)
  {
    String type=list[i];
    var newitem=DropdownMenuItem(
      child: Text(type , style: TextStyle(color: Kcolor),) ,
      value: type,
    );
    dropdownmenuitem.add(newitem);
  }
  return dropdownmenuitem;
}


class payment
{
  String image;
  String name;

  payment({this.image, this.name});
}


List<payment> paymentsway=[
  payment(image: 'images/visa.png' , name: 'Visa'),
  payment(image: 'images/mastercard.png' , name: 'MasterCard'),
  payment(image: 'images/discover.png' , name: 'Discover'),
  payment(image: 'images/paypal.png' , name: 'Pay Pal'),
];