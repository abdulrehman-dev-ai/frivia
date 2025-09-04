import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import '../widgets/footer_widget.dart';
import '../theme/glassmorphism.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: GlassmorphismTheme.backgroundGradient,
        ),
        child: SafeArea( // prevents overlap with status bar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40), // spacing below status bar
              GlassmorphicContainer(
                height: 180,
                width: 180,
                borderRadius: BorderRadius.circular(90),
                blur: 20,
                padding: EdgeInsets.zero,
                child: Center(
                  child: Image.asset(
                    'assets/Frivia_logo.png',
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Frivia Quiz App',
                style: GlassmorphismTheme.subheadingStyle,
              ),
              const SizedBox(height: 80),
              Center(
                child: GlassmorphicButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ),
                    );
                  },
                  width: 200,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      GlassmorphismTheme.secondaryColor.withOpacity(0.7),
                      GlassmorphismTheme.secondaryColor.withOpacity(0.4),
                    ],
                  ),
                  borderColor: GlassmorphismTheme.secondaryColor.withOpacity(0.5),
                  child: const Text(
                    'Start Quiz',
                    style: GlassmorphismTheme.buttonTextStyle,
                  ),
                ),
              ),
              const Spacer(),
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
    );
  }
}
