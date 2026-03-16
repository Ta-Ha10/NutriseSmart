import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/page_transitions.dart';
import '../../utils/responsive_page.dart';
import '../../utils/widgets.dart';
import 'loading_screen.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ResponsivePage(
        child: Column(
          children: [
            Gap(30),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.black,
                  iconSize: 28,
                  onPressed: () => Navigator.pop(context),
                ),
                Gap(50),
                AnimatedIndicator(
                  activeIndex: 8,
                  count: 9,
                  animationDuration: const Duration(milliseconds: 400),
                  activeColor: const Color(0xff13EC5B),
                  inactiveColor: const Color(0xFFCCCCCC),
                  dotSize: 10.0,
                ),
                const Spacer(),
              ],
            ),
            Gap(20),
            const Text(
              "REVIEW PROFILE",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Please review your details below to ensure your\npersonalized plan is accurate.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            // Scrollable content
            Expanded(
              child: ListView(
                children: [
                  _buildSectionHeader("Basics"),
                  const SizedBox(height: 16),
                  _buildBasicItem(Icons.person_outline, "Name", "Alex Johnson"),
                  const SizedBox(height: 16),
                  _buildBasicItem(
                    Icons.mail_outline,
                    "Email",
                    "user@someone.com",
                  ),
                  const SizedBox(height: 32),
                  // Body Metrics Section
                  _buildSectionHeader("Body Metrics"),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          Icons.fitness_center,
                          "78",
                          "Weight",
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMetricCard(Icons.height, "178", "Height"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          Icons.calendar_today,
                          "28",
                          "Age",
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMetricCard(Icons.wc, "Male", "Gender"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Activity & Goals Section
                  _buildSectionHeader("Activity & Goals"),
                  const SizedBox(height: 16),
                  _buildActivityItem(
                    Icons.transgender_outlined,
                    "Plan",
                    "Weekly Plan",
                  ),
                  const SizedBox(height: 16),
                  _buildActivityItem(
                    Icons.directions_run,
                    "Activity Level",
                    "Moderate",
                  ),
                  const SizedBox(height: 32),
                  // Nutrition Section
                  _buildSectionHeader("Nutrition"),
                  const SizedBox(height: 16),
                  _buildActivityItem(
                    Icons.restaurant_menu,
                    "Plan",
                    "Weekly Plan",
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
            // Confirm button
            NextButton(
              height: 56,
              label: 'Confirm & Start',
              onPressed: () {
                Navigator.push(
                  context,
                  CustomPageTransitions.slideAndFadeTransition(
                    const LoadingScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildBasicItem(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.edit, color: Colors.green, size: 20),
        ],
      ),
    );
  }

  Widget _buildMetricCard(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.grey[600], size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildActivityItem(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.edit, color: Colors.green, size: 20),
        ],
      ),
    );
  }
}
