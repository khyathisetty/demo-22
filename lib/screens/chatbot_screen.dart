import 'package:flutter/material.dart';
import '../utils/app_state.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [
    {
      "text":
          "Hello! I am your AI Farm Assistant. Ask me about crops, fertilizers, or soil health.",
      "isUser": false,
      "date": "Today, 7:46 pm"
    },
    {
      "text": "Hello! How can I help you with your farm today?",
      "isUser": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
       final isHighContrast = AppState.instance.isHighContrast;

       return Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessage(
                  text: msg['text'],
                  isUser: msg['isUser'],
                  date: msg['date'],
                  isHighContrast: isHighContrast,
                );
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildOptionChip("Crop Disease", isHighContrast),
                const SizedBox(width: 8),
                _buildOptionChip("Fertilizer Rates", isHighContrast),
                const SizedBox(width: 8),
                _buildOptionChip("Weather Forecast", isHighContrast),
                const SizedBox(width: 8),
                _buildOptionChip("Soil Health", isHighContrast),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: isHighContrast ? Colors.black : Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isHighContrast ? Colors.grey[800] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                      border: isHighContrast ? Border.all(color: Colors.white54) : null,
                    ),
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(color: isHighContrast ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Ask about crops, fertilizers...',
                        hintStyle: TextStyle(color: isHighContrast ? Colors.grey[400] : Colors.grey[600]),
                        border: InputBorder.none,
                      ),
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: isHighContrast ? Colors.grey[800] : const Color(0xFF2E7D32),
                  child: IconButton(
                    icon: Icon(Icons.send, color: isHighContrast ? Colors.white : Colors.white),
                    onPressed: () => _handleSubmitted(_controller.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
     }
    );
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _controller.clear();
    setState(() {
      _messages.add({"text": text, "isUser": true});
    });
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add({
            "text": _getAIResponse(text),
            "isUser": false,
          });
        });
        _scrollToBottom();
      }
    });
  }

  String _getAIResponse(String query) {
    query = query.toLowerCase();
    if (query.contains("disease")) {
      return "Detected: Leaf Blight. Recommendation: Apply Copper Oxychloride 50WP.";
    } else if (query.contains("fertilizer")) {
      return "Current NPK levels are good, but you may need 20kg Urea per acre next week.";
    } else if (query.contains("weather")) {
      return "Tomorrow: Mostly Sunny, 29°C. No rain expected.";
    } else if (query.contains("soil")) {
      return "Your soil moisture is at 45% which is optimal for rice. Keep monitoring.";
    }
    return "I can help you with crop advice, weather updates, and soil health. Try asking about 'Fertilizers' or 'Weather'.";
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildOptionChip(String label, bool isHighContrast) {
    return ActionChip(
      label: Text(label),
      backgroundColor: isHighContrast ? Colors.grey[900] : Colors.white,
      side: BorderSide(color: isHighContrast ? Colors.white70 : Colors.grey[300]!),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () => _handleSubmitted(label),
      labelStyle: TextStyle(color: isHighContrast ? Colors.white : Colors.grey[800]),
    );
  }

  Widget _buildMessage(
      {required String text, required bool isUser, required bool isHighContrast, String? date}) {
    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (date != null && !isUser)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(date,
                style: TextStyle(color: Colors.grey[400], fontSize: 12)),
          ),
        Row(
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser) ...[
              CircleAvatar(
                backgroundColor: isHighContrast ? Colors.grey[800] : Colors.white,
                radius: 16,
                child:
                    Icon(Icons.smart_toy, size: 20, color: isHighContrast ? Colors.white : Colors.grey[600]),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: isUser 
                      ? (isHighContrast ? Colors.grey[800] : const Color(0xFF2E7D32)) 
                      : (isHighContrast ? Colors.black : Colors.white),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: !isUser
                          ? const Radius.circular(0)
                          : const Radius.circular(16),
                      bottomRight: isUser
                          ? const Radius.circular(0)
                          : const Radius.circular(16),
                    ),
                    border: isHighContrast ? Border.all(color: Colors.white24) : null,
                    boxShadow: [
                      if (!isUser && !isHighContrast)
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                        )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isUser) ...[
                      Text("AI Assistant",
                          style: TextStyle(
                              fontSize: 12,
                              color: isHighContrast ? Colors.grey[400] : Colors.grey[600],
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                    ],
                    Text(text,
                        style: TextStyle(
                            color: isUser ? Colors.white : (isHighContrast ? Colors.white : Colors.black87))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
