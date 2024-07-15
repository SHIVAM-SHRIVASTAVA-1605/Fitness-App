import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/first_screen.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'accounts_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(), // Replace with your first screen
        '/account': (context) => AccountPage(), // Replace with your account page
      },
    );
  }
}