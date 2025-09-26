import 'package:flutter/material.dart';
import 'package:sih/utils/myAppBar.dart';
import 'package:sih/views/flood_quiz/pre_flood_quiz_page.dart';

class ScenarioQuizPage extends StatelessWidget {
  final String title;

  const ScenarioQuizPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          // Load PreFloodQuizPage for Pre-Disaster scenario
          if (title.toLowerCase().contains("pre-disaster")) {
            return const PreFloodQuizPage();
          }
          // You can later add During and Post disaster quizzes
          else if (title.toLowerCase().contains("during")) {
            return Center(
              child: Text(
                "During Disaster Quiz for $title coming soon",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            );
          } else if (title.toLowerCase().contains("post")) {
            return Center(
              child: Text(
                "Post Disaster Quiz for $title coming soon",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            );
          }

          // Default placeholder
          return Center(
            child: Text(
              "Questions for $title will go here...",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
