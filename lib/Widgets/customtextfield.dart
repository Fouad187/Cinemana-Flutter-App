import 'package:cinema/constant.dart';
import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  CustomText({@required this.Onclick ,@required this.hint , @required this.icon , this.passwordornot , this.initial});
  final String hint ;
  final IconData icon;
  final bool passwordornot;
  final Function Onclick;
  final initial;
  String _errormessage(String x){

    switch(x)
    {
      case 'Email' : return 'Please Enter your email';
      case 'Password' : return 'Please Enter your password';
      case 'Name' : return 'Please Enter your name';
      case 'Cinema Name': return 'Please Enter Cinema name';
      case 'Address' : return 'Please Enter Address';
      case 'Rating' : return 'Please Enter Rating';
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          validator: (value){
            if(value.isEmpty)
            {
              return  _errormessage(hint);
            }
          },

          onChanged: Onclick,
          initialValue: initial,
          obscureText: passwordornot,
          cursorColor: Kcolor,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: Kcolor,
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.black54,
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.black54,
                )
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.white,
                )
            ),
          ),
        ),
    );
  }
}