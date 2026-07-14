import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/storage_service.dart';
import 'services/api_service.dart';

class AuthService extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _splashComplete = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get splashComplete => _splashComplete;

  void completeSplash() {
    _splashComplete = true;
    notifyListeners();
  }

  // ---------------- REGISTER ----------------

  Future<bool> register(String name, String email, String password) async {
  try {
    final response = await ApiService.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: password,
      role: 'agent',
    );

    if (response['status'] == true) {
      // Store token from API
      String token = response['token'];
      ApiService.setToken(token);
      
      // Also save to SharedPreferences as backup
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      //clear old user data
      await prefs.remove('currentUser');
      await prefs.remove('currentUserData');
      //save new email
      await prefs.setString('userEmail', email);
      
      notifyListeners();
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Register error: $e');
    return false;
  }
}

  // ---------------- LOGIN ----------------

  Future<bool> login(String email, String password) async {
  try {
    print('🔐 Attempting login with: $email');
    
    final response = await ApiService.login(
      email: email,
      password: password,
    );

    print('📨 API Response: $response');

    if (response['status'] == true) {
      String token = response['token'];
      print('✅ Login successful! Token: $token');
      
      ApiService.setToken(token);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      
      notifyListeners();
      return true;
    } else {
      print('❌ Login failed: ${response['message']}');
      return false;
    }
  } catch (e) {
    print('💥 Login error: $e');
    return false;
  }
}

  // ---------------- AUTO LOGIN ----------------

  Future<void> checkLogin() async {
    final user =
        await StorageService.getCurrentUser();

    _isLoggedIn = user != null;

    notifyListeners();
  }

  // ---------------- LOGOUT ----------------

  Future<void> logout() async {
    try {
      await ApiService.logout();
    } catch(e) {
      print('APIlogout error: $e');
    }
    //clear token from ApiService
      ApiService.clearToken();

      //clear from sharedpreferences
      final prefs =await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      await prefs.remove('userEmail');
      await prefs.remove('currentUser');
      await prefs.remove('currentUserData');

      notifyListeners();
    
  }
// Load token from storage on app start
Future<void> loadTokenFromStorage() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token != null) {
      ApiService.setToken(token);
    }
  } catch (e) {
    print('Load token error: $e');
  }
}
}
