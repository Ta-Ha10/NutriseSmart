import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/page_transitions.dart';
import '../../utils/responsive_page.dart';
import 'goal_weight_screen.dart';

class CurrentWeightScreen extends StatefulWidget {
  const CurrentWeightScreen({super.key});
  @override
  State<CurrentWeightScreen> createState() => _CurrentWeightScreenState();
}

class _CurrentWeightScreenState extends State<CurrentWeightScreen> {
  double _currentWeight = 90.0;
  final double min = 50;
  final double max = 220;
  String selectedValue = '';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffF2EDE9),
      body: ResponsivePage(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
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
                  activeIndex: 3,
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
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "What's your ",
                    style: TextStyle(fontSize: 29),
                  ),
                  TextSpan(
                    text: "Current\nWeight",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 29,
                    ),
                  ),
                  TextSpan(text: " ?"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "This helps us calculate your personalized\ncalorie needs.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: screenHeight * 0.35,
                      maxWidth: screenWidth * 0.9,
                    ),
                    child: AnimatedWeightPicker(
                      min: 50,
                      max: 220,
                      onChange: (newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Next button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: Size(screenWidth * 0.95, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageTransitions.slideAndFadeTransition(
                      const GoalWeightScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
