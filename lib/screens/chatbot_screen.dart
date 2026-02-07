import 'package:flutter/material.dart';
import '../utils/app_state.dart';
import '../theme/app_theme.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages = [];
  bool _canType = false; // Always false now based on requirement
  List<String> _currentChips = []; // State for current options

  final Map<String, dynamic> _chatData = {
    'en': {
      'greeting': "Hello! I am your AI Farm Assistant. How can I help you regarding your farm?",
      'chips': ["Crop Disease", "Fertilizer", "Weather Forecast", "Soil Health"],
      'main_menu': "Main Menu",
      'responses': {
        'Crop Disease': "Based on recent analysis, I detect signs of Leaf Blight.\n\nRecommendation:\n1. Apply Copper Oxychloride 50WP (2g/liter).\n2. Reduce nitrogen fertilizer temporarily.\n3. Ensure proper drainage.",
        'Fertilizer': "Your NPK levels are: N-High, P-Medium, K-Low.\n\nAdvice:\n- Add 15kg Potash/acre.\n- Skipping Urea for now is recommended to save costs.",
        'Weather Forecast': "Forecast for next 3 days:\n- Today: Sunny, 32°C\n- Tomorrow: Cloudy, 30°C\n- Day after: Light Rain, 28°C\n\nAlert: Plan irrigation for tomorrow evening.",
        'Soil Health': "Soil Moisture: 45% (Optimal)\npH Level: 6.5 (Neutral)\n\nYour soil is in good condition for the current Rice crop."
      }
    },
    'hi': {
      'greeting': "नमस्ते! मैं आपका एआई कृषि सहायक हूँ। मैं आपकी कैसे मदद कर सकता हूँ?",
      'chips': ["फसल रोग", "खाद/उर्वरक", "मौसम पूर्वानुमान", "मृदा स्वास्थ्य"],
      'main_menu': "मुख्य मेनू",
      'responses': {
        'फसल रोग': "हाल के विश्लेषण के आधार पर, मुझे 'लीफ ब्लाइट' (पत्तियों का झुलसा रोग) के लक्षण मिले हैं।\n\nसुझाव:\n1. कॉपर ऑक्सीक्लोराइड 50WP (2 ग्राम/लीटर) का छिड़काव करें।\n2. कुछ समय के लिए नाइट्रोजन खाद कम करें।\n3. खेत में पानी की निकासी सुनिश्चित करें।",
        'खाद/उर्वरक': "आपके खेत में NPK स्तर:\n- नाइट्रोजन: उच्च\n- फास्फोरस: मध्यम\n- पोटैशियम: कम\n\nसलाह:\n- 15 किलो पोटाश प्रति एकड़ डालें।\n- अभी यूरिया का प्रयोग न करें, इससे लागत बचेगी।",
        'मौसम पूर्वानुमान': "अगले 3 दिनों का पूर्वानुमान:\n- आज: धूप, 32°C\n- कल: बादल छाए रहेंगे, 30°C\n- परसों: हल्की बारिश, 28°C\n\nचेतावनी: सिंचाई की योजना कल शाम के लिए बनाएं।",
        'मृदा स्वास्थ्य': "मिट्टी की नमी: 45% (इष्टतम)\npH स्तर: 6.5 (तटस्थ)\n\nआपकी मिट्टी मौजूदा धान की फसल के लिए अच्छी स्थिति में है।"
      }
    },
    'te': {
      'greeting': "నమస్తే! నేను మీ AI రైతు సహాయకుడిని. నేను మీకు ఎలా సహాయపడగలను?",
      'chips': ["పంట తెగుళ్ళు", "ఎరువులు", "వాతావరణం", "నేల ఆరోగ్యం"],
      'main_menu': "ప్రధాన మెనూ",
      'responses': {
        'పంట తెగుళ్ళు': "మీ పంటలో 'లీఫ్ బ్లైట్' లక్షణాలు కనిపిస్తున్నాయి.\n\nసలహా:\n1. కాపర్ ఆక్సిక్లోరైడ్ 50WP (2 గ్రాములు/లీటర్) పిచికారీ చేయండి.\n2. నత్రజని ఎరువును తగ్గించండి.\n3. పొలంలో నీరు నిల్వ ఉండకుండా చూసుకోండి.",
        'ఎరువులు': "మీ నేల NPK స్థాయిలు:\n- నత్రజని: ఎక్కువ\n- భాస్వరం: మధ్యస్థం\n- పొటాషియం: తక్కువ\n\nసూచన:\n- ఎకరానికి 15 కిలోల పొటాష్ వేయండి.\n- ప్రస్తుతం యూరియా వేయకండి, దీనివల్ల ఖర్చు తగ్గుతుంది.",
        'వాతావరణం': "రాబోయే 3 రోజుల వాతావరణం:\n- ఈ రోజు: ఎండ, 32°C\n- రేపు: మేఘావృతం, 30°C\n- ఎల్లుండి: తేలికపాటి వర్షం, 28°C\n\nహెచ్చరిక: నీటి పారుదల రేపు సాయంత్రం ప్లాన్ చేయండి.",
        'నేల ఆరోగ్యం': "నేల తేమ: 45% (సరిైనది)\npH స్థాయి: 6.5 (తటస్థ)\n\nప్రస్తుత వరి పంటకు మీ నేల అనుకూలంగా ఉంది."
      }
    }
  };

  void _initializeChatIfNeeded(String langCode) {
    if (_messages.isEmpty) {
      final data = _chatData[langCode] ?? _chatData['en'];
       _messages.add({
        "text": data['greeting'],
        "isUser": false,
        "date": "Now"
      });
      _currentChips = List<String>.from(data['chips']);
    } else {
       // Ideally we check if chips need reset on lang change, but simple init check is fine for now
       if (_currentChips.isEmpty) {
          final data = _chatData[langCode] ?? _chatData['en'];
          _currentChips = List<String>.from(data['chips']);
       }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
       final isHighContrast = AppState.instance.isHighContrast;
       final langCode = AppState.instance.languageCode;
       final currentData = _chatData[langCode] ?? _chatData['en'];
       
       _initializeChatIfNeeded(langCode);

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
              children: _currentChips.map((label) {
                 return Padding(
                   padding: const EdgeInsets.only(right: 8.0),
                   child: _buildOptionChip(label, isHighContrast, currentData),
                 );
              }).toList(),
            ),
          ),
          // Text Input Removed as per requirements ("defined options only")
           Container(
             padding: const EdgeInsets.all(16),
             alignment: Alignment.center,
             child: Text(
               langCode == 'hi' ? "जारी रखने के लिए एक विकल्प चुनें" : (langCode == 'te' ? "కొనసాగించడానికి ఒక ఎంపికను ఎంచుకోండి" : "Select an option to continue"),
               style: TextStyle(color: Colors.grey),
             ),
           )
        ],
      );
     }
    );
  }

  void _handleSubmitted(String text, Map<String, dynamic> currentData) {
    if (text.trim().isEmpty) return;

    // Handle "Main Menu" selection strictly
    if (text == currentData['main_menu']) {
      setState(() {
        _messages.add({"text": text, "isUser": true});
        _currentChips = List<String>.from(currentData['chips']); // Reset chips
      });
      _scrollToBottom();
      
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          setState(() {
             _messages.add({
                "text": currentData['greeting'], // Re-greet
                "isUser": false,
             });
          });
          _scrollToBottom();
        }
      });
      return;
    }

    setState(() {
      _messages.add({"text": text, "isUser": true});
      // Clear chips while thinking or keep them disabled? Let's hide them temporarily
      _currentChips = [];
    });
    _scrollToBottom();

    // Find predefined response matching chip label, or fallback
    String response = currentData['responses'][text]; 
    
    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add({
            "text": response ?? _getAIResponse(text, AppState.instance.languageCode),
            "isUser": false,
          });
          
          // Show Main Menu option after response
          _currentChips = [currentData['main_menu']!]; 
        });
        _scrollToBottom();
      }
    });

  }

  String _getAIResponse(String query, String langCode) {
    // Fallback simple keyword matching if they type manually later
    query = query.toLowerCase();
    if (langCode == 'hi') {
       return "मुझे खेद है, मेरे पास अभी इसका उत्तर नहीं है। कृपया ऊपर दिए गए विकल्पों में से प्रयास करें।";
    } else if (langCode == 'te') {
       return "క్షమించండి, నాకు దీనికి సమాధానం లేదు. దయచేసి పై ఎంపికల నుండి ప్రయత్నించండి.";
    }

    if (query.contains("disease")) {
      return "Detected: Leaf Blight. Recommendation: Apply Copper Oxychloride 50WP.";
    } else if (query.contains("fertilizer")) {
      return "Current NPK levels are good, but you may need 20kg Urea per acre next week.";
    } else if (query.contains("weather")) {
      return "Tomorrow: Mostly Sunny, 29°C. No rain expected.";
    }
    return "I can help you with crop advice, weather updates, and soil health.";
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

  Widget _buildOptionChip(String label, bool isHighContrast, Map<String, dynamic> data) {
    return ActionChip(
      label: Text(label),
      backgroundColor: isHighContrast ? Colors.grey[900] : Colors.white,
      side: BorderSide(color: isHighContrast ? Colors.white70 : AppColors.creamDark),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () => _handleSubmitted(label, data),
      labelStyle: TextStyle(color: isHighContrast ? Colors.white : AppColors.soil),
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
                      ? (isHighContrast ? Colors.grey[800] : AppColors.farmGreen) 
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
