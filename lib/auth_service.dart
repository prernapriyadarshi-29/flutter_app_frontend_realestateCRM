import 'package:flutter/material.dart';
import 'services/storage_service.dart';

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

  Future<bool> register(
    String email,
    String password,
    String name,
  ) async {
    final users = await StorageService.getUsers();

    // Check if email already exists
    for (var user in users) {
      if (user['email'] == email) {
        return false;
      }
    }

    users.add({
  'name': name,
  'email': email,
  'password': password,
});

    await StorageService.saveUsers(users);

    return true;
  }

  // ---------------- LOGIN ----------------

  Future<bool> login(
    String email,
    String password,
  ) async {
    final users = await StorageService.getUsers();

    for (var user in users) {
      if (user['email'] == email &&
          user['password'] == password) {
        _isLoggedIn = true;

        await StorageService.saveCurrentUser(email);
        await StorageService.saveCurrentUserData(user);

        notifyListeners();

        return true;
      }
    }

    return false;
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
    _isLoggedIn = false;

    await StorageService.logout();

    notifyListeners();
  }
}