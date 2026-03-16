import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nutriseesmartt/Screens/Signup/current_weight_screen.dart';

import '../../utils/page_transitions.dart';

class HeightScreen extends StatefulWidget {
  final String? gender;
  const HeightScreen({super.key, this.gender});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  double _heightCm = 170;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = _heightCm.toInt().toString();
  }

  String get _ftIn {
    final totalInches = _heightCm / 2.54;
    final feet = totalInches ~/ 12;
    final inches = (totalInches % 12).round();
    return "${feet}\'${inches}\"";
  }

  void _onTextChanged(String v) {
    final parsed = int.tryParse(v);
    if (parsed != null) {
      final clamped = parsed.clamp(100, 220).toDouble();
      setState(() => _heightCm = clamped);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textController.value = _textController.value.copyWith(
      text: _heightCm.toInt().toString(),
    );

    String imagePath = widget.gender == "female"
        ? 'assets/Photoes/female.png'
        : 'assets/Photoes/male.png';

    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Color(0xffF2EDE9),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical -
                    48,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                        activeIndex: 2,
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
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                          text: "What's your ",
                          style: TextStyle(fontSize: 29),
                        ),
                        TextSpan(
                          text: "height",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 29,
                          ),
                        ),
                        const TextSpan(text: "?"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "This helps us calculate your calorie needs accurately.",
                    style: TextStyle(fontSize: 17, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Height label
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Height",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Main height display with image and scale
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Left: Person image
                        Expanded(
                          child: Image.asset(imagePath, fit: BoxFit.contain),
                        ),
                        const SizedBox(width: 20),
                        // Right: Height display and scale
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Height number
                              Text(
                                _heightCm.toInt().toString(),
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Height scale/ruler
                              Expanded(
                                child: GestureDetector(
                                  onVerticalDragUpdate: (details) {
                                    setState(() {
                                      double newHeight =
                                          _heightCm + (details.delta.dy * 0.5);
                                      newHeight = newHeight.clamp(100, 220);
                                      _heightCm = newHeight;
                                    });
                                  },
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final rulerHeight = constraints.maxHeight;
                                      final marks = 25;
                                      return Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            // Ruler marks
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: List.generate(marks, (
                                                i,
                                              ) {
                                                return SizedBox(
                                                  height: rulerHeight / marks,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: i % 5 == 0
                                                            ? 3
                                                            : 1.5,
                                                        width: i % 5 == 0
                                                            ? 8
                                                            : 4,
                                                        color: i % 5 == 0
                                                            ? Colors.black
                                                            : Colors
                                                                  .grey
                                                                  .shade400,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                            ),
                                            // Green indicator - Larger circle
                                            Positioned(
                                              top:
                                                  ((_heightCm - 100) / 120) *
                                                      rulerHeight -
                                                  12,
                                              left: -16,
                                              child: Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CustomPageTransitions.slideAndFadeTransition(
                          const CurrentWeightScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
