import 'package:flutter/material.dart';
import '../utils/app_state.dart';

class CropsScreen extends StatelessWidget {
  const CropsScreen({super.key});

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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isHighContrast ? Colors.green.withOpacity(0.1) : Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border(left: BorderSide(color: isHighContrast ? Colors.greenAccent : Colors.green, width: 4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppState.instance.getString('ai_analysis'),
                    style: TextStyle(
                        color: isHighContrast ? Colors.greenAccent : Colors.green[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                const SizedBox(height: 4),
                Text(AppState.instance.getString('analysis_desc'),
                    style: TextStyle(color: isHighContrast ? Colors.white70 : Colors.green[700])),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCropCard(
            name: "Rice",
            matchStatus: AppState.instance.getString('high_match'),
            matchColor: Colors.green,
            description:
                "Requires high moisture. Suitable for your current soil retention capacity.",
            tags: [
              {"label": "Moisture: High", "icon": Icons.water_drop},
              {"label": "NPK: Nitrogen Heavy", "icon": Icons.science},
            ],
            barColor: Colors.green,
            isHighContrast: isHighContrast,
          ),
          _buildCropCard(
            name: "Maize",
            matchStatus: AppState.instance.getString('moderate_match'),
            matchColor: Colors.orange,
            description:
                "Good for current temperature (27°C). Ensure phosphorus levels are maintained.",
            tags: [
              {"label": "Moisture: Moderate", "icon": Icons.water_drop},
              {"label": "Temp: 25-30°C", "icon": Icons.thermostat},
            ],
            barColor: Colors.lightGreen,
            isHighContrast: isHighContrast,
          ),
          _buildCropCard(
            name: "Groundnut",
            matchStatus: AppState.instance.getString('excellent_match'),
            matchColor: Colors.green[700]!,
            description:
                "Nitrogen fixing crop. Will help balance excess nitrogen in later cycles.",
            tags: [
              {"label": "Soil: Loamy", "icon": Icons.grass},
              {"label": "Nutrients: Balanced", "icon": Icons.check_circle},
            ],
            barColor: Colors.amber,
            isHighContrast: isHighContrast,
          ),
        ],
      );
     }
    );
  }

  Widget _buildCropCard({
    required String name,
    required String matchStatus,
    required Color matchColor,
    required String description,
    required List<Map<String, dynamic>> tags,
    required Color barColor,
    required bool isHighContrast,
  }) {
    return Card(
      color: isHighContrast ? Colors.grey[900] : Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: barColor, width: 6)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: isHighContrast ? Colors.grey[800] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(matchStatus,
                        style: TextStyle(
                            color: isHighContrast ? Colors.white70 : Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(description,
                  style: TextStyle(color: isHighContrast ? Colors.grey[300] : Colors.grey[600], height: 1.4)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags
                    .map((tag) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isHighContrast ? Colors.grey[800] : Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: isHighContrast ? Colors.grey[700]! : Colors.green.shade100),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(tag['icon'] as IconData,
                                  size: 16, color: isHighContrast ? Colors.greenAccent : Colors.green[700]),
                              const SizedBox(width: 8),
                              Text(tag['label'] as String,
                                  style: TextStyle(
                                      color: isHighContrast ? Colors.green[100] : Colors.green[800],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
