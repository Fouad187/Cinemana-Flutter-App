import 'package:cinema/Models/cinema_model.dart';
import 'package:cinema/Models/film_model.dart';
import 'package:cinema/Providers/model_hud.dart';
import 'package:cinema/Screens/User/user_home.dart';
import 'package:cinema/Services/user_services.dart';
import 'package:cinema/Widgets/payment_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_number_input_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class PaymentScreen extends StatelessWidget {
  static String id='PaymentScreenid';

  final Cinema cinema;
  final Film film;
  final String Selectedhall;
  final String Selectedtime;
  final String position;
  final String numberofseats;
  final String Selectedsnakcs;
  final String numberofsnacks;
  final String PicDate;
  final int hallprice;
  final int snackprice;
  PaymentScreen({this.cinema,this.hallprice , this.snackprice , this.numberofsnacks , this.Selectedsnakcs , this.numberofseats , this.PicDate , this.film, this.position , this.Selectedhall , this.Selectedtime});
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserServices userServices=UserServices();
    final Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<Modelhud>(context).ischange,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width,
                height: size.height*0.1,
                color: Colors.blue,
                child: Center(child: Text('Payment Methods' , style: TextStyle(color: Colors.white , fontSize: 20),)),
              ),
              Container(
                width: size.width,
                height: size.height*0.15,
                color: Colors.grey.shade200,
                child: ListView.builder(
                  itemCount: paymentsway.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return PaymentCard(
                      image: paymentsway[index].image,
                      name: paymentsway[index].name,
                    );
                  },
                ),
              ),
              Expanded(child: Container(width: size.width,
               padding: EdgeInsets.all(35),
               child: SingleChildScrollView(
                 child: Form(
                   key: _globalKey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('CARD NUMBER', style: TextStyle(color: Colors.grey.shade400),),
                       SizedBox(height: 5,),
                       TextFormField(
                         inputFormatters: [
                           CreditCardNumberInputFormatter()
                         ],
                         validator: (value)
                         {
                           if(value.isEmpty)
                             {
                               return 'Please Fill Card';
                             }
                         },
                         style: TextStyle(fontSize: 20),
                         decoration: InputDecoration(
                           hintText: 'XXXX XXXX XXXX XXXX',
                           hintStyle: TextStyle(fontSize: 20),
                           enabledBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                 color: Colors.grey.shade500,
                               )
                           ),
                           errorBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                 color: Colors.grey.shade500,
                               )
                           ),
                           focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                 color: Colors.grey.shade500,
                               )
                           ),
                         ),
                       ),
                       SizedBox(height: 30,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Flexible(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text('EXPRIRATION DATE', style: TextStyle(color: Colors.grey.shade400),),
                                 SizedBox(height: 5,),
                                 TextFormField(
                                   inputFormatters: [
                                     CreditCardExpirationDateFormatter(),
                                   ],
                                   validator: (value)
                                   {
                                     if(value.isEmpty)
                                     {
                                       return 'Please Fill Expriration date';
                                     }
                                   },
                                   style: TextStyle(fontSize: 18),
                                   decoration: InputDecoration(
                                     hintText: '00/00',
                                     hintStyle: TextStyle(fontSize: 18),
                                     enabledBorder: OutlineInputBorder(
                                         borderSide: BorderSide(
                                           color: Colors.grey.shade500,
                                         )
                                     ),
                                     errorBorder: OutlineInputBorder(
                                         borderSide: BorderSide(
                                           color: Colors.grey.shade500,
                                         )
                                     ),
                                     focusedBorder: OutlineInputBorder(
                                         borderSide: BorderSide(
                                           color: Colors.grey.shade500,
                                         )
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(width: 20,),
                           Flexible(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text('CVV', style: TextStyle(color: Colors.grey.shade400),),
                                 SizedBox(height: 5,),
                                 TextFormField(
                                   inputFormatters: [
                                     CreditCardCvcInputFormatter(),
                                   ],
                                   validator: (value)
                                   {
                                     if(value.isEmpty)
                                     {
                                       return 'Please Fill CVV';
                                     }
                                   },
                                   obscureText: true,
                                   style: TextStyle(fontSize: 18),
                                   decoration: InputDecoration(
                                     hintText: 'XXXX',
                                     hintStyle: TextStyle(fontSize: 18),
                                     enabledBorder: OutlineInputBorder(
                                         borderSide: BorderSide(
                                           color: Colors.grey.shade500,
                                         )
                                     ),
                                     errorBorder: OutlineInputBorder(
                                         borderSide: BorderSide(
                                           color: Colors.grey.shade500,
                                         )
                                     ),
                                     focusedBorder: OutlineInputBorder(
                                         borderSide: BorderSide(
                                           color: Colors.grey.shade500,
                                         )
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                       SizedBox(height: 30,),
                       Text('CARD HOLDER\'s NAME', style: TextStyle(color: Colors.grey.shade400),),
                       SizedBox(height: 5,),
                       TextFormField(
                         style: TextStyle(fontSize: 20),
                         validator: (value)
                         {
                           if(value.isEmpty)
                           {
                             return 'Please Fill Name';
                           }
                         },
                         decoration: InputDecoration(
                           enabledBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                 color: Colors.grey.shade500,
                               )
                           ),

                           focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                 color: Colors.grey.shade500,
                               )
                           ),
                           errorBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                 color: Colors.grey.shade500,
                               )
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
               ),
              )),
              InkWell(
                onTap: () async {
                  final instance=Provider.of<Modelhud>(context , listen: false);
                  instance.changeisLoading(true);
                  if(_globalKey.currentState.validate())
                    {
                      _globalKey.currentState.save();
                      try{
                        await userServices.AddTicket(
                          id: cinema.id,
                          filmname: film.name,
                          cinemaname: cinema.cinemaName,
                          cinemaadress: cinema.address,
                          hallname: Selectedhall,
                          time: Selectedtime,
                          position: position,
                          numberofseats: numberofseats,
                          snackname: Selectedsnakcs,
                          numberofsnacks: numberofsnacks,
                          ticketdate: PicDate,
                          total: snackprice+hallprice,
                          context: context,
                        );
                        instance.changeisLoading(false);
                        Navigator.pushNamedAndRemoveUntil(context, UserHomeScreen.id, (route) => false);
                        Fluttertoast.showToast(msg: 'Congrats You booked Check Your Tickets' , toastLength: Toast.LENGTH_LONG);
                      }catch(e){
                        instance.changeisLoading(false);
                        Fluttertoast.showToast(msg: 'Something was wrong' , toastLength: Toast.LENGTH_LONG);
                      }
                    }
                  instance.changeisLoading(false);

                },
                child: Container(
                  width: size.width,
                  height: size.height*0.1,
                  color: Colors.green,
                  child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('CONFIRM PAYMENT' , style: TextStyle(color: Colors.white , fontSize: 22),),
                      Text('Total ${snackprice+hallprice} LE' , style: TextStyle(color: Colors.white),),
                    ],
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
