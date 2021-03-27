import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Models/film_model.dart';
import 'package:cinema/Models/hall_model.dart';
import 'package:cinema/Models/snacks_model.dart';
import 'package:cinema/Providers/model_hud.dart';
import 'package:cinema/Screens/User/payment_screen.dart';
import 'package:cinema/Services/user_services.dart';
import 'package:cinema/Widgets/hall_card.dart';
import 'package:cinema/Widgets/snack_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';


class BookingScreen extends StatefulWidget {
  Cinema cinema;
  Film film;
  BookingScreen({this.cinema , this.film});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String Selectedhall='None';
  String Selectedtime='10 Am';
  String Selectedposition='Front';
  String Selectedsnakcs='None';
  DateTime PicDate;

  List<String> hall=[
    'None'
  ];
  List<String> time=[
    '10 Am',
    '1 Pm',
    '3 Pm',
    '6 Pm',
    '9 Pm',
    '12 Am'
  ];
  List<String> position=[
    'Front',
    'Middle',
    'Back',
    'Roof',
  ];
  List<String> snack=[
    'None',
  ];
  String selected1='None';
  String selected2='10 Am';
  String selected3='Front';
  String selected4='None';
  String numberofseats="";
  String numberofsnacks="";
  String hallprice;
  String snackprice;
  int _currentStep = 0;
  UserServices userServices=UserServices();
  List<Hall> halls=[];
  List<Snacks> snacks=[];
  bool complete=false;
  getdata() async
  {
      halls=await userServices.GetHall(widget.cinema.id);

      for(int i=0 ; i<halls.length; i++)
        {
          hall.add(halls[i].name);
        }
      snacks=await userServices.GetSnacksbyid(widget.cinema.id);
      for(int j=0; j<snacks.length; j++ )
        {
          snack.add(snacks[j].name);
        }
      setState(() {

      });
  }
  CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 12000 * 30;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    PicDate=DateTime.now();
    controller = CountdownTimerController(endTime: endTime, onEnd: (){Navigator.pop(context);});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued() async {
    _currentStep < 2 ? setState(() => _currentStep += 1) : complete=true;
    if(complete)
      {
        final instance=Provider.of<Modelhud>(context , listen: false);
        instance.changeisLoading(true);
        try
        {
          if(Selectedhall=='None')
            {
              Fluttertoast.showToast(msg: 'Please Select Hall' , toastLength: Toast.LENGTH_LONG);
            }
          else {
            await halls.forEach((element) {
              if(element.name==Selectedhall)
                {
                  hallprice=element.ticketprice;
                }
            });
            if(Selectedsnakcs!='None')
              {
                snacks.forEach((element) {
                  if(element.name==Selectedsnakcs)
                    {
                      snackprice=element.price;
                    }
                });
              }
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
              PaymentScreen(
                cinema: widget.cinema,
                film: widget.film,
                numberofseats: numberofseats.isEmpty ? "1": numberofseats,
                numberofsnacks: Selectedsnakcs=='None' ?  '0' : numberofsnacks.isEmpty ? "1" : numberofsnacks,
                PicDate:'${PicDate.year}-${PicDate.month}-${PicDate.day}',
                position: Selectedposition,
                Selectedhall: Selectedhall,
                Selectedsnakcs: Selectedsnakcs,
                Selectedtime: Selectedtime,
                hallprice: numberofseats.isEmpty ? int.parse(hallprice) : int.parse(hallprice)*int.parse(numberofseats),
                snackprice: Selectedsnakcs=='None' ? 0 : numberofsnacks.isEmpty ? int.parse(snackprice) : int.parse(snackprice)*int.parse(numberofsnacks),
              )
              ,));

            instance.changeisLoading(false);
            complete=false;
          }
          instance.changeisLoading(false);
          complete=false;
        }
        catch (e)
        {
          Fluttertoast.showToast(msg: 'Please Fill All Form' , toastLength: Toast.LENGTH_SHORT);
          complete=false;
        }
      }
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }
  @override
  Widget build(BuildContext context) {
    List<Step> steps=[
      Step(
        title: Text('Film'),
        subtitle: Text('Information'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: Text(widget.film.name , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)),
            Text(widget.cinema.cinemaName, style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Row(
              children: [
                Text(widget.cinema.address, style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
                SizedBox(width: 10,),
                Icon(Icons.location_on , color: Kcolor,),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.star , color: Kcolor , size: 16,),
                Icon(Icons.star , color: Kcolor , size: 16,),
                Icon(Icons.star , color: Kcolor , size: 16,),
                Icon(Icons.star , color: Kcolor , size: 16,),
                Icon(Icons.star , color: Kcolor , size: 16,),
                SizedBox(width: 10,),
                Text('(${widget.cinema.rating} Reviews)' , style: TextStyle(color: Colors.grey),),
              ],
            ),
          ],
        ),
        isActive: _currentStep >= 0,
        state: _currentStep >= 0 ?
        StepState.complete : StepState.disabled,
      ),
      Step(
        title:  Text('Halls'),
        subtitle: Text('Select Your Hall'),
        content: Column(
          children: <Widget>[
            halls.length > 0 ? Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: halls.length,
                itemBuilder: (context, index) {
                  return HallCard(hall: halls[index],);
                },),
            ) : Container(),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Hall : ' , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),),
                    SizedBox(width: 10,),
                    DropdownButton(items: getitem(hall), value:selected1, onChanged: (value){
                      setState(() {
                        selected1=value;
                        Selectedhall=value;
                      });
                    }),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text('Time : ' , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                DropdownButton(items: getitem(time), value:selected2, onChanged: (value){
                  setState(() {
                    selected2=value;
                    Selectedtime=value;
                  });
                }),
              ],
            ),
            Row(
              children: [
                Text('Position : ' , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                DropdownButton(items: getitem(position), value:selected3, onChanged: (value){
                  setState(() {
                    selected3=value;
                    Selectedposition=value;
                  });
                }),
              ],
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text('Date : ${PicDate.year} , ${PicDate.month} , ${PicDate.day} ',style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.date_range),
              onTap: _picdate,
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(labelText: 'Number of Seats' ,),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value){
                setState(() {
                  numberofseats=value;
                });
              },
            ),
          ],
        ),
        isActive: _currentStep >= 0,
        state: _currentStep >= 1 ?
        StepState.complete : StepState.disabled,
      ),
      Step(
        title:  Text('Snacks'),
        subtitle: Text('Select your Snakcs'),
        content: Column(
          children: <Widget>[
            snacks.length > 0 ? Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snacks.length,
                itemBuilder: (context, index) {
                  return SnacksCard(snacks: snacks[index],);
                },),
            ) : Container(),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Snacks : ' , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                DropdownButton(items: getitem(snack), value:selected4, onChanged: (value){
                  setState(() {
                    selected4=value;
                    Selectedsnakcs=value;
                  });
                }),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Number of snacks'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value)
              {
                setState(() {
                  numberofsnacks=value;
                });
              },
            ),
          ],
        ),
        isActive:_currentStep >= 0,
        state: _currentStep >= 2 ?
        StepState.complete : StepState.disabled,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Your Tickets'),
        centerTitle: true,
        backgroundColor: Kcolor,
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(child: CountdownTimer(
                onEnd: (){
                  Navigator.pop(context);
                },
                endTime: endTime,
              controller: controller,
              ),
            ),
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<Modelhud>(context).ischange,
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(
                    primaryColor: Kcolor,
                  ),
                  child: Stepper(
                    steps: steps,
                    physics: ClampingScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue:  continued,
                    onStepCancel: cancel,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _picdate() async
  {
    DateTime dateTime=await showDatePicker(
      context: context,
      initialDate: PicDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year+1),
    );
    if(dateTime !=null)
    {
      setState(() {
        PicDate=dateTime;
      });
    }

  }
}

