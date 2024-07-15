import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_page.dart';
import 'accounts_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SecondPage(),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ActivitiesPage(),
    SearchPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'WORKOUT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_sharp),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'ACCOUNTS',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ActivitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'ACTIVITIES',
              style: GoogleFonts.roboto(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WorkoutDetailPage(
                            title: 'Crossfit',
                            imagePath: 'assets/images/crossfit.jpeg',
                          )),
                        );
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('assets/images/crossfit.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'CROSSFIT',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => WorkoutDetailPage(
                                  title: 'Gym',
                                  imagePath: 'assets/images/gym.jpeg',
                                )),
                              );
                            },
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/gym.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'GYM',
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => WorkoutDetailPage(
                                  title: 'Running',
                                  imagePath: 'assets/images/running.jpeg',
                                )),
                              );
                            },
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/running.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'RUNNING',
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WorkoutDetailPage(
                            title: 'Yoga',
                            imagePath: 'assets/images/yoga.jpeg',
                          )),
                        );
                      },
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('assets/images/yoga.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'YOGA',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutDetailPage extends StatelessWidget {
  final String title;
  final String imagePath;

  WorkoutDetailPage({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    title,
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DefaultTabController(
                  length: 3,
                  child: Expanded(
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white54,
                          indicatorColor: Colors.blue,
                          tabs: [
                            Tab(text: 'Description'),
                            Tab(text: 'Feedback'),
                            Tab(text: 'Related'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'This is the description of the $title workout. It includes details about the exercises, benefits, and more.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Feedback will be displayed here.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Related workouts will be displayed here.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Begin Train for \$50.00',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          side: BorderSide(color: Colors.green),
                        ),
                        child: Text(
                          'Begin Train Demo',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
