import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../widgets/footer_widget.dart';
import '../theme/glassmorphism.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<Question> questions;
  final List<int?> userAnswers;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = (score / totalQuestions) * 100;
    String message;
    Color messageColor;

    if (percentage >= 80) {
      message = 'Excellent!';
      messageColor = Colors.green;
    } else if (percentage >= 60) {
      message = 'Good job!';
      messageColor = Colors.blue;
    } else if (percentage >= 40) {
      message = 'Not bad!';
      messageColor = Colors.orange;
    } else {
      message = 'Try again!';
      messageColor = Colors.red;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: GlassmorphismTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Quiz Completed!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: messageColor,
                  ),
                ),
                const SizedBox(height: 40),

                // ✅ Score Circle
                GlassmorphicContainer(
                   height: 200,
                   width: 200,
                   borderRadius: BorderRadius.circular(100),
                  blur: 20,
                  borderWidth: 1.5,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$score/$totalQuestions',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: GlassmorphismTheme.textPrimaryColor,
                          ),
                        ),
                        Text(
                          '${percentage.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 24,
                            color: GlassmorphismTheme.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ Restart button
                GlassmorphicButton(
                  height: 60,
                  width: 200,
                  borderRadius: BorderRadius.circular(30),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Restart Quiz',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ Back to Home
                GlassmorphicContainer(
                  height: 50,
                  width: 150,
                  borderRadius: BorderRadius.circular(25),
                  blur: 10,
                  borderWidth: 0.5,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    borderRadius: BorderRadius.circular(25),
                    child: const Center(
                      child: Text(
                        'Back to Home',
                        style: TextStyle(
                          fontSize: 16,
                          color: GlassmorphismTheme.textPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                GlassmorphicContainer(
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  borderRadius: BorderRadius.circular(10),
                  blur: 10,
                  borderWidth: 0.5,
                  child: const Center(child: FooterWidget()),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
