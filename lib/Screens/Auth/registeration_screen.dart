import 'package:cinema/Providers/model_hud.dart';
import 'package:cinema/Screens/Auth/owner_register.dart';
import 'package:cinema/Screens/CinemaOwner/owner_home.dart';
import 'package:cinema/Screens/User/user_home.dart';
import 'package:cinema/Services/auth.dart';
import 'package:cinema/Widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
class RegisterScreen extends StatefulWidget {
  static String id='RegisterScreenid';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name,email,password;

  String selectedcity='Riyadh';

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Auth auth=Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<Modelhud>(context).ischange,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              SizedBox(height: 10,),
              SvgPicture.asset('images/logo3.svg', width: 150, height: 150,),
              Center(child: Text('Cinemana' , style:TextStyle( fontSize: 25 , fontWeight: FontWeight.bold ,) ,)),
              SizedBox(height: 30,),
              CustomText(
                Onclick:(value)
                {
                  name=value;
                },
                hint: 'Name',
                icon: Icons.account_box,
                passwordornot: false,

              ),
              SizedBox(height: 20,),
              CustomText(
                Onclick:(value)
                {
                  email=value;
                },
                hint: 'Email',
                icon: Icons.email,
                passwordornot: false,

              ),
              SizedBox(height: 20,),
              CustomText(
                Onclick:(value)
                {
                  password=value;
                },
                hint: 'Password',
                icon: Icons.lock,
                passwordornot: true,

              ),
              SizedBox(height: 5,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Text('City : ' , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),),
                    SizedBox(width: 10,),
                    DropdownButton(items: getitem(cities), value:selectedcity, onChanged: (value){
                      setState(() {
                        selectedcity=value;
                      });
                    }),
                  ],
                ),
              ),
               Padding(
                  padding: EdgeInsets.only(left: 60 , right: 60),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Kcolor,
                    onPressed: () async {
                      final instance =
                      Provider.of<Modelhud>(context, listen: false);
                      instance.changeisLoading(true);
                      if (_globalKey.currentState.validate())
                      {
                        _globalKey.currentState.save();
                          try {
                            await auth.CreateAccount(name: name,
                                type: 'User',
                                email: email,
                                password: password,
                                city : selectedcity,
                                context: context,
                            );
                            Navigator.pushNamedAndRemoveUntil(context, UserHomeScreen.id, (route) => false);
                            instance.changeisLoading(false);
                          }
                          catch (e) {
                            instance.changeisLoading(false);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Email Must be Uniqe")));
                          }
                      }
                      instance.changeisLoading(false);
                    },
                    child: Text('Register' , style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(height: 5,),
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You Have a Cinema ? ', style: TextStyle(color: Colors.black , fontSize: 17),),
                    GestureDetector(
                      child: Text('Register from here', style: TextStyle(fontSize: 18 , color: Kcolor),),
                      onTap: (){
                        Navigator.pushNamed(context, OwnerRegisterScreen.id);
                      },
                    ),
                  ],
                ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}