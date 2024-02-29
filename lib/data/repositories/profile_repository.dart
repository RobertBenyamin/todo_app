import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<String> getName() async {
    return sharedPreferences.getString('name') ?? "";
  }

  Future<void> setName(String name) async {
    await sharedPreferences.setString('name', name);
  }

  Future<String> getMajor() async {
    return sharedPreferences.getString('major') ?? "";
  }

  Future<void> setMajor(String major) async {
    await sharedPreferences.setString('major', major);
  }

  Future<String> getDateOfBirth() async {
    return sharedPreferences.getString('dateOfBirth') ?? "";
  }

  Future<void> setDateOfBirth(String dateOfBirth) async {
    await sharedPreferences.setString('dateOfBirth', dateOfBirth);
  }

  Future<String> getEmail() async {
    return sharedPreferences.getString('email') ?? "";
  }

  Future<void> setEmail(String email) async {
    await sharedPreferences.setString('email', email);
  }

  Future<String> getProfilePicture() async {
    return sharedPreferences.getString('profilePicture') ?? "";
  }

  Future<void> setProfilePicture(String profilePicture) async {
    await sharedPreferences.setString('profilePicture', profilePicture);
  }
}
