import 'package:flutter/material.dart';


// Placeholder for scenario quiz
class ScenarioQuizPage extends StatelessWidget {
  final String title;

  const ScenarioQuizPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.brown.shade700.withOpacity(0.8),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Questions for $title will go here...",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}