import 'package:flutter/material.dart';

class SensorsScreen extends StatelessWidget {
  const SensorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Live Updates Active',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSensorCard(
          title: 'Soil Moisture',
          icon: Icons.water_drop_outlined,
          value: '45%',
          status: 'Optimal',
          statusColor: Colors.green.shade100,
          statusTextColor: Colors.green.shade800,
          progress: 0.45,
          progressColor: Colors.green,
        ),
        _buildSensorCard(
          title: 'Temperature',
          icon: Icons.thermostat_outlined,
          value: '27°C',
          status: 'Normal',
          statusColor: Colors.orange.shade100,
          statusTextColor: Colors.orange.shade800,
          progress: 0.6, // Approximate for 27 C
          progressColor: Colors.orange,
        ),
        _buildNpkDetailedCard(),
      ],
    );
  }

  Widget _buildSensorCard({
    required String title,
    required IconData icon,
    required String value,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    required double progress,
    required Color progressColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Colors.green[700], size: 20),
                    const SizedBox(width: 8),
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                        color: statusTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(value,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: progressColor,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNpkDetailedCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.layers, color: Colors.brown[400], size: 20),
                    const SizedBox(width: 8),
                    const Text('Nutrient Levels (NPK)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const Text('mg/kg',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 16),
            _buildNutrientRow('Nitrogen (N)', 80, 0.8, Colors.green),
            const SizedBox(height: 12),
            _buildNutrientRow('Phosphorus (P)', 60, 0.6, Colors.cyan),
            const SizedBox(height: 12),
            _buildNutrientRow('Potassium (K)', 55, 0.55, Colors.amber),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientRow(
      String label, int value, double progress, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(value.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          color: color,
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }
}
