import 'package:flutter/material.dart';

import '../../utils/page_transitions.dart';
import '../../utils/widgets.dart';
import 'activity_screen.dart';

class ObesityScreen extends StatefulWidget {
  const ObesityScreen({super.key});
  @override
  State<ObesityScreen> createState() => _ObesityScreenState();
}

class _ObesityScreenState extends State<ObesityScreen> {
  bool? hasObesity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mq = MediaQuery.of(context);
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: mq.size.height * 0.02),
                        IndicatorHeader(activeIndex: 5, totalCount: 10),
                        SizedBox(height: mq.size.height * 0.02),

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
                                text: "Do you have ",
                                style: TextStyle(fontSize: 29),
                              ),
                              TextSpan(
                                text: "Diabetes",
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
                        SizedBox(height: mq.size.height * 0.02),
                        Text(
                          "We use this information to adjust your calorie\nintake and provide recommendations safely.\nYour data is private.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),

                        SizedBox(height: mq.size.height * 0.03),

                        // Responsive image
                        Center(
                          child: Image.asset(
                            'assets/Photoes/diabetes.png',
                            height:
                                (mq.size.height - mq.padding.vertical) * 0.18,
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: mq.size.height * 0.03),

                        // Yes/No buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildOptionButton("Yes", true),
                            _buildOptionButton("No", false),
                          ],
                        ),

                        const Spacer(),

                        // Next button
                        NextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              CustomPageTransitions.slideAndFadeTransition(
                                const ActivityScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOptionButton(String text, bool value) {
    bool isSelected = hasObesity == value;
    return GestureDetector(
      onTap: () => setState(() => hasObesity = value),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey[600],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
