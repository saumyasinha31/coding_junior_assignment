import 'package:flutter/material.dart';
import 'package:quizz_mania/data/questions.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers, required this.onReStart});
  final void Function() onReStart;
  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return Scaffold(
      backgroundColor: Colors.blue[50], // Light blue background color
      appBar: AppBar(
        title: Center(child: Text('Quiz Results', style: TextStyle(color: Colors.white ),)),
        backgroundColor: Colors.blue, // Deep blue for the AppBar
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.blue.shade500], // Light to medium blue gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display score in a large, bold text style
              Text(
                'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for visibility on blue background
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Show each question and its answer status
              Expanded(
                child: ListView.builder(
                  itemCount: summaryData.length,
                  itemBuilder: (context, index) {
                    final question = summaryData[index];
                    final isCorrect = question['user_answer'] == question['correct_answer'];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon for correctness
                            Icon(
                              isCorrect ? Icons.check_circle : Icons.cancel,
                              color: isCorrect ? Colors.green : Colors.red,
                              size: 30,
                            ),
                            const SizedBox(width: 20),

                            // Question Text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    question['question'] as String,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[900], // Dark blue for question text
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Your answer: ${question['user_answer']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Correct answer: ${question['correct_answer']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Restart button with rounded edges and gradient
              ElevatedButton(
                onPressed: onReStart,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12), backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(fontSize: 18), // White text for the button
                ),
                child: Text('Restart quiz!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
