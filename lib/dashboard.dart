import 'package:flutter/material.dart';
//import 'login_page.dart';
import 'todo_page.dart';
import 'profile_page.dart';
import 'recommend.dart'; // Import the new RecommendPage

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 0.75);

  final List<Map<String, dynamic>> _features = [
    {
      'title': 'Tell me which crop is best',
      'subtitle':
          'AI-powered crop recommendations based on your soil, weather, and region',
      'icon': Icons.agriculture,
      'buttonText': 'RECOMMEND CROP',
      'route': 'recommend', // Added route identifier
    },
    {
      'title': 'Predict the yield',
      'subtitle': 'Accurate yield forecasting using AI deep learning models',
      'icon': Icons.analytics,
      'buttonText': 'PREDICT YIELD',
      'route': 'predict',
    },
    {
      'title': 'Help me with the market',
      'subtitle': 'Real-time market prices, trends, and best selling periods',
      'icon': Icons.bar_chart,
      'buttonText': 'MARKET INSIGHTS',
      'route': 'market',
    },
    {
      'title': 'Plant Dr.',
      'subtitle': 'Pest & disease detection with AI-powered treatment plans',
      'icon': Icons.medical_services,
      'buttonText': 'SCAN FOR DISEASE',
      'route': 'plantdr',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const emerald = Color(0xFF203D2B);
    const beige = Color(0xFFFAF2D5);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/dash.jpg', fit: BoxFit.cover),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context, beige, emerald),
                const SizedBox(height: 20),
                _buildWeatherAndTasksRow(beige, emerald),
                const SizedBox(height: 20),
                _buildCalendarSection(beige, emerald),
                const SizedBox(height: 20),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _features.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _buildFeatureCard(context, index, beige, emerald);
                    },
                  ),
                ),
                _buildPageIndicators(beige, emerald),
                const SizedBox(height: 10),
                _buildBottomNavigation(context, beige, emerald),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Color beige, Color emerald) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jai Kisaan,',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  color: emerald,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Your AI Farming Assistant',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: emerald.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Showing farm details for 5 acres'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: emerald,
              foregroundColor: beige,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              '5 Acres',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherAndTasksRow(Color beige, Color emerald) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _buildWeatherSection(beige, emerald)),
            const SizedBox(width: 15),
            Expanded(child: _buildTasksSection(beige, emerald)),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherSection(Color beige, Color emerald) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: emerald,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(Icons.wb_sunny, color: beige, size: 24),
              const SizedBox(width: 8),
              Text(
                'Sunny',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: beige,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('24°C', style: TextStyle(fontSize: 14, color: beige)),
        ],
      ),
    );
  }

  Widget _buildTasksSection(Color beige, Color emerald) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: emerald,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Today\'s Tasks',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: beige,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Water crops • Check soil moisture',
            style: TextStyle(fontSize: 12, color: beige),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection(Color beige, Color emerald) {
    final now = DateTime.now();
    const totalDays = 30;
    const daysPerPage = 5;
    final pageCount = (totalDays / daysPerPage).ceil();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: emerald,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calendar',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: beige,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 45,
              child: PageView.builder(
                itemCount: pageCount,
                itemBuilder: (context, pageIndex) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(daysPerPage, (i) {
                      final dayIndex = pageIndex * daysPerPage + i;
                      if (dayIndex >= totalDays) {
                        return const SizedBox.shrink();
                      }
                      final date = now.subtract(Duration(days: 14 - dayIndex));
                      final isToday =
                          date.day == now.day &&
                          date.month == now.month &&
                          date.year == now.year;
                      final dayAbbr = [
                        'Mon',
                        'Tue',
                        'Wed',
                        'Thu',
                        'Fri',
                        'Sat',
                        'Sun',
                      ][date.weekday % 7];
                      return Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isToday ? beige : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: beige.withOpacity(0.3)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dayAbbr,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isToday ? emerald : beige,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                '${date.day}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isToday ? emerald : beige,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    int index,
    Color beige,
    Color emerald,
  ) {
    final feature = _features[index];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: emerald,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(feature['icon'], size: 48, color: beige),
          const SizedBox(height: 12),
          Text(
            feature['title'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: beige,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            feature['subtitle'],
            style: TextStyle(
              fontSize: 12,
              color: beige.withOpacity(0.8),
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Handle navigation based on the feature
              if (feature['route'] == 'recommend') {
                // Navigate to RecommendPage for crop recommendations
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecommendPage(),
                  ),
                );
              } else {
                // For other features, show a snackbar for now
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${feature['buttonText']} feature coming soon!',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: beige,
              foregroundColor: emerald,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              feature['buttonText'],
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: emerald,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicators(Color beige, Color emerald) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _features.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index ? beige : emerald.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(
    BuildContext context,
    Color beige,
    Color emerald,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: emerald,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ToDoPage()),
              );
            },
            icon: Icon(Icons.list, color: beige, size: 24),
            tooltip: 'To-Do',
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            icon: Icon(Icons.person, color: beige, size: 24),
            tooltip: 'Profile',
          ),
        ],
      ),
    );
  }
}
