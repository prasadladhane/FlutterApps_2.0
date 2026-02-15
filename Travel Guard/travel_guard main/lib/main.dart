import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:registerpage/view/userSide_ui/availability.dart';
import 'package:registerpage/view/userSide_ui/customer_home_page.dart';
import 'package:registerpage/controller/loginpage.dart';
import 'package:registerpage/controller/register_customer.dart';
import 'package:registerpage/controller/register_serviceprovider.dart';
import 'package:registerpage/view/serviceProviderSide_ui/home_serviceprovider.dart';
import 'package:registerpage/view/splash.dart';

dynamic database;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCVB3U2Ui1bttHydbWniopJ1wsielofhwU",
      appId: "1:613437899473:android:df73ff5286072621c87bf0",
      messagingSenderId: "61343789947",
      projectId: "travelguard-b91ad",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Travel Guard",
      debugShowCheckedModeBanner: false,
      home: const StartScreen(),
      routes: {
        '/Availabilty': (context) => const Availability(
              userLocation: '', userproblem: '',
            ),
        '/LoginPage': (context) => const Login(),
        '/CustomerHomePage': (context) => const CustomerHomePage(
              email: 'email',
            ),
        '/SeriveProvider': (context) => const ServiceProviderHome(),
        './StartScreen': (context) => const StartScreen(),
        './Registercustomer': (context) => const RegisterCustomerForm(),
        './ServiceProvider': (context) => const RegisterServiceProviderForm(),
      },
    );
  }
}