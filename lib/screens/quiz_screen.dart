import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../services/quiz_service.dart';
import '../widgets/footer_widget.dart';
import '../theme/glassmorphism.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  final QuizService _quizService = QuizService();
  late List<Question> _questions;
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedAnswerIndex;
  List<int?> _userAnswers = [];
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _questions = _quizService.getQuestions();
    _userAnswers = List<int?>.filled(_questions.length, null);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _checkAnswer(int selectedIndex) {
    if (_answered) return;

    setState(() {
      _answered = true;
      _selectedAnswerIndex = selectedIndex;
      _userAnswers[_currentQuestionIndex] = selectedIndex;
      if (selectedIndex == _questions[_currentQuestionIndex].correctAnswerIndex) {
        _score++;
      }
    });

    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _animationController.reverse().then((_) {
          setState(() {
            if (_currentQuestionIndex < _questions.length - 1) {
              _currentQuestionIndex++;
              _answered = false;
              _selectedAnswerIndex = null;
            } else {
              // Quiz completed
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ResultScreen(
                    score: _score,
                    totalQuestions: _questions.length,
                    questions: _questions,
                    userAnswers: _userAnswers,
                  ),
                ),
              );
            }
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Frivia Quiz'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: GlassmorphismTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Progress indicator
                GlassmorphicContainer(
                  height: 20,
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(10),
                  blur: 5,
                  borderWidth: 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (_currentQuestionIndex + 1) / _questions.length,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(GlassmorphismTheme.secondaryColor),
                      minHeight: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GlassmorphicContainer(
                  height: 40,
                  width: 150,
                  borderRadius: BorderRadius.circular(20),
                  blur: 10,
                  borderWidth: 0.5,
                  child: Center(
                    child: Text(
                      'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: GlassmorphismTheme.textPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Question
                GlassmorphicContainer(
                  padding: const EdgeInsets.all(20.0),
                  height: 150,
                  borderRadius: BorderRadius.circular(15),
                  blur: 15,
                  borderWidth: 1.0,
                  child: Center(
                    child: Text(
                      _questions[_currentQuestionIndex].questionText,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: GlassmorphismTheme.textPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Options
                Expanded(
                  child: ListView.builder(
                    itemCount: _questions[_currentQuestionIndex].options.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            // Determine the color based on whether the answer is correct
                            Color buttonColor = Colors.white;
                            if (_answered && index == _selectedAnswerIndex) {
                              buttonColor = index == _questions[_currentQuestionIndex].correctAnswerIndex
                                  ? Colors.green.withOpacity(_animation.value)
                                  : Colors.red.withOpacity(_animation.value);
                            } else if (_answered && index == _questions[_currentQuestionIndex].correctAnswerIndex) {
                              buttonColor = Colors.green.withOpacity(_animation.value);
                            }

                            return GlassmorphicContainer(
                              height: 60,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              borderRadius: BorderRadius.circular(10),
                              blur: 10,
                              borderWidth: 0.5,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  buttonColor.withOpacity(0.7),
                                  buttonColor.withOpacity(0.4),
                                ],
                              ),
                              child: InkWell(
                                onTap: _answered ? null : () => _checkAnswer(index),
                                borderRadius: BorderRadius.circular(10),
                                child: Center(
                                  child: Text(
                                    _questions[_currentQuestionIndex].options[index],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: GlassmorphismTheme.textPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                // Score display
                GlassmorphicContainer(
                  height: 50,
                  width: 120,
                  borderRadius: BorderRadius.circular(25),
                  blur: 10,
                  borderWidth: 0.5,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      GlassmorphismTheme.primaryColor.withOpacity(0.3),
                      GlassmorphismTheme.primaryColor.withOpacity(0.1),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Score: $_score',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: GlassmorphismTheme.textPrimaryColor,
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