import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/page_transitions.dart';
import '../../utils/responsive_page.dart';
import '../../utils/widgets.dart';
import 'review_screen.dart';

class MealGoalScreen extends StatefulWidget {
  const MealGoalScreen({super.key});
  @override
  State<MealGoalScreen> createState() => _MealGoalScreenState();
}

class _MealGoalScreenState extends State<MealGoalScreen> {
  int selectedIndex = 0;

  final List<String> options = ['Weekly Plan', 'Daily Plan', 'Single Meal'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsivePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(30),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.black,
                  iconSize: 28,
                  onPressed: () => Navigator.pop(context),
                ),
                Gap(50),
                AnimatedIndicator(
                  activeIndex: 7,
                  count: 10,
                  animationDuration: const Duration(milliseconds: 400),
                  activeColor: const Color(0xff13EC5B),
                  inactiveColor: const Color(0xFFCCCCCC),
                  dotSize: 10.0,
                ),
                const Spacer(),
              ],
            ),
            Gap(20),

            // Header with styled text
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: "How often should we\nupdate your "),
                  TextSpan(
                    text: "plan",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: "?"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Subtitle
            Text(
              "Select how frequently you want your meals\nand workouts refreshed to match your\nlifestyle.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            // Meal Planning Goal label
            const Text(
              "Meal Planning Goal",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            // Options list
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      height: 91,
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(24),
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
                      child: Stack(
                        children: [
                          Text(
                            options[index],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          // Recommended badge for first option
                          if (index == 0)
                            Positioned(
                              right: 20,
                              top: 3,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Text(
                                  "Recommended",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Next button
            NextButton(
              height: 60,
              onPressed: () {
                Navigator.push(
                  context,
                  CustomPageTransitions.slideAndFadeTransition(
                    const ReviewScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
