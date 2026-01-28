import 'package:flutter/material.dart';
import '../widgets/common_background.dart';
import 'home_screen.dart';
import 'sensors_screen.dart';
import 'chatbot_screen.dart';
import 'crops_screen.dart';
import 'settings_screen.dart';
import '../utils/app_state.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = const [
    HomeScreen(),
    SensorsScreen(),
    ChatbotScreen(),
    CropsScreen(),
  ];

  List<String> get _titles => [
    AppState.instance.getString('welcome'),
    AppState.instance.getString('sensors'),
    AppState.instance.getString('chatbot'),
    AppState.instance.getString('crops'),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
       return Scaffold(
          appBar: AppBar(
            title: Text(_titles[_currentIndex]),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: CommonBackground(
            child: _screens[_currentIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed, // Ensure label visibility and alignment
            selectedItemColor: AppState.instance.isHighContrast ? const Color(0xFF00FF00) : const Color(0xFF2E7D32),
            unselectedItemColor: Colors.grey,
            backgroundColor: AppState.instance.isHighContrast ? Colors.black : Colors.white,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppState.instance.getString('home'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.sensors),
                label: AppState.instance.getString('sensors'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.chat),
                label: AppState.instance.getString('chatbot'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.grass),
                label: AppState.instance.getString('crops'),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showAccessibilityOptions(context);
            },
            backgroundColor: AppState.instance.isHighContrast ? Colors.grey[800] : const Color(0xFF2E7D32),
            child: const Icon(Icons.accessibility_new, color: Colors.white),
          ),
        );
      }
    );
  }

  void _showAccessibilityOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AnimatedBuilder(
          animation: AppState.instance,
          builder: (context, _) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: AppState.instance.isHighContrast ? Colors.black : Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    AppState.instance.getString('accessibility_options'),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppState.instance.isHighContrast ? const Color(0xFF00FF00) : const Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.text_fields),
                    title: Text(AppState.instance.getString('large_text')),
                    trailing: Switch(
                      value: AppState.instance.isLargeText,
                      onChanged: (val) {
                        AppState.instance.setLargeText(val);
                      },
                      activeColor: const Color(0xFF2E7D32),
                      inactiveTrackColor: Colors.grey[300],
                      inactiveThumbColor: Colors.grey[50],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.contrast),
                    title: Text(AppState.instance.getString('high_contrast')),
                    trailing: Switch(
                      value: AppState.instance.isHighContrast,
                      onChanged: (val) {
                        AppState.instance.setHighContrast(val);
                      },
                      activeColor: const Color(0xFF2E7D32),
                      inactiveTrackColor: Colors.grey[300],
                      inactiveThumbColor: Colors.grey[50],
                    ),
                  ),
                   ListTile(
                    leading: const Icon(Icons.record_voice_over),
                    title: Text(AppState.instance.getString('screen_reader')),
                    trailing: Switch(
                      value: false, // Placeholder as we can't toggle OS screen reader
                      onChanged: (val) {
                         // Interactive but acts as a placeholder
                      },
                      activeColor: const Color(0xFF2E7D32),
                      inactiveTrackColor: Colors.grey[300],
                      inactiveThumbColor: Colors.grey[50],
                    ),
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }
}
