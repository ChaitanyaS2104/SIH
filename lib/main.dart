import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Virtual drills'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VirtualDrillsPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class VirtualDrillsPage extends StatelessWidget {
  const VirtualDrillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Virtual Drills')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Flood'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FloodPage()),
            );
          },
        ),
      ),
    );
  }
}

class FloodPage extends StatelessWidget {
  const FloodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flood')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StormScenarioWidget(),
                  ),
                );
              },
              child: const Text('Pre Disaster'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('During Disaster'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Post Disaster'),
            ),
          ],
        ),
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
    _startLightning();
  }

  void _startLightning() {
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
        child: Column(
          children: [
            // Dark stormy sky
            Container(color: Colors.blueGrey.shade900),

            // Rain drops
            Positioned.fill(child: CustomPaint(painter: RainPainter())),

            // Lightning overlay
            if (showLightning)
              Positioned.fill(
                child: Container(color: Colors.white.withOpacity(0.6)),
              ),

            // House in center
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/flood_bg.jpg',
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),

            // Options at bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: const Color.fromARGB(122, 255, 255, 255),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight:
                        MediaQuery.of(context).size.height *
                        0.5, // max height of the options panel
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
                                width: double.infinity, // full width
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.purple
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey, // small border line
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
                          width:
                              double.infinity, // make submit button full width
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

// Simple raindrop painter
class RainPainter extends CustomPainter {
  final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blueAccent;
    for (int i = 0; i < 150; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      canvas.drawLine(Offset(x, y), Offset(x, y + 10), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
