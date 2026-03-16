import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/page_transitions.dart';
import '../../utils/responsive_page.dart';
import '../../utils/widgets.dart';
import 'meal_goal_screen.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int selectedIndex = 0; // Default to Sedentary

  final List<Map<String, String>> options = [
    {
      'title': 'Sedentary',
      'desc':
          'Office workers, people with limited physical activity during the day.',
    },
    {
      'title': 'Lightly Active',
      'desc':
          'Light jogging, walking, yoga, or other low-intensity workouts a few times a week.',
    },
    {
      'title': 'Moderate Active',
      'desc':
          'Running, cycling, swimming, or moderate intensity strength training.',
    },
    {
      'title': 'Active',
      'desc':
          'Intense weight training, running marathons, competitive sports, or professional training sessions.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsivePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(30),
            IndicatorHeader(activeIndex: 6, totalCount: 10),
            Gap(20),
            // Dashed line separato
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: "How "),
                    TextSpan(
                      text: "active",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: " are you ?"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Subtitle
            Center(
              child: Text(
                "This Help us to calculate our daily calorie\nBurn",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 32),
            // Activity level label
            const Text(
              "What About you Activity Level",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            // Activity options list
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return _buildCard(index);
                },
              ),
            ),
            const SizedBox(height: 16),
            // Next button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageTransitions.slideAndFadeTransition(
                      const MealGoalScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: isSelected
              ? Border.all(color: Colors.green, width: 3)
              : Border.all(color: Colors.transparent, width: 3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              options[index]['title']!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              options[index]['desc']!,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
