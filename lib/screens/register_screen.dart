import 'package:flutter/material.dart';
import '../utils/app_state.dart';
import '../utils/user_storage.dart';
import '../widgets/common_background.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _villageController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _villageController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final village = _villageController.text.trim();
    final phone = _phoneController.text.trim();
    if (name.isEmpty || village.isEmpty || phone.isEmpty) {
      setState(() => _errorMessage = AppState.instance.getString('fill_all_fields'));
      return;
    }
    if (phone.length < 10) {
      setState(() => _errorMessage = AppState.instance.getString('invalid_phone'));
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await UserStorage.registerUser(
        FarmerUser(name: name, village: village, phone: phone),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppState.instance.getString('registration_success')),
          backgroundColor: AppColors.farmGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().contains('already')
            ? AppState.instance.getString('phone_already_registered')
            : e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 28),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.earthBrownLight.withValues(alpha: 0.2),
                  ),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=800&q=80',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Center(
                      child: Icon(Icons.people_alt, size: 64, color: AppColors.earthBrownLight),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: AppState.instance,
                builder: (_, __) => Text(
                  AppState.instance.getString('register_as_farmer'),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.soil,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.earthBrown.withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(color: AppColors.creamDark, width: 1),
                ),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: AppState.instance,
                      builder: (_, __) => TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: AppState.instance.getString('name'),
                          prefixIcon: const Icon(Icons.person_outline, color: AppColors.earthBrownLight),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: AppState.instance,
                      builder: (_, __) => TextField(
                        controller: _villageController,
                        decoration: InputDecoration(
                          labelText: AppState.instance.getString('village'),
                          prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.earthBrownLight),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: AppState.instance,
                      builder: (_, __) => TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: AppState.instance.getString('mobile_number'),
                          prefixIcon: const Icon(Icons.phone, color: AppColors.earthBrownLight),
                        ),
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.red.shade700, size: 22),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: TextStyle(color: Colors.red.shade700, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.farmGreen,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                AppState.instance.getString('register'),
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: AppState.instance,
                builder: (_, __) => TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: AppState.instance.getString('already_have_account'),
                      style: TextStyle(color: AppColors.soil.withValues(alpha: 0.9)),
                      children: [
                        TextSpan(
                          text: ' ${AppState.instance.getString('login_here')}',
                          style: const TextStyle(
                            color: AppColors.farmGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
