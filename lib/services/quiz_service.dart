import '../models/question_model.dart';

class QuizService {
  // Singleton pattern
  static final QuizService _instance = QuizService._internal();
  
  factory QuizService() {
    return _instance;
  }
  
  QuizService._internal();
  
  // Get all questions
  List<Question> getQuestions() {
    return [
      Question(
        questionText: "What is the capital of France?",
        options: ["Berlin", "London", "Paris", "Madrid"],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: "Which planet is known as the Red Planet?",
        options: ["Venus", "Mars", "Jupiter", "Saturn"],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: "Who painted the Mona Lisa?",
        options: ["Vincent van Gogh", "Pablo Picasso", "Leonardo da Vinci", "Michelangelo"],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: "What is the largest ocean on Earth?",
        options: ["Atlantic Ocean", "Indian Ocean", "Arctic Ocean", "Pacific Ocean"],
        correctAnswerIndex: 3,
      ),
      Question(
        questionText: "Which element has the chemical symbol 'O'?",
        options: ["Gold", "Oxygen", "Osmium", "Oganesson"],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: "In which year did World War II end?",
        options: ["1943", "1945", "1947", "1950"],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: "What is the largest mammal in the world?",
        options: ["Elephant", "Blue Whale", "Giraffe", "Polar Bear"],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: "Which country is known as the Land of the Rising Sun?",
        options: ["China", "Thailand", "South Korea", "Japan"],
        correctAnswerIndex: 3,
      ),
      Question(
        questionText: "What is the hardest natural substance on Earth?",
        options: ["Gold", "Iron", "Diamond", "Platinum"],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: "Who wrote 'Romeo and Juliet'?",
        options: ["Charles Dickens", "William Shakespeare", "Jane Austen", "Mark Twain"],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: "What is the currency of Japan?",
        options: ["Yuan", "Won", "Yen", "Ringgit"],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: "Which is the smallest prime number?",
        options: ["0", "1", "2", "3"],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: "What is the main component of the Sun?",
        options: ["Liquid Lava", "Hydrogen", "Oxygen", "Carbon"],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: "Which animal is known as the 'King of the Jungle'?",
        options: ["Tiger", "Elephant", "Lion", "Gorilla"],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: "What is the largest organ in the human body?",
        options: ["Heart", "Liver", "Brain", "Skin"],
        correctAnswerIndex: 3,
      ),
      Question(
        questionText: "Which planet has the most moons?",
        options: ["Jupiter", "Saturn", "Uranus", "Neptune"],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: "What is the capital of Australia?",
        options: ["Sydney", "Melbourne", "Canberra", "Perth"],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: "Who discovered penicillin?",
        options: ["Marie Curie", "Alexander Fleming", "Louis Pasteur", "Joseph Lister"],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: "What is the smallest country in the world?",
        options: ["Monaco", "Maldives", "Vatican City", "San Marino"],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: "Which famous scientist developed the theory of relativity?",
        options: ["Isaac Newton", "Galileo Galilei", "Albert Einstein", "Stephen Hawking"],
        correctAnswerIndex: 2,
      ),
    ];
  }
}