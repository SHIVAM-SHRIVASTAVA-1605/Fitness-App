import 'package:fitness_app/login_page.dart';
import 'package:fitness_app/second_page.dart';
import 'package:fitness_app/signup_page.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.asset("assets/images/image1.jpg",
              fit: BoxFit.fitWidth,),
            ),
            SizedBox(height: 20,),
            Text("Start your,",style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold,
            ),),
            Text("Fitness Journey",style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold,color: Colors.red,
            ),),
            SizedBox(height :30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage())); // Navigate to login screen
              },
              child: Text('LOGIN'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                minimumSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignUpPage())); // Navigate to sign-up screen
              },
              child: Text(
                "DON'T HAVE ACCOUNT? SIGN UP",
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
