import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CommonBackground extends StatelessWidget {
  final Widget child;

  const CommonBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.cream,
            AppColors.creamDark,
            Color(0xFFFFF3E0),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
