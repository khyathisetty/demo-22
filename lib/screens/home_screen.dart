import 'package:flutter/material.dart';
import '../utils/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          AppState.instance.getString('welcome_back'),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppState.instance.isHighContrast ? const Color(0xFF00FF00) : const Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          AppState.instance.getString('farm_overview'),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppState.instance.isHighContrast ? Colors.white : Colors.grey[600],
              ),
        ),
        const SizedBox(height: 20),
        // Placeholder for farm image
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
             // Using a network image as a placeholder for "Agriculture"
             // If offline, it won't show, but the color and icon will act as fallback.
              image: NetworkImage('https://images.unsplash.com/photo-1500382017468-9049fed747ef?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(16),
             child: Row(
              children: [
                const Icon(Icons.photo_camera, color: Colors.white70),
                const SizedBox(width: 8),
                Text(
                  AppState.instance.getString('my_farm_view'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildInfoCard(
          context,
          icon: Icons.water_drop_outlined,
          title: AppState.instance.getString('soil_moisture'),
          value: '45%',
          status: AppState.instance.getString('optimal'),
          statusColor: AppState.instance.isHighContrast ? const Color(0xFF00FF00) : Colors.green,
          iconBgColor: AppState.instance.isHighContrast ? Colors.green.withOpacity(0.2) : Colors.green.shade50,
        ),
        _buildInfoCard(
          context,
          icon: Icons.thermostat_outlined,
          title: AppState.instance.getString('soil_temp'),
          value: '27°C',
          status: AppState.instance.getString('suitable'),
          statusColor: AppState.instance.isHighContrast ? const Color(0xFF00FF00) : Colors.green,
          iconBgColor: AppState.instance.isHighContrast ? Colors.orange.withOpacity(0.2) : Colors.orange.shade50,
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
      color: AppState.instance.isHighContrast ? Colors.grey[900] : Colors.white,
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
                      Icon(icon, size: 20, color: AppState.instance.isHighContrast ? Colors.white : Colors.grey[700]),
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
              child: Icon(icon, size: 32, color: iconColor ?? (AppState.instance.isHighContrast ? const Color(0xFF00FF00) : Colors.green)),
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
      color: AppState.instance.isHighContrast ? Colors.grey[900] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.layers, size: 20, color: AppState.instance.isHighContrast ? Colors.white : Colors.grey[700]),
                const SizedBox(width: 8),
                 Text(AppState.instance.getString('soil_npk'),
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNpkItem(AppState.instance.getString('nitrogen'), '80', AppState.instance.isHighContrast ? const Color(0xFF00FF00) : Colors.green),
                _buildNpkItem(AppState.instance.getString('phosphorus'), '60', AppState.instance.isHighContrast ? const Color(0xFF00FF00) : Colors.green),
                _buildNpkItem(AppState.instance.getString('potassium'), '55', AppState.instance.isHighContrast ? const Color(0xFF00FF00) : Colors.green),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
             Center(
              child: Text(
                'Status: ${AppState.instance.getString('balanced')}',
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
            style: TextStyle(color: AppState.instance.isHighContrast ? Colors.white70 : Colors.black54, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                color: color, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
