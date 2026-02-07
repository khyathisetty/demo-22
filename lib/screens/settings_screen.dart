import 'package:flutter/material.dart';
import '../utils/app_state.dart';
import '../utils/user_storage.dart';
import '../theme/app_theme.dart';
import '../widgets/common_background.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool highContrast = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppState.instance.getString('settings')),
            centerTitle: true,
            backgroundColor: AppState.instance.isHighContrast ? Colors.black : AppColors.farmGreenDark,
            foregroundColor: Colors.white,
          ),
          body: CommonBackground(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Language
                Text(
                  AppState.instance.getString('language'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.creamDark),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.earthBrown.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildLanguageTile('English', 'en'),
                      const Divider(height: 1),
                      _buildLanguageTile('हिंदी', 'hi'),
                      const Divider(height: 1),
                      _buildLanguageTile('தமிழ்', 'ta'),
                      const Divider(height: 1),
                      _buildLanguageTile('తెలుగు', 'te'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  AppState.instance.getString('general'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.creamDark),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.earthBrown.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildSwitchTile(
                        title: AppState.instance.getString('weather_alert'),
                        icon: Icons.notifications,
                        value: notificationsEnabled,
                        onChanged: (val) {
                          setState(() => notificationsEnabled = val);
                        },
                      ),
                      const Divider(height: 1),
                      _buildSwitchTile(
                        title: AppState.instance.getString('high_contrast'),
                        icon: Icons.contrast,
                        value: highContrast,
                        onChanged: (val) {
                          setState(() => highContrast = val);
                          AppState.instance.setHighContrast(val);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Account',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.creamDark),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.earthBrown.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: Text(
                      AppState.instance.getString('login'),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text('Sign out of this device'),
                    onTap: () async {
                      await UserStorage.setCurrentUser(null);
                      AppState.instance.setCurrentUserName(null);
                      if (!context.mounted) return;
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (_) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageTile(String label, String code) {
    final isSelected = AppState.instance.languageCode == code;
    return ListTile(
      title: Text(label),
      trailing: isSelected ? const Icon(Icons.check, color: AppColors.farmGreen) : null,
      onTap: () {
        AppState.instance.setLanguage(code);
      },
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      secondary: Icon(icon),
      activeColor: AppColors.farmGreen,
    );
  }
}
