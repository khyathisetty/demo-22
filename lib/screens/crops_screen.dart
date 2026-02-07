import 'package:flutter/material.dart';
import '../utils/app_state.dart';
import '../theme/app_theme.dart';

class CropsScreen extends StatelessWidget {
  const CropsScreen({super.key});

  String _t(String key, String fallback) {
    final value = AppState.instance.getString(key);
    return value.isEmpty ? fallback : value;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final bool isHighContrast = AppState.instance.isHighContrast;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ================= AI ANALYSIS CARD =================
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isHighContrast
                    ? Colors.green.withOpacity(0.15)
                    : AppColors.skyLight,
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  left: BorderSide(
                    color: isHighContrast
                        ? Colors.greenAccent
                        : AppColors.farmGreen,
                    width: 4,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _t('ai_analysis', 'AI Crop Analysis'),
                    style: TextStyle(
                      color: isHighContrast
                          ? Colors.greenAccent
                          : AppColors.farmGreenDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _t(
                      'analysis_desc',
                      'Based on soil nutrients, temperature and moisture levels.',
                    ),
                    style: TextStyle(
                      color:
                          isHighContrast ? Colors.white : AppColors.soil,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= RICE =================
            _buildCropCard(
              name: "Rice",
              matchStatus: _t('high_match', 'High Match'),
              matchColor: Colors.green,
              description:
                  "Requires high moisture. Suitable for your current soil retention capacity.",
              tags: const [
                {"label": "Moisture: High", "icon": Icons.water_drop},
                {"label": "NPK: Nitrogen Heavy", "icon": Icons.science},
              ],
              barColor: AppColors.farmGreen,
              isHighContrast: isHighContrast,
            ),

            // ================= MAIZE =================
            _buildCropCard(
              name: "Maize",
              matchStatus: _t('moderate_match', 'Moderate Match'),
              matchColor: AppColors.wheatGold,
              description:
                  "Good for current temperature (27°C). Ensure phosphorus levels are maintained.",
              tags: const [
                {"label": "Moisture: Moderate", "icon": Icons.water_drop},
                {"label": "Temp: 25–30°C", "icon": Icons.thermostat},
              ],
              barColor: AppColors.wheatLight,
              isHighContrast: isHighContrast,
            ),

            // ================= GROUNDNUT =================
            _buildCropCard(
              name: "Groundnut",
              matchStatus: _t('excellent_match', 'Excellent Match'),
              matchColor: AppColors.farmGreenDark,
              description:
                  "Nitrogen-fixing crop. Helps balance soil nutrients in later cycles.",
              tags: const [
                {"label": "Soil: Loamy", "icon": Icons.grass},
                {"label": "Nutrients: Balanced", "icon": Icons.check_circle},
              ],
              barColor: AppColors.wheatGold,
              isHighContrast: isHighContrast,
            ),
          ],
        );
      },
    );
  }

  // ================= CROP CARD WIDGET =================
  Widget _buildCropCard({
    required String name,
    required String matchStatus,
    required Color matchColor,
    required String description,
    required List<Map<String, dynamic>> tags,
    required Color barColor,
    required bool isHighContrast,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isHighContrast ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          left: BorderSide(color: barColor, width: 6),
        ),
        boxShadow: isHighContrast
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:
                        isHighContrast ? Colors.white : Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: matchColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    matchStatus,
                    style: TextStyle(
                      color: matchColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // DESCRIPTION
            Text(
              description,
              style: TextStyle(
                color: isHighContrast
                    ? Colors.white70
                    : Colors.grey.shade700,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 16),

            // TAGS
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isHighContrast
                        ? Colors.grey.shade900
                        : AppColors.skyLight,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: barColor.withOpacity(0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        tag['icon'] as IconData,
                        size: 16,
                        color: isHighContrast
                            ? Colors.greenAccent
                            : barColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        tag['label'] as String,
                        style: TextStyle(
                          color: isHighContrast
                              ? Colors.white
                              : AppColors.farmGreenDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
