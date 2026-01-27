import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader("MY PROFILE"),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProfileRow("Name", "Farmer John", Icons.person_outline),
                  const Divider(),
                  _buildProfileRow("Phone", "+91 98765 43210", null),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader("MY FARM"),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProfileRow("Location", "Karnataka, India",
                      Icons.location_on_outlined),
                  const Divider(),
                  _buildProfileRow("Farm Size", "2.5 Hectares", null),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader("ALERTS"),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                _buildSwitchTile(
                    "Weather Alert", Icons.notifications_none, true),
                const Divider(height: 1),
                _buildSwitchTile("Water Alert", null, true),
                const Divider(height: 1),
                _buildSwitchTile("Crop Tips", null, false),
                const Divider(height: 1),
                _buildSwitchTile("Price Updates", null, true),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader("GENERAL"),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text("Language"),
                  trailing: const Text("English",
                      style: TextStyle(color: Colors.grey)),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text("Help & Support"),
                  trailing: Icon(Icons.chevron_right),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text("App Info"),
                  trailing: Text("v1.0.0", style: TextStyle(color: Colors.grey)),
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
                backgroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Save Changes",
                      style: TextStyle(
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
                  child: const Text("Exit Settings",
                      style: TextStyle(color: Colors.green, fontSize: 16)))),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(title,
          style: TextStyle(
              color: Colors.green[700],
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

  Widget _buildSwitchTile(String title, IconData? icon, bool value) {
    return SwitchListTile(
      value: value,
      onChanged: (v) {},
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      secondary: icon != null
          ? Icon(icon)
          : const SizedBox(width: 24), // Placeholder for alignment
      activeColor: const Color(0xFF2E7D32),
    );
  }
}
