// Main page with all disasters

import 'package:flutter/material.dart';
import 'package:sih/utils/myAppBar.dart';
import 'package:sih/views/quiz_details.dart';
import 'package:sih/utils/glassmorph.dart';

class QuizCategory extends StatelessWidget {
  const QuizCategory({super.key});

  @override
  Widget build(BuildContext context) {
    // Example quiz data (title + description)
    final List<Map<String, String>> quizList = [
      {
        "title": "Flood Safety",
        "desc": "Learn how to stay safe during floods.",
        "image": "assets/images/flood.png",
      },
      {
        "title": "Earthquake",
        "desc": "Protect yourself for earthquakes.",
        "image": "assets/images/earthquake.png",
      },
      {
        "title": "Cyclone Awareness",
        "desc": "Steps to prepare for cyclones and stay safe.",
        "image": "assets/images/cyclone.png",
      },
      {
        "title": "Fire Drill",
        "desc": "Know what to do in case of fires.",
        "image": "assets/images/flame.png",
      },
      {
        "title": "Landslide Safety",
        "desc": "Recognize warning signs and evacuation procedures.",
        "image": "assets/images/landslide.png",
      },
    ];

    return Scaffold(
      appBar: myAppBar("Quiz page"),
      body: Stack(
        children: [
          // Full-screen brown glass overlay
          const GlassMorphism(start: 0.25, end: 0.1, child: SizedBox.expand()),

          // Grid items
          GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1, // square-ish cards
            ),
            itemCount: quizList.length,
            itemBuilder: (context, index) {
              final quiz = quizList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizDetailPage(
                        title: quiz["title"]!,
                        desc: quiz["desc"]!,
                      ),
                    ),
                  );
                },
                child: GlassMorphism(
                  start: 0.35,
                  end: 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Disaster image
                        if (quiz["image"] != null)
                          Image.asset(quiz["image"]!, width: 60, height: 60),
                        const SizedBox(height: 12),
                        // Title
                        Text(
                          quiz["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Description
                        Text(
                          quiz["desc"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
