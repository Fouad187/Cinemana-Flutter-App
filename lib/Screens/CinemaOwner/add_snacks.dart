import 'dart:io';

import 'package:cinema/Providers/model_hud.dart';
import 'package:cinema/Screens/CinemaOwner/owner_home.dart';
import 'package:cinema/Services/owner_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';


class AddSnacks extends StatefulWidget {
  @override
  _AddSnacksState createState() => _AddSnacksState();
}

class _AddSnacksState extends State<AddSnacks> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String name ,price;

  OwnerServices owner=OwnerServices();

  File _pickedimage;

  final ImagePicker _picker=ImagePicker();

  void _pickimage(ImageSource src) async
  {
    final pickedimagefile= await _picker.getImage(source: src);
    if(pickedimagefile != null)
    {
      setState(() {
        _pickedimage=File(pickedimagefile.path);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<Modelhud>(context).ischange,
        child: ListView(
          children: [
            SizedBox(height: 10,),
            Center(child: Text('Add Snacks' , style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold),)),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                _pickimage(ImageSource.gallery);
              },
              child: Center(
                  child: Container(
                    height: 150,
                    width: 100,
                    color: Colors.grey,
                    child: _pickedimage==null ? Icon(Icons.add_a_photo) : Image.file(_pickedimage , fit: BoxFit.fill,),
                  )),
            ),
            Center(child: Text('Snacks Image')),
            SizedBox(height: 5,),
            Form(
              key: _globalKey,
              child: Padding(
                padding: EdgeInsets.only(left: 20 , right: 20 , bottom: 5),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Snacks Name',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15) ,),
                      ),
                      validator: (value){
                        if(value.isEmpty)
                        {
                          return  'Please Enter Snacks name';
                        }
                      },
                      onChanged: (value)
                      {
                        setState(() {
                          name=value;
                        });
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Snacks Price',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15) ,),

                      ),
                      validator: (value){
                        if(value.isEmpty)
                        {
                          return  'Please Enter Snacks Price';
                        }
                      },
                      onChanged: (value)
                      {
                        setState(() {
                          price=value;
                        });
                      },
                    ),
                    SizedBox(height: 15,),
                    Container(
                      width: double.infinity,
                      child: FlatButton(onPressed: () async {
                        final instance =
                        Provider.of<Modelhud>(context, listen: false);
                        instance.changeisLoading(true);
                        if(_globalKey.currentState.validate())
                        {
                          _globalKey.currentState.save();
                          try{
                            if(_pickedimage == null )
                            {
                              instance.changeisLoading(false);
                              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please Select Image')));

                            }else {
                              await owner.AddNewSnacks(
                                image: _pickedimage,
                                price: price,
                                name: name,
                                context: context,
                              );
                              Navigator.pushReplacementNamed(context, OwnerHomeScreen.id);
                              instance.changeisLoading(false);
                            }
                          } catch (e){
                            instance.changeisLoading(false);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.message)));

                          }
                        }
                        instance.changeisLoading(false);
                      },
                        color: Kcolor,
                        child: Text('Add Snacks' , style: TextStyle(color: Colors.white),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
