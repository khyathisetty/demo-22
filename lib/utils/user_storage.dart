import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FarmerUser {
  final String name;
  final String village;
  final String phone;

  FarmerUser({
    required this.name,
    required this.village,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'village': village,
        'phone': phone,
      };

  factory FarmerUser.fromJson(Map<String, dynamic> json) => FarmerUser(
        name: json['name'] as String,
        village: json['village'] as String,
        phone: json['phone'] as String,
      );
}

class UserStorage {
  static const _keyUsers = 'farmers';
  static const _keyCurrentPhone = 'current_user_phone';
  static const _keyCurrentName = 'current_user_name';

  static Future<List<FarmerUser>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_keyUsers);
    if (list == null) return [];
    return list
        .map((s) => FarmerUser.fromJson(
            Map<String, dynamic>.from(jsonDecode(s) as Map)))
        .toList();
  }

  static Future<void> registerUser(FarmerUser user) async {
    final users = await getUsers();
    final normalized = _normalizePhone(user.phone);
    if (users.any((u) => _normalizePhone(u.phone) == normalized)) {
      throw Exception('Phone number already registered');
    }
    users.add(user);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _keyUsers,
      users.map((u) => jsonEncode(u.toJson())).toList(),
    );
  }

  static Future<FarmerUser?> findByPhone(String phone) async {
    final users = await getUsers();
    final normalized = _normalizePhone(phone);
    try {
      return users.firstWhere((u) => _normalizePhone(u.phone) == normalized);
    } catch (_) {
      return null;
    }
  }

  static String _normalizePhone(String phone) {
    return phone.replaceAll(RegExp(r'[^\d]'), '');
  }

  static Future<void> setCurrentUserPhone(String? phone) async {
    final prefs = await SharedPreferences.getInstance();
    if (phone == null) {
      await prefs.remove(_keyCurrentPhone);
      await prefs.remove(_keyCurrentName);
    } else {
      await prefs.setString(_keyCurrentPhone, phone);
    }
  }

  static Future<void> setCurrentUser(FarmerUser? user) async {
    final prefs = await SharedPreferences.getInstance();
    if (user == null) {
      await prefs.remove(_keyCurrentPhone);
      await prefs.remove(_keyCurrentName);
    } else {
      await prefs.setString(_keyCurrentPhone, user.phone);
      await prefs.setString(_keyCurrentName, user.name);
    }
  }

  static Future<String?> getCurrentUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCurrentPhone);
  }

  static Future<String?> getCurrentUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCurrentName);
  }
}
