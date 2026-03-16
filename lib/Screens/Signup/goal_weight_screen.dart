import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/page_transitions.dart';
import '../../utils/responsive_page.dart';
import '../../utils/widgets.dart';
import 'obesity_screen.dart';

class GoalWeightScreen extends StatefulWidget {
  const GoalWeightScreen({super.key});
  @override
  State<GoalWeightScreen> createState() => _GoalWeightScreenState();
}

class _GoalWeightScreenState extends State<GoalWeightScreen> {
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
            IndicatorHeader(activeIndex: 4, totalCount: 10),
            Gap(20),
            // Header with styled text
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
                    text: "Goal\nWeight",
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
              "This helps us create your personalized\nnutrition plan.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Spacer(),
            // Weight display
            // Ruler/Scale visualization
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

            const Spacer(),
            // Next button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: NextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageTransitions.slideAndFadeTransition(
                      const ObesityScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
