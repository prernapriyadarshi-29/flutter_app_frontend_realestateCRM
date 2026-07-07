import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // ---------- USERS ----------

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('users');

    if (data == null) return [];

    return List<Map<String, dynamic>>.from(
      jsonDecode(data),
    );
  }

  static Future<void> saveUsers(
      List<Map<String, dynamic>> users) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'users',
      jsonEncode(users),
    );
  }

  // ---------- CURRENT USER ----------

  static Future<void> saveCurrentUser(
      String email) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'currentUser',
      email,
    );
  }

  static Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('currentUser');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('currentUser');
  }

  // ---------- PROPERTIES ----------

  static Future<List<Map<String, dynamic>>> getProperties(
    String email) async {
  final prefs = await SharedPreferences.getInstance();

  final data = prefs.getString('properties_$email');

  if (data == null) return [];

  return List<Map<String, dynamic>>.from(
    jsonDecode(data),
  );
}

static Future<void> saveProperties(
    String email,
    List<Map<String, dynamic>> properties) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(
    'properties_$email',
    jsonEncode(properties),
  );
}

static Future<void> savePropertiesGlobal(
      List<Map<String, dynamic>> properties) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'properties',
      jsonEncode(properties),
    );
  }

  // ---------- LEADS ----------

  static Future<List<Map<String, dynamic>>> getLeads() async {
  final prefs = await SharedPreferences.getInstance();

  final currentUser = prefs.getString('currentUser');

  if (currentUser == null) return [];

  final data = prefs.getString('leads_$currentUser');

  if (data == null) return [];

  return List<Map<String, dynamic>>.from(
    jsonDecode(data),
  );
}

  static Future<void> saveLeads(
    List<Map<String, dynamic>> leads) async {
  final prefs = await SharedPreferences.getInstance();

  final currentUser = prefs.getString('currentUser');

  if (currentUser == null) return;

  await prefs.setString(
    'leads_$currentUser',
    jsonEncode(leads),
  );
}

  // ---------- PROFILE ----------

  static Future<void> saveProfile(
    Map<String, dynamic> profile) async {
  final prefs = await SharedPreferences.getInstance();

  final currentUser = prefs.getString('currentUser');

  if (currentUser == null) return;

  await prefs.setString(
    'profile_$currentUser',
    jsonEncode(profile),
  );
}

  static Future<Map<String, dynamic>?> getProfile() async {
  final prefs = await SharedPreferences.getInstance();

  final currentUser = prefs.getString('currentUser');

  if (currentUser == null) return null;

  final data =
      prefs.getString('profile_$currentUser');

  if (data == null) return null;

  return Map<String, dynamic>.from(
    jsonDecode(data),
  );
}

  static Future<void> saveMap(
  String key,
  Map<String, dynamic> map,
) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(
    key,
    jsonEncode(map),
  );
}

static Future<Map<String, dynamic>> getMap(
  String key,
) async {
  final prefs = await SharedPreferences.getInstance();

  final data = prefs.getString(key);

  if (data == null) {
    return {};
  }

  return Map<String, dynamic>.from(
    jsonDecode(data),
  );
}

  static Future<void> saveList(String s, List<Map<String, dynamic>> list) async {}

  Future<Object?> getList(String s) async {}

  static Future<void> saveCurrentUserData(
    Map<String, dynamic> user) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(
    'currentUserData',
    jsonEncode(user),
  );
}

static Future<Map<String, dynamic>?> getCurrentUserData() async {
  final prefs = await SharedPreferences.getInstance();

  final data = prefs.getString('currentUserData');

  if (data == null) return null;

  return Map<String, dynamic>.from(
    jsonDecode(data),
  );
}


}

