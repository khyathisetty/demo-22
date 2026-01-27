import 'package:flutter/material.dart';

class CropsScreen extends StatelessWidget {
  const CropsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(16),
            border: const Border(left: BorderSide(color: Colors.green, width: 4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("AI Analysis Complete",
                  style: TextStyle(
                      color: Colors.green[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              const SizedBox(height: 4),
              Text("Based on soil sensor readings from today.",
                  style: TextStyle(color: Colors.green[700])),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildCropCard(
          name: "Rice",
          matchStatus: "High Match",
          matchColor: Colors.green,
          description:
              "Requires high moisture. Suitable for your current soil retention capacity.",
          tags: [
            {"label": "Moisture: High", "icon": Icons.water_drop},
            {"label": "NPK: Nitrogen Heavy", "icon": Icons.science},
          ],
          barColor: Colors.green,
        ),
        _buildCropCard(
          name: "Maize",
          matchStatus: "Moderate Match",
          matchColor: Colors.orange,
          description:
              "Good for current temperature (27°C). Ensure phosphorus levels are maintained.",
          tags: [
            {"label": "Moisture: Moderate", "icon": Icons.water_drop},
            {"label": "Temp: 25-30°C", "icon": Icons.thermostat},
          ],
          barColor: Colors.lightGreen,
        ),
        _buildCropCard(
          name: "Groundnut",
          matchStatus: "Excellent Match",
          matchColor: Colors.green[700]!,
          description:
              "Nitrogen fixing crop. Will help balance excess nitrogen in later cycles.",
          tags: [
            {"label": "Soil: Loamy", "icon": Icons.grass},
            {"label": "Nutrients: Balanced", "icon": Icons.check_circle},
          ],
          barColor: Colors.amber,
        ),
      ],
    );
  }

  Widget _buildCropCard({
    required String name,
    required String matchStatus,
    required Color matchColor,
    required String description,
    required List<Map<String, dynamic>> tags,
    required Color barColor,
  }) {
    return Card(
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
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(matchStatus,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(description,
                  style: TextStyle(color: Colors.grey[600], height: 1.4)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags
                    .map((tag) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green.shade100),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(tag['icon'] as IconData,
                                  size: 16, color: Colors.green[700]),
                              const SizedBox(width: 8),
                              Text(tag['label'] as String,
                                  style: TextStyle(
                                      color: Colors.green[800],
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
