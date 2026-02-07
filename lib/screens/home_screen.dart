import 'package:flutter/material.dart';
import '../utils/app_state.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = AppState.instance.currentUserName;
    final welcomeText = (name != null && name.isNotEmpty)
        ? '${AppState.instance.getString('welcome_back')}, $name!'
        : AppState.instance.getString('welcome_back');
    final isHC = AppState.instance.isHighContrast;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          welcomeText,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: isHC ? const Color(0xFF00FF00) : AppColors.farmGreenDark,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          AppState.instance.getString('farm_overview'),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isHC ? Colors.white70 : AppColors.soil.withValues(alpha: 0.8),
              ),
        ),
        const SizedBox(height: 20),
        // Farm / farmer hero image
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.farmGreen.withValues(alpha: 0.3),
                ),
                child: Image.network(
                  'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&q=80',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Center(
                    child: Icon(
                      Icons.agriculture,
                      size: 72,
                      color: AppColors.farmGreen.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54],
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.photo_camera_rounded, color: Colors.white70, size: 22),
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
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildInfoCard(
          context,
          icon: Icons.water_drop_outlined,
          title: AppState.instance.getString('soil_moisture'),
          value: '45%',
          status: AppState.instance.getString('optimal'),
          statusColor: isHC ? const Color(0xFF00FF00) : AppColors.farmGreen,
          iconBgColor: isHC ? AppColors.farmGreen.withValues(alpha: 0.3) : AppColors.skyLight,
        ),
        _buildInfoCard(
          context,
          icon: Icons.thermostat_outlined,
          title: AppState.instance.getString('soil_temp'),
          value: '27°C',
          status: AppState.instance.getString('suitable'),
          statusColor: isHC ? const Color(0xFF00FF00) : AppColors.wheatGold,
          iconBgColor: isHC ? AppColors.wheatGold.withValues(alpha: 0.3) : AppColors.wheatLight.withValues(alpha: 0.5),
          iconColor: AppColors.wheatGold,
        ),
        _buildNpkCard(context),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String status,
    required Color statusColor,
    required Color iconBgColor,
    Color? iconColor,
  }) {
    final isHC = AppState.instance.isHighContrast;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isHC ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isHC ? Colors.grey[700]! : AppColors.creamDark),
        boxShadow: [
          BoxShadow(
            color: AppColors.earthBrown.withValues(alpha: isHC ? 0 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 20, color: isHC ? Colors.white70 : AppColors.earthBrownLight),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: isHC ? Colors.white : AppColors.soil,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isHC ? Colors.white : AppColors.soil,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 32,
              color: iconColor ?? (isHC ? const Color(0xFF00FF00) : AppColors.farmGreen),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNpkCard(BuildContext context) {
    final isHC = AppState.instance.isHighContrast;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isHC ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isHC ? Colors.grey[700]! : AppColors.creamDark),
        boxShadow: [
          BoxShadow(
            color: AppColors.earthBrown.withValues(alpha: isHC ? 0 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.layers_rounded, size: 20, color: isHC ? Colors.white70 : AppColors.earthBrownLight),
              const SizedBox(width: 8),
              Text(
                AppState.instance.getString('soil_npk'),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: isHC ? Colors.white : AppColors.soil,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNpkItem(AppState.instance.getString('nitrogen'), '80', isHC ? const Color(0xFF00FF00) : AppColors.farmGreen, isHC),
              _buildNpkItem(AppState.instance.getString('phosphorus'), '60', isHC ? const Color(0xFF00FF00) : AppColors.earthBrownLight, isHC),
              _buildNpkItem(AppState.instance.getString('potassium'), '55', isHC ? const Color(0xFF00FF00) : AppColors.wheatGold, isHC),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(),
          Center(
            child: Text(
              'Status: ${AppState.instance.getString('balanced')}',
              style: TextStyle(
                color: AppColors.wheatGold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNpkItem(String label, String value, Color color, bool isHC) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: isHC ? Colors.white70 : AppColors.soil.withValues(alpha: 0.8),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
