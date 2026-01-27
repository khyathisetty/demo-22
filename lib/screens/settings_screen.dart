import 'package:flutter/material.dart';
import '../widgets/common_background.dart';
import '../utils/app_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Use AppState for language
  bool _weatherAlert = true;
  bool _waterAlert = true;
  bool _cropTips = false;
  bool _priceUpdates = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppState.instance.getString('settings')),
            backgroundColor: AppState.instance.isHighContrast ? Colors.black : const Color(0xFF2E7D32),
          ),
          body: CommonBackground(
            child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSectionHeader(AppState.instance.getString('my_profile')),
              Card(
                color: AppState.instance.isHighContrast ? Colors.grey[900] : Colors.white,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildProfileRow(AppState.instance.getString('name'), "Farmer John", Icons.person_outline),
                      const Divider(),
                      _buildProfileRow(AppState.instance.getString('phone'), "+91 98765 43210", null),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(AppState.instance.getString('my_farm')),
              Card(
                color: AppState.instance.isHighContrast ? Colors.grey[900] : Colors.white,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildProfileRow(AppState.instance.getString('location'), "Karnataka, India",
                          Icons.location_on_outlined),
                      const Divider(),
                      _buildProfileRow(AppState.instance.getString('farm_size'), "2.5 Hectares", null),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(AppState.instance.getString('alerts')),
              Card(
                color: AppState.instance.isHighContrast ? Colors.grey[900] : Colors.white,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    _buildSwitchTile(
                        AppState.instance.getString('weather_alert'), 
                        Icons.notifications_none, 
                        _weatherAlert,
                        (val) => setState(() => _weatherAlert = val)
                    ),
                    const Divider(height: 1),
                    _buildSwitchTile(
                        AppState.instance.getString('water_alert'), 
                        null, 
                        _waterAlert,
                         (val) => setState(() => _waterAlert = val)
                    ),
                    const Divider(height: 1),
                    _buildSwitchTile(
                        AppState.instance.getString('crop_tips'), 
                        null, 
                        _cropTips,
                         (val) => setState(() => _cropTips = val)
                    ),
                    const Divider(height: 1),
                    _buildSwitchTile(
                        AppState.instance.getString('price_updates'), 
                        null, 
                        _priceUpdates,
                         (val) => setState(() => _priceUpdates = val)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(AppState.instance.getString('general')),
              Card(
                color: AppState.instance.isHighContrast ? Colors.grey[900] : Colors.white,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: Text(AppState.instance.getString('language')),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_getLanguageName(AppState.instance.languageCode),
                              style: const TextStyle(color: Colors.grey)),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                      onTap: () {
                        _showLanguageDialog();
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.help_outline),
                      title: Text(AppState.instance.getString('help_support')),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: Text(AppState.instance.getString('app_info')),
                      trailing: const Text("v1.0.0", style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppState.instance.isHighContrast ? Colors.grey[800] : const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppState.instance.getString('exit_saved')),
                        backgroundColor: const Color(0xFF2E7D32),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.save, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(AppState.instance.getString('save_changes'),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppState.instance.getString('exit_settings'),
                          style: const TextStyle(color: Colors.green, fontSize: 16)))),
            ],
          ),
        ));
      }
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en': return 'English';
      case 'hi': return 'Hindi';
      case 'te': return 'Telugu';
      default: return 'English';
    }
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('English', 'en'),
              _buildLanguageOption('Hindi', 'hi'),
              _buildLanguageOption('Telugu', 'te'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language, String code) {
    return ListTile(
      title: Text(language),
       trailing: AppState.instance.languageCode == code
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () {
        AppState.instance.setLanguage(code);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(title,
          style: TextStyle(
              color: AppState.instance.isHighContrast ? const Color(0xFF00FF00) : Colors.green[700],
              fontWeight: FontWeight.bold,
              fontSize: 14)),
    );
  }

  Widget _buildProfileRow(String label, String value, IconData? icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 16)
          ],
          if (icon == null) const SizedBox(width: 40),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(value,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, IconData? icon, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      secondary: icon != null
          ? Icon(icon)
          : const SizedBox(width: 24), // Placeholder for alignment
      activeColor: const Color(0xFF2E7D32),
    );
  }
}
