import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final PageController _controller = PageController();

  final List<Map<String, dynamic>> questions = [
    {
      "question": "If today was a weather forecast, what would it be?",
      "options": ["🌞 Sunny", "☁️ Cloudy", "⛈️ Stormy", "🌈 Rainbow"],
    },
    {
      "question": "Pick your current energy level.",
      "options": ["🔋 Empty", "🔋 Half", "🔋 Full"],
    },
    {
      "question": "If you could escape into a movie right now, what kind would it be?",
      "options": ["🚀 Adventure", "❤️ Romantic", "😂 Comedy", "🧠 Mystery"],
    },
  ];

  void _onOptionSelected(String option) {
    print("Selected: $option"); // Handle selected option logic here
    if (_controller.page! < questions.length - 1) {
      _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      print("End of Questions"); // Handle end-of-questions logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Your Mood'),
        backgroundColor: const Color.fromARGB(255, 250, 121, 0),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Column(
          children: [
            
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return FlashCard(
                    question: question["question"],
                    options: question["options"],
                    onOptionSelected: _onOptionSelected,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlashCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final Function(String) onOptionSelected;

  FlashCard({
    required this.question,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 250, 121, 0), const Color.fromARGB(255, 233, 214, 196)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                question,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),
              Column(
                children: options.map((option) {
                  return GestureDetector(
                    onTap: () => onOptionSelected(option),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [const Color.fromARGB(255, 193, 193, 193), const Color.fromARGB(255, 79, 79, 79)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            option,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 18, 18, 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}