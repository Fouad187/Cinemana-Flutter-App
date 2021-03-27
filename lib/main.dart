import 'package:cinema/Screens/Admin/admin_home.dart';
import 'package:cinema/Screens/Auth/login_screen.dart';
import 'package:cinema/Screens/Auth/owner_register.dart';
import 'package:cinema/Screens/Auth/registeration_screen.dart';
import 'package:cinema/Screens/CinemaOwner/my_films.dart';
import 'package:cinema/Screens/CinemaOwner/my_halls.dart';
import 'package:cinema/Screens/CinemaOwner/my_snacks.dart';
import 'package:cinema/Screens/CinemaOwner/owner_home.dart';
import 'package:cinema/Screens/CinemaOwner/tickets_history.dart';
import 'package:cinema/Screens/User/payment_screen.dart';
import 'package:cinema/Screens/User/user_cinema.dart';
import 'package:cinema/Screens/User/user_films.dart';
import 'package:cinema/Screens/User/user_home.dart';
import 'package:cinema/Screens/User/user_tickets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Providers/model_hud.dart';
import 'Providers/user_data.dart';
import 'file:///D:/FCIS_2020/Rab3aaa/Gp/cinema/lib/Screens/Auth/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Modelhud>(create: (context) => Modelhud(),),
        ChangeNotifierProvider<UserData>(create: (context) => UserData(),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: OnboardingScreen.id,
        routes: {
          OnboardingScreen.id:(context) => OnboardingScreen(),
          LoginScreen.id:(context)=>LoginScreen(),
          RegisterScreen.id:(context)=>RegisterScreen(),
          OwnerRegisterScreen.id:(context)=>OwnerRegisterScreen(),

          //Cinema Owner
          OwnerHomeScreen.id:(context)=>OwnerHomeScreen(),
          MyFilmsScreen.id:(context)=>MyFilmsScreen(),
          MyHallScreen.id:(context)=>MyHallScreen(),
          MySnacksScreen.id:(context)=>MySnacksScreen(),
          TicketHistoryScreen.id:(context)=>TicketHistoryScreen(),



          //Admin
          AdminHomeScreen.id:(context)=>AdminHomeScreen(),


          //User
          UserHomeScreen.id:(context)=>UserHomeScreen(),
          UserCinemaScreen.id:(context)=>UserCinemaScreen(),
          UserFilmsScreen.id:(context)=>UserFilmsScreen(),
          UserTicketScreen.id:(context)=>UserTicketScreen(),
          PaymentScreen.id:(context)=>PaymentScreen(),
        },
      ),
    );
  }
}
