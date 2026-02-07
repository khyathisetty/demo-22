import 'package:flutter/material.dart';
import '../widgets/common_background.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'sensors_screen.dart';
import 'chatbot_screen.dart';
import 'crops_screen.dart';
import 'settings_screen.dart';
import '../utils/app_state.dart';
import '../utils/user_storage.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserName();
  }

  Future<void> _loadCurrentUserName() async {
    if (AppState.instance.currentUserName != null) return;
    final name = await UserStorage.getCurrentUserName();
    if (mounted && name != null) {
      AppState.instance.setCurrentUserName(name);
    }
  }

  final List<Widget> _screens = const [
    HomeScreen(),
    SensorsScreen(),
    ChatbotScreen(),
    CropsScreen(),
  ];

  String _getWelcomeTitle() {
    final name = AppState.instance.currentUserName;
    if (name != null && name.isNotEmpty) {
      return 'Hello, $name!';
    }
    return AppState.instance.getString('welcome');
  }

  List<String> get _titles => [
    _getWelcomeTitle(),
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
            backgroundColor: AppState.instance.isHighContrast ? Colors.black : AppColors.farmGreenDark,
            foregroundColor: Colors.white,
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
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppState.instance.isHighContrast ? Colors.black : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.earthBrown.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppState.instance.isHighContrast ? const Color(0xFF00FF00) : AppColors.farmGreen,
              unselectedItemColor: AppColors.earthBrownLight,
              backgroundColor: Colors.transparent,
              elevation: 0,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_rounded),
                  label: AppState.instance.getString('home'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.sensors_rounded),
                  label: AppState.instance.getString('sensors'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.chat_rounded),
                  label: AppState.instance.getString('chatbot'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.eco_rounded),
                  label: AppState.instance.getString('crops'),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAccessibilityOptions(context),
            backgroundColor: AppState.instance.isHighContrast ? Colors.grey[800] : AppColors.farmGreenDark,
            child: const Icon(Icons.accessibility_new_rounded, color: Colors.white),
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
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppState.instance.isHighContrast ? Colors.black : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border.all(color: AppColors.creamDark),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppState.instance.getString('accessibility_options'),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppState.instance.isHighContrast ? const Color(0xFF00FF00) : AppColors.farmGreen,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.text_fields_rounded, color: AppColors.earthBrownLight),
                    title: Text(AppState.instance.getString('large_text')),
                    trailing: Switch(
                      value: AppState.instance.isLargeText,
                      onChanged: (val) => AppState.instance.setLargeText(val),
                      activeColor: AppColors.farmGreen,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.contrast_rounded, color: AppColors.earthBrownLight),
                    title: Text(AppState.instance.getString('high_contrast')),
                    trailing: Switch(
                      value: AppState.instance.isHighContrast,
                      onChanged: (val) => AppState.instance.setHighContrast(val),
                      activeColor: AppColors.farmGreen,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.record_voice_over_rounded, color: AppColors.earthBrownLight),
                    title: Text(AppState.instance.getString('screen_reader')),
                    trailing: Switch(
                      value: false,
                      onChanged: (_) {},
                      activeColor: AppColors.farmGreen,
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
