import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          'Welcome Back',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          "Here is your farm's overview",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 20),
        _buildInfoCard(
          context,
          icon: Icons.water_drop_outlined,
          title: 'Soil Moisture',
          value: '45%',
          status: 'Optimal',
          statusColor: Colors.green,
          iconBgColor: Colors.green.shade50,
        ),
        _buildInfoCard(
          context,
          icon: Icons.thermostat_outlined,
          title: 'Soil Temp',
          value: '27°C',
          status: 'Suitable',
          statusColor: Colors.green,
          iconBgColor: Colors.orange.shade50,
          iconColor: Colors.orange,
        ),
        _buildNpkCard(context),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String value,
      required String status,
      required Color statusColor,
      required Color iconBgColor,
      Color? iconColor}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 20, color: Colors.grey[700]),
                      const SizedBox(width: 8),
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(value,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(status,
                      style: TextStyle(
                          color: statusColor, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: iconColor ?? Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNpkCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.layers, size: 20, color: Colors.grey[700]),
                const SizedBox(width: 8),
                const Text('Soil NPK Levels',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNpkItem('Nitrogen', '80', Colors.green),
                _buildNpkItem('Phosphorus', '60', Colors.green),
                _buildNpkItem('Potassium', '55', Colors.green),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Status: Balanced',
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNpkItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(color: Colors.black54, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                color: color, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
