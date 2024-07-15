import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
