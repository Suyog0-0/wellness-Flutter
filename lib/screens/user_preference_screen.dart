import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dashboard_screen.dart';

class UserPreferenceScreen extends StatefulWidget {
  @override
  _UserPreferenceScreenState createState() => _UserPreferenceScreenState();
}

class _UserPreferenceScreenState extends State<UserPreferenceScreen> {
  List<String> selectedInterests = [];
  List<String> selectedGoals = [];

  final List<Map<String, dynamic>> interests = [
    {'name': 'Meditation', 'icon': Icons.self_improvement},
    {'name': 'Fitness', 'icon': Icons.fitness_center},
    {'name': 'Nutrition', 'icon': Icons.restaurant},
    {'name': 'Sleep', 'icon': Icons.bedtime},
    {'name': 'Mindfulness', 'icon': Icons.psychology},
    {'name': 'Yoga', 'icon': Icons.accessibility_new},
  ];

  final List<Map<String, dynamic>> goals = [
    {'name': 'Reduce Stress', 'icon': Icons.sentiment_satisfied},
    {'name': 'Improve Sleep', 'icon': Icons.nights_stay},
    {'name': 'Stay Active', 'icon': Icons.directions_run},
    {'name': 'Eat Healthy', 'icon': Icons.local_dining},
    {'name': 'Build Habits', 'icon': Icons.trending_up},
    {'name': 'Mental Health', 'icon': Icons.favorite},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Customize Your Experience'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'What interests you?',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Select your areas of interest to personalize your experience',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30.h),

              // Interests Section
              _buildInterestGrid(),
              SizedBox(height: 40.h),

              // Goals Section
              Text(
                'What are your goals?',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Choose your wellness goals to get personalized recommendations',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30.h),

              // Goals Section
              _buildGoalsGrid(),
              SizedBox(height: 40.h),

              // Continue Button
              ElevatedButton(
                onPressed: selectedInterests.isNotEmpty || selectedGoals.isNotEmpty ? () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedInterests.isNotEmpty || selectedGoals.isNotEmpty
                      ? Colors.white : Colors.grey,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInterestGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: interests.length,
      itemBuilder: (context, index) {
        final interest = interests[index];
        final isSelected = selectedInterests.contains(interest['name']);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedInterests.remove(interest['name']);
              } else {
                selectedInterests.add(interest['name']);
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Color(0xFF262626),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  interest['icon'],
                  color: isSelected ? Colors.black : Colors.white,
                  size: 20.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  interest['name'],
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGoalsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final goal = goals[index];
        final isSelected = selectedGoals.contains(goal['name']);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedGoals.remove(goal['name']);
              } else {
                selectedGoals.add(goal['name']);
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Color(0xFF262626),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  goal['icon'],
                  color: isSelected ? Colors.black : Colors.white,
                  size: 20.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  goal['name'],
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}