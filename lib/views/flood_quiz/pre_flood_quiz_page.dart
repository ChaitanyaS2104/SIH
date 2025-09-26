import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sih/utils/glassmorph.dart';
import 'package:lottie/lottie.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final List<int> points; // points per option
  final List<List<String>> lottieAnimations; // multiple animations per option

  QuizQuestion({
    required this.question,
    required this.options,
    required this.points,
    required this.lottieAnimations,
  });
}

class PreFloodQuizPage extends StatefulWidget {
  const PreFloodQuizPage({super.key});

  @override
  _PreFloodQuizPageState createState() => _PreFloodQuizPageState();
}

class _PreFloodQuizPageState extends State<PreFloodQuizPage> {
  final List<QuizQuestion> questions = [
    QuizQuestion(
      question: "Which action will you take?",
      options: [
        "Move Valuables Upstairs",
        "Make a Last-Minute Supply Run",
        "Secure the Car/Motorcycle",
        "Prepare the \"Go-Bags\" and Documents",
      ],
      points: [5, 3, 4, 10],
      lottieAnimations: [
        [
          "assets/lottie/stairs.json",
          "assets/lottie/ac.json",
          "assets/lottie/pc.json",
          "assets/lottie/wm.json",
        ],
        ["assets/lottie/RedCar.json", "assets/lottie/Isometricshop.json"],
        ["assets/lottie/car_safety.json"],
        [
          "assets/lottie/document.json",
          "assets/lottie/passport.json",
          "assets/lottie/medicine.json",
          "assets/lottie/bag.json",
        ],
      ],
    ),
    QuizQuestion(
      question: "Which item is essential during floods?",
      options: [
        "Repeatedly call 112",
        "Go live on social media",
        "Get to the roof",
        "Attempt to shut of the mains",
        "Hunker down and preserve battery",
      ],
      points: [10, 2, 1, 3, 5],
      lottieAnimations: [
        ["assets/lottie/call.json", "assets/lottie/waterproof_2.json"],
        ["assets/lottie/social_media.json", "assets/lottie/social_bubble.json"],
        ["assets/lottie/stairs.json", "assets/lottie/rooftop.json"],
        ["assets/lottie/power_line.json", "assets/lottie/off.json"],
        [
          "assets/lottie/family.json",
          "assets/lottie/charging.json",
          "assets/lottie/alert.json",
        ],
      ],
    ),
  ];

  int currentQuestionIndex = 0;
  String? selectedOption;
  int score = 0;
  bool showLightning = false;

  // Track current animation index per option
  Map<String, int> currentAnimationIndex = {};
  Map<String, Timer?> animationTimers = {};

  @override
  void initState() {
    super.initState();

    // Initialize animation indices and timers
    for (var question in questions) {
      for (var option in question.options) {
        currentAnimationIndex[option] = 0;
        animationTimers[option] = null;
      }
    }

    // Optional lightning effect
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() => showLightning = true);
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() => showLightning = false);
      });
    });
  }

  void submitAnswer() {
    if (selectedOption != null) {
      final question = questions[currentQuestionIndex];
      score += question.points[question.options.indexOf(selectedOption!)];

      // Cancel all timers
      animationTimers.forEach((key, timer) {
        timer?.cancel();
      });

      setState(() {
        currentQuestionIndex++;
        selectedOption = null;
      });
    }
  }

  void startAnimationCycle(String option, QuizQuestion question) {
    // Cancel previous timer for this option if any
    animationTimers[option]?.cancel();

    animationTimers[option] = Timer.periodic(const Duration(seconds: 2), (_) {
      if (selectedOption != option) {
        animationTimers[option]?.cancel();
      } else {
        setState(() {
          int nextIndex =
              (currentAnimationIndex[option]! + 1) %
              question
                  .lottieAnimations[question.options.indexOf(option)]
                  .length;
          currentAnimationIndex[option] = nextIndex;
        });
      }
    });
  }

  String getCurrentAnimation(QuizQuestion question, String option) {
    return question.lottieAnimations[question.options.indexOf(
      option,
    )][currentAnimationIndex[option]!];
  }

  @override
  void dispose() {
    // Cancel all timers on dispose
    animationTimers.forEach((key, timer) => timer?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= questions.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Pre-Flood Quiz"),
          backgroundColor: Colors.brown.shade700.withOpacity(0.8),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            "Quiz Finished! Your score: $score",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pre-Flood Quiz"),
        backgroundColor: Colors.brown.shade700.withOpacity(0.8),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/flood_bg.jpg", fit: BoxFit.cover),
          ),
          if (showLightning)
            Positioned.fill(
              child: Container(color: Colors.white.withOpacity(0.5)),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Q${currentQuestionIndex + 1}: ${currentQuestion.question}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: currentQuestion.options.map((option) {
                        bool isSelected = selectedOption == option;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOption = option;
                                currentAnimationIndex[option] = 0;
                                startAnimationCycle(option, currentQuestion);
                              });
                            },
                            child: GlassMorphism(
                              start: isSelected ? 0.5 : 0.35,
                              end: isSelected ? 0.25 : 0.15,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        option,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.yellow
                                              : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      if (isSelected)
                                        Center(
                                          child: Lottie.asset(
                                            getCurrentAnimation(
                                              currentQuestion,
                                              option,
                                            ),
                                            width: 250,
                                            height: 250,
                                            repeat: true,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedOption == null ? null : submitAnswer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
