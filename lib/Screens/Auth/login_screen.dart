import 'package:cinema/Providers/model_hud.dart';
import 'package:cinema/Services/auth.dart';
import 'package:cinema/Widgets/customtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import 'registeration_screen.dart';

class LoginScreen extends StatelessWidget {
  static String id='LoginScreenid';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String email,password;
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
              SizedBox(height: 50,),
              SvgPicture.asset('images/logo3.svg', width: 150, height: 150,),
              Center(child: Text('Cinemana' , style:TextStyle( fontSize: 25 , fontWeight: FontWeight.bold ,) ,)),
              SizedBox(height: 30,),
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
              SizedBox(height: 20,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
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
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                          try
                          {
                            await auth.Signin(email: email , password: password , context: context);

                          }
                          catch (e) {
                            instance.changeisLoading(false);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Wrong Email or Password")));
                          }
                      }
                      instance.changeisLoading(false);
                    },
                    child: Text('Login' , style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account ? ', style: TextStyle(color: Colors.black , fontSize: 17),),
                    GestureDetector(
                      child: Text('Register Now', style: TextStyle(fontSize: 18 , color: Kcolor),),
                      onTap: (){
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
