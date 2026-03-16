import 'package:flutter/material.dart';

import '../../utils/page_transitions.dart';
import '../../utils/responsive_page.dart';
import 'height_screen.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? _selected; // "male" or "female"

  void _select(String value) => setState(() => _selected = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2EDE9),
      body: ResponsivePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.black,
                  iconSize: 28,
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 16),
                AnimatedIndicator(
                  activeIndex: 1,
                  count: 10,
                  animationDuration: const Duration(milliseconds: 400),
                  activeColor: const Color(0xff13EC5B),
                  inactiveColor: const Color(0xFFCCCCCC),
                  dotSize: 10.0,
                ),
                const Spacer(),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            // Gender choices row - responsive height
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.36,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _select("male"),
                      child: _GenderImageCard(
                        imagePath: "assets/Photoes/male.png",
                        label: "Male",
                        selected: _selected == "male",
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _select("female"),
                      child: _GenderImageCard(
                        imagePath: "assets/Photoes/female.png",
                        label: "Female",
                        selected: _selected == "female",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _selected != null ? Colors.green : Colors.grey,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: _selected == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        CustomPageTransitions.slideAndFadeTransition(
                          HeightScreen(gender: _selected),
                        ),
                      );
                    },
              child: const Text("Next", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenderImageCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool selected;

  const _GenderImageCard({
    required this.imagePath,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final imageHeight =
        (mq.size.height - mq.padding.vertical) *
        0.18; // responsive image height

    return Opacity(
      opacity: selected ? 1.0 : 0.85,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image
          Flexible(
            child: Image.asset(
              imagePath,
              height: imageHeight.clamp(80.0, 220.0),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          // Label
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
