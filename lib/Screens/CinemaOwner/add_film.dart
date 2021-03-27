import 'dart:io';

import 'package:cinema/Providers/model_hud.dart';
import 'package:cinema/Screens/CinemaOwner/owner_home.dart';
import 'package:cinema/Services/owner_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class AddFilm extends StatefulWidget {
  @override
  _AddFilmState createState() => _AddFilmState();
}

class _AddFilmState extends State<AddFilm> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String name ,description,category,rating;

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
            Center(child: Text('Add Film' , style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold),)),
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
            Center(child: Text('Film Image')),
            SizedBox(height: 5,),
            Form(
              key: _globalKey,
              child: Padding(
                padding: EdgeInsets.only(left: 20 , right: 20 , bottom: 5),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Film Name',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15) ,),
                      ),
                      validator: (value){
                        if(value.isEmpty)
                        {
                          return  'Please Enter Film name';
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
                          hintText: 'Film Category',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15) ,),

                      ),
                      validator: (value){
                        if(value.isEmpty)
                        {
                          return  'Please Enter Film Category';
                        }
                      },
                      onChanged: (value)
                      {
                        setState(() {
                          category=value;
                        });
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Film Description',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15) ,),

                      ),
                      validator: (value){
                        if(value.isEmpty)
                        {
                          return  'Please Enter Film Description';
                        }
                      },
                      onChanged: (value)
                      {
                        setState(() {
                          description=value;
                        });
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Film Rating',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15) ,),
                      ),
                      validator: (value){
                        if(value.isEmpty)
                        {
                          return  'Please Enter Film Rating';
                        }
                      },
                      onChanged: (value)
                      {
                        setState(() {
                          rating=value;
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

                                }
                              else {
                                await owner.AddNewFilm(
                                    image: _pickedimage,
                                    rating: rating,
                                    description: description,
                                    category: category,
                                    name: name,
                                    context: context
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
                          child: Text('Add Film' , style: TextStyle(color: Colors.white),),
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
