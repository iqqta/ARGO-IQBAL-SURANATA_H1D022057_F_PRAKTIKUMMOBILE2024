import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  // Set the user token
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
  }

  // Get the user token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }

  // Set the user ID
  Future<void> setUserID(int userID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userID);
  }

  // Get the user ID
  Future<int?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  // Logout method
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token');
    await prefs.remove('user_id');
  }

  // Clear user data (could be a general method for any additional cleanup)
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token');
    await prefs.remove('user_id');
  }
}