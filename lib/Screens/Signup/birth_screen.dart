import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/page_transitions.dart';
import 'gender_screen.dart';

class BirthScreen extends StatefulWidget {
  const BirthScreen({super.key});

  @override
  State<BirthScreen> createState() => _BirthScreenState();
}

class _BirthScreenState extends State<BirthScreen> {
  late int _selectedDay;
  late int _selectedMonth;
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDay = now.day;
    _selectedMonth = now.month;
    _selectedYear = now.year - 25;
  }

  String get _displayDate {
    return "${_selectedDay.toString().padLeft(2, '0')} "
        "${_monthName(_selectedMonth)} $_selectedYear";
  }

  String _monthName(int m) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[m - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2EDE9),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mq = MediaQuery.of(context);
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: mq.size.height * 0.02),

                        AnimatedIndicator(
                          activeIndex: 0,
                          count: 10,
                          animationDuration: const Duration(milliseconds: 400),
                          activeColor: const Color(0xff13EC5B),
                          inactiveColor: const Color(0xFFCCCCCC),
                          dotSize: 10.0,
                        ),

                        SizedBox(height: mq.size.height * 0.03),
                        Center(
                          child: Text(
                            "When were you born?",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "We use this to calculate your metabolic age",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: mq.size.height * 0.03),

                        // Date Display
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _displayDate,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        SizedBox(height: mq.size.height * 0.03),

                        // Date Wheels - responsive height
                        Container(
                          height: (mq.size.height - mq.padding.vertical) * 0.36,
                          decoration: BoxDecoration(
                            color: const Color(0xffF2EDE9),
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              // Day Wheel
                              Expanded(
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                    initialItem: _selectedDay - 1,
                                  ),
                                  itemExtent: 56,
                                  onSelectedItemChanged: (int index) {
                                    setState(() => _selectedDay = index + 1);
                                  },
                                  children: List.generate(31, (index) {
                                    return Center(
                                      child: Text(
                                        (index + 1).toString().padLeft(2, '0'),
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              // Month Wheel
                              Expanded(
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                    initialItem: _selectedMonth - 1,
                                  ),
                                  itemExtent: 56,
                                  onSelectedItemChanged: (int index) {
                                    setState(() => _selectedMonth = index + 1);
                                  },
                                  children: List.generate(12, (index) {
                                    return Center(
                                      child: Text(
                                        _monthName(index + 1),
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              // Year Wheel
                              Expanded(
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                    initialItem: 25,
                                  ),
                                  itemExtent: 56,
                                  onSelectedItemChanged: (int index) {
                                    setState(
                                      () => _selectedYear =
                                          DateTime.now().year - index,
                                    );
                                  },
                                  children: List.generate(100, (index) {
                                    return Center(
                                      child: Text(
                                        (DateTime.now().year - index)
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff13EC5B),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CustomPageTransitions.slideAndFadeTransition(
                                const GenderScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: mq.size.height * 0.02),
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
}
