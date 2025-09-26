import 'package:flutter/material.dart';
import 'package:sih/utils/myAppBar.dart';
import 'dart:async';
import 'package:sih/views/quiz_category.dart';
import 'package:sih/utils/glassmorph.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIH Demo',
      home: Scaffold(body: const HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Home page"),
      // Stack to allow background + glass overlay
      body: Stack(
        children: [
          // Full-screen glassmorphism overlay
          const GlassMorphism(start: 0.25, end: 0.1, child: SizedBox.expand()),

          // Centered content
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizCategory()),
                );
              },
              child: GlassMorphism(
                start: 0.35,
                end: 0.15,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 40,
                  ),
                  child: const Text(
                    'Virtual Drills',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StormScenarioWidget extends StatefulWidget {
  const StormScenarioWidget({super.key});

  @override
  _StormScenarioWidgetState createState() => _StormScenarioWidgetState();
}

class _StormScenarioWidgetState extends State<StormScenarioWidget> {
  String? selectedOption;
  bool showLightning = false;

  final List<String> options = [
    "Move Valuables Upstairs",
    "Supply Run",
    "Secure Vehicle",
    "Check Relatives",
    "Prepare Go-Bags",
  ];

  @override
  void initState() {
    super.initState();

    // Lightning effect every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        showLightning = true;
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          showLightning = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flood Drill Scenario")),
      body: SafeArea(
        child: Stack(
          children: [
            // Top image
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/flood_bg.jpg',
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),

            // Lightning overlay
            if (showLightning)
              Positioned.fill(
                child: Container(color: Colors.white.withOpacity(0.6)),
              ),

            // Bottom options
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: const Color.fromARGB(122, 255, 255, 255),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...options.map((option) {
                          bool isSelected = selectedOption == option;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOption = option;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.purple
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: selectedOption == null
                                ? null
                                : () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "You chose: $selectedOption",
                                        ),
                                      ),
                                    );
                                  },
                            child: const Text("Submit"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
