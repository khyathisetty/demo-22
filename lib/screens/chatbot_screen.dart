import 'package:flutter/material.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildMessage(
                  text:
                      "Hello! I am your AI Farm Assistant. Ask me about crops, fertilizers, or soil health.",
                  isUser: false,
                  date: "Today, 7:46 pm"),
              _buildMessage(
                text: "Hi",
                isUser: true,
              ),
              _buildMessage(
                text: "Hello! How can I help you with your farm today?",
                isUser: false,
              ),
            ],
          ),
        ),
         SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildOptionChip("Crop Disease"),
              const SizedBox(width: 8),
              _buildOptionChip("Fertilizer Rates"),
              const SizedBox(width: 8),
              _buildOptionChip("Weather Forecast"),
               const SizedBox(width: 8),
              _buildOptionChip("Soil Health"),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Ask about crops, fertilizers...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: const Color(0xFF2E7D32),
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionChip(String label) {
    return ActionChip(
      label: Text(label),
      backgroundColor: Colors.white,
      side: BorderSide(color: Colors.grey[300]!),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () {},
      labelStyle: TextStyle(color: Colors.grey[800]),
    );
  }

  Widget _buildMessage(
      {required String text, required bool isUser, String? date}) {
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
                backgroundColor: Colors.white,
                radius: 16,
                child:
                    Icon(Icons.smart_toy, size: 20, color: Colors.grey[600]),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: isUser ? const Color(0xFF2E7D32) : Colors.white,
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
                    boxShadow: [
                      if (!isUser)
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
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                    ],
                    Text(text,
                        style: TextStyle(
                            color: isUser ? Colors.white : Colors.black87)),
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
