import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmi = 0.0;
  String _bmiStatus = '';
  String _bmiRange = '';
  String _bmiAdvice = '';
  @override
  void initState() {
    super.initState();
    if (user != null) {
      _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (userData.exists) {
        Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
        setState(() {
          _heightController.text = data['height'] ?? '';
          _weightController.text = data['weight'] ?? '';
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  void _calculateBMI() {
    double height = double.tryParse(_heightController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      setState(() {
        _bmi = weight / (height * height);
        if (_bmi < 18.5) {
          _bmiStatus = 'Underweight';
          _bmiRange = 'BMI < 18.5';
          double targetWeight = 18.5 * height * height;
          double weightToGain = targetWeight - weight;
          _bmiAdvice = 'You should gain ${weightToGain.toStringAsFixed(1)} kg to reach a normal weight.';
        } else if (_bmi >= 18.5 && _bmi < 24.9) {
          _bmiStatus = 'Normal';
          _bmiRange = 'BMI 18.5 - 24.9';
          _bmiAdvice = 'You are healthy. Keep it up!';
        } else if (_bmi >= 25 && _bmi < 29.9) {
          _bmiStatus = 'Overweight';
          _bmiRange = 'BMI 25 - 29.9';
          double targetWeight = 24.9 * height * height;
          double weightToLose = weight - targetWeight;
          _bmiAdvice = 'You should lose ${weightToLose.toStringAsFixed(1)} kg to reach a normal weight.';
        } else {
          _bmiStatus = 'Obese';
          _bmiRange = 'BMI >= 30';
          double targetWeight = 24.9 * height * height;
          double weightToLose = weight - targetWeight;
          _bmiAdvice = 'You should lose ${weightToLose.toStringAsFixed(1)} kg to reach a normal weight.';
        }
      });
    }
  }

  Future<void> _updateUserData() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'height': _heightController.text,
        'weight': _weightController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User data updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error updating user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update user data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: Container(
        color: Colors.teal[50], // Set background color
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : AssetImage('assets/images/image1.jpg') as ImageProvider,
            ),
            SizedBox(height: 16),
            Text(
              user?.email ?? 'Email not available',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32),
            TextField(
              controller: _heightController,
              decoration: InputDecoration(
                labelText: 'Height (m)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 16),
            Text(
              'Your BMI: ${_bmi.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Status: $_bmiStatus',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Range: $_bmiRange',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              _bmiAdvice,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _updateUserData,
              child: Text('Update Details'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _logout,
        icon: Icon(Icons.logout),
        label: Text('Logout'),
        backgroundColor: Colors.redAccent, // Change to a decent color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
