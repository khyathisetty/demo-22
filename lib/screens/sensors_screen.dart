import 'package:flutter/material.dart';
import '../utils/app_state.dart';

class SensorsScreen extends StatelessWidget {
  const SensorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
       final isHighContrast = AppState.instance.isHighContrast;
       
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
                AppState.instance.getString('live_updates'),
                style: TextStyle(
                  color: isHighContrast ? Colors.white70 : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSensorCard(
            title: AppState.instance.getString('soil_moisture'),
            icon: Icons.water_drop_outlined,
            value: '45%',
            status: AppState.instance.getString('optimal'),
            statusColor: isHighContrast ? Colors.greenAccent : Colors.green.shade100,
            statusTextColor: isHighContrast ? Colors.black : Colors.green.shade800,
            progress: 0.45,
            progressColor: isHighContrast ? Colors.greenAccent : Colors.green,
            isHighContrast: isHighContrast,
          ),
          _buildSensorCard(
            title: AppState.instance.getString('temperature'),
            icon: Icons.thermostat_outlined,
            value: '27°C',
            status: AppState.instance.getString('optimal'),
            statusColor: isHighContrast ? Colors.orangeAccent : Colors.orange.shade100,
            statusTextColor: isHighContrast ? Colors.black : Colors.orange.shade800,
            progress: 0.6, 
            progressColor: isHighContrast ? Colors.orangeAccent : Colors.orange,
            isHighContrast: isHighContrast,
          ),
          _buildNpkDetailedCard(isHighContrast),
        ],
      );
     }
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
    required bool isHighContrast,
  }) {
    return Card(
      color: isHighContrast ? Colors.grey[900] : Colors.white,
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
                    Icon(icon, color: isHighContrast ? Colors.white : Colors.green[700], size: 20),
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
              backgroundColor: isHighContrast ? Colors.grey[700] : Colors.grey[200],
              color: progressColor,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNpkDetailedCard(bool isHighContrast) {
    return Card(
      color: isHighContrast ? Colors.grey[900] : Colors.white,
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
                    Icon(Icons.layers, color: isHighContrast ? Colors.brown[200] : Colors.brown[400], size: 20),
                    const SizedBox(width: 8),
                    Text(AppState.instance.getString('nutrient_levels'),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const Text('mg/kg',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 16),
            _buildNutrientRow("${AppState.instance.getString('nitrogen')} (N)", 80, 0.8, Colors.green, isHighContrast),
            const SizedBox(height: 12),
            _buildNutrientRow("${AppState.instance.getString('phosphorus')} (P)", 60, 0.6, Colors.cyan, isHighContrast),
            const SizedBox(height: 12),
            _buildNutrientRow("${AppState.instance.getString('potassium')} (K)", 55, 0.55, Colors.amber, isHighContrast),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientRow(
      String label, int value, double progress, Color color, bool isHighContrast) {
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
          backgroundColor: isHighContrast ? Colors.grey[700] : Colors.grey[200],
          color: color,
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }
}
