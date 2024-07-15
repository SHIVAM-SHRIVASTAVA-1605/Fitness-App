import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'workout_detail_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _workouts = [
    {'title': 'Crossfit', 'image': 'assets/images/crossfit.jpeg', 'tags': ['most popular', 'highly recommended']},
    {'title': 'Gym', 'image': 'assets/images/gym.jpeg', 'tags': ['latest', 'most popular']},
    {'title': 'Running', 'image': 'assets/images/running.jpeg', 'tags': ['latest']},
    {'title': 'Yoga', 'image': 'assets/images/yoga.jpeg', 'tags': ['old but gold']},
    {'title': 'Swimming', 'image': 'assets/images/crossfit.jpeg', 'tags': ['highly recommended']},
    {'title': 'Cycling', 'image': 'assets/images/running.jpeg', 'tags': ['most popular']},
    {'title': 'Pilates', 'image': 'assets/images/yoga.jpeg', 'tags': ['old but gold']},
  ];

  List<Map<String, dynamic>> _filteredWorkouts = [];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _filteredWorkouts = _workouts;
    _searchController.addListener(_filterWorkouts);
    _tabController = TabController(length: 5, vsync: this); // Updated length to 5
    _tabController?.addListener(_filterWorkouts);
  }

  void _filterWorkouts() {
    String searchText = _searchController.text.toLowerCase();
    String selectedTag = _tabTags[_tabController!.index];

    setState(() {
      _filteredWorkouts = _workouts.where((workout) {
        bool matchesSearch = workout['title']!.toLowerCase().contains(searchText);
        bool matchesTag = selectedTag == 'All' || workout['tags']!.contains(selectedTag);
        return matchesSearch && matchesTag;
      }).toList();
    });
  }

  final List<String> _tabTags = [
    'All',
    'most popular',
    'latest',
    'old but gold',
    'highly recommended'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/image1.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text(
                    'SEARCH WORKOUTS',
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search workouts...',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.filter_list),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    tabs: _tabTags.map((tag) => Tab(text: tag)).toList(),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredWorkouts.length,
                      itemBuilder: (context, index) {
                        return _buildTabContent(
                          _filteredWorkouts[index]['title']!,
                          _filteredWorkouts[index]['image']!,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkoutDetailPage(
              title: title,
              imagePath: imagePath,
            )),
          );
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
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
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController?.dispose();
    super.dispose();
  }
}
