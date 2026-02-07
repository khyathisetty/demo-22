import 'package:flutter/material.dart';
import '../utils/app_state.dart';
import '../theme/app_theme.dart';

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isHighContrast ? Colors.grey[800] : AppColors.farmGreen.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: isHighContrast ? Colors.grey[700]! : AppColors.farmGreen.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: isHighContrast ? const Color(0xFF00FF00) : AppColors.farmGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  AppState.instance.getString('live_updates'),
                  style: TextStyle(
                    color: isHighContrast ? Colors.white70 : AppColors.farmGreenDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildSensorCard(
            title: AppState.instance.getString('soil_moisture'),
            icon: Icons.water_drop_outlined,
            value: '45%',
            status: AppState.instance.getString('optimal'),
            statusColor: isHighContrast ? Colors.greenAccent : AppColors.skyLight,
            statusTextColor: isHighContrast ? Colors.black : AppColors.farmGreenDark,
            progress: 0.45,
            progressColor: isHighContrast ? Colors.greenAccent : AppColors.farmGreen,
            isHighContrast: isHighContrast,
          ),
          _buildSensorCard(
            title: AppState.instance.getString('temperature'),
            icon: Icons.thermostat_outlined,
            value: '27°C',
            status: AppState.instance.getString('optimal'),
            statusColor: isHighContrast ? Colors.orangeAccent : AppColors.wheatLight.withValues(alpha: 0.6),
            statusTextColor: isHighContrast ? Colors.black : AppColors.wheatGold,
            progress: 0.6,
            progressColor: isHighContrast ? Colors.orangeAccent : AppColors.wheatGold,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isHighContrast ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isHighContrast ? Colors.grey[700]! : AppColors.creamDark),
        boxShadow: [
          BoxShadow(
            color: AppColors.earthBrown.withValues(alpha: isHighContrast ? 0 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: isHighContrast ? Colors.white : AppColors.farmGreen, size: 20),
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
            backgroundColor: isHighContrast ? Colors.grey[700] : AppColors.creamDark,
            color: progressColor,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildNpkDetailedCard(bool isHighContrast) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isHighContrast ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isHighContrast ? Colors.grey[700]! : AppColors.creamDark),
        boxShadow: [
          BoxShadow(
            color: AppColors.earthBrown.withValues(alpha: isHighContrast ? 0 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.layers_rounded, color: isHighContrast ? Colors.brown[200] : AppColors.earthBrownLight, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    AppState.instance.getString('nutrient_levels'),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const Text('mg/kg', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          _buildNutrientRow("${AppState.instance.getString('nitrogen')} (N)", 80, 0.8, AppColors.farmGreen, isHighContrast),
          const SizedBox(height: 12),
          _buildNutrientRow("${AppState.instance.getString('phosphorus')} (P)", 60, 0.6, AppColors.earthBrownLight, isHighContrast),
          const SizedBox(height: 12),
          _buildNutrientRow("${AppState.instance.getString('potassium')} (K)", 55, 0.55, AppColors.wheatGold, isHighContrast),
        ],
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
          backgroundColor: isHighContrast ? Colors.grey[700] : AppColors.creamDark,
          color: color,
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }
}
