import 'package:admin_traincanteen/screen/add_restaurant/add_restaurant.dart';
import 'package:admin_traincanteen/screen/auth/login_screen.dart';
import 'package:admin_traincanteen/screen/auth/sign_up_screen.dart';
import 'package:admin_traincanteen/screen/homeScreen.dart';
import 'package:admin_traincanteen/utils/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  LoginScreen(),
      routes: {
        //LandingScreen.routeName: (context) => LandingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
         AddRestaurant.routeName: (context) => AddRestaurant(),
        // SendOTPScreen.routeName: (context) => SendOTPScreen(),
        // NewPwScreen.routeName: (context) => NewPwScreen(),
        // IntroScreen.routeName: (context) => IntroScreen(),
         HomeScreen.routeName: (context) => HomeScreen(),
        // MenuScreen.routeName: (context) => MenuScreen(),
        // OfferScreen.routeName: (context) => OfferScreen(),
        // ProfileScreen.routeName: (context) => ProfileScreen(),
        // MoreScreen.routeName: (context) => MoreScreen(),
        // DessertScreen.routeName: (context) => DessertScreen(),
        // IndividualItem.routeName: (context) => IndividualItem(),
        // PaymentScreen.routeName: (context) => PaymentScreen(),
        // NotificationScreen.routeName: (context) => NotificationScreen(),
        // AboutScreen.routeName: (context) => AboutScreen(),
        // InboxScreen.routeName: (context) => InboxScreen(),
        // MyOrderScreen.routeName: (context) => MyOrderScreen(),
        // CheckoutScreen.routeName: (context) => CheckoutScreen(),
        // ChangeAddressScreen.routeName: (context) => ChangeAddressScreen(),
      },
    );
  }
}


