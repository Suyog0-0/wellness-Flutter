import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'profile_screen.dart';
import 'quotes_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  int _currentQuoteIndex = 0;

  final List<Map<String, dynamic>> todayStats = [
    {'title': 'Steps', 'value': '8,432', 'icon': Icons.directions_walk, 'color': Colors.blue},
    {'title': 'Water', 'value': '6/8 cups', 'icon': Icons.water_drop, 'color': Colors.cyan},
    {'title': 'Sleep', 'value': '7h 30m', 'icon': Icons.bedtime, 'color': Colors.purple},
    {'title': 'Meditation', 'value': '15 min', 'icon': Icons.self_improvement, 'color': Colors.green},
  ];

  final List<Map<String, String>> motivationalQuotes = [
    {
      'quote': 'Take care of your body. It\'s the only place you have to live.',
      'author': 'Jim Rohn'
    },
    {
      'quote': 'Health is not about the weight you lose, but about the life you gain.',
      'author': 'Dr. Josh Axe'
    },
    {
      'quote': 'Your body can stand almost anything. It\'s your mind you have to convince.',
      'author': 'Unknown'
    },
    {
      'quote': 'The groundwork for all happiness is good health.',
      'author': 'Leigh Hunt'
    },
    {
      'quote': 'To keep the body in good health is a duty... otherwise we shall not be able to keep our mind strong and clear.',
      'author': 'Buddha'
    },
  ];

  @override
  void initState() {
    super.initState();
    // Auto-rotate quotes every 5 seconds
    _startQuoteRotation();
  }

  void _startQuoteRotation() {
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _currentQuoteIndex = (_currentQuoteIndex + 1) % motivationalQuotes.length;
        });
        _startQuoteRotation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Good Morning, Alex!'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: _selectedIndex == 0 ? _buildDashboardContent() : ProfileScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today's Progress
          Text(
            'Today\'s Progress',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          // Stats Grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemCount: todayStats.length,
            itemBuilder: (context, index) {
              final stat = todayStats[index];
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xFF262626),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      stat['icon'],
                      size: 32.w,
                      color: stat['color'],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      stat['value'],
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      stat['title'],
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 30.h),

          // Quick Actions
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: _buildActionCard('Start Meditation', Icons.self_improvement, Colors.green),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildActionCard('Log Water', Icons.water_drop, Colors.blue),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(
                child: _buildActionCard('Track Mood', Icons.mood, Colors.orange),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildActionCard('Set Reminder', Icons.alarm, Colors.purple),
              ),
            ],
          ),
          SizedBox(height: 30.h),

          // Daily Inspiration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily Inspiration',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuotesDetailScreen(quotes: motivationalQuotes),
                    ),
                  );
                },
                child: Text(
                  'See All',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Quote Card with animated transition
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _buildQuoteCard(motivationalQuotes[_currentQuoteIndex]),
          ),
          SizedBox(height: 20.h),

          // Quote indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              motivationalQuotes.length,
                  (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                height: 6.h,
                width: _currentQuoteIndex == index ? 16.w : 6.w,
                decoration: BoxDecoration(
                  color: _currentQuoteIndex == index ? Colors.white : Colors.grey,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Manual navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentQuoteIndex = (_currentQuoteIndex - 1 + motivationalQuotes.length) % motivationalQuotes.length;
                  });
                },
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentQuoteIndex = (_currentQuoteIndex + 1) % motivationalQuotes.length;
                  });
                },
                icon: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(Map<String, String> quote) {
    return Container(
      key: ValueKey(quote['quote']),
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Color(0xFF262626),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.format_quote,
                size: 24.w,
                color: Colors.white,
              ),
              Spacer(),
              Text(
                '${_currentQuoteIndex + 1}/${motivationalQuotes.length}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            quote['quote'] ?? '',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            '— ${quote['author'] ?? 'Unknown'}',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title clicked!'),
            backgroundColor: color,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Color(0xFF262626),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24.w,
              color: color,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}