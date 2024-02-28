import 'package:flutter/foundation.dart';
import 'package:todo_app/data/repositories/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository repository;

  ProfileProvider({required this.repository}) {
    fetchProfile();
  }

  String _name = '';
  String get name => _name;

  String _major = '';
  String get major => _major;

  String _dateOfBirth = '';
  String get dateOfBirth => _dateOfBirth;

  String _email = '';
  String get email => _email;

  String _profilePicture = '';
  String get profilePicture => _profilePicture;

  Future<void> fetchProfile() async {
    _name = await repository.getName();
    _major = await repository.getMajor();
    _dateOfBirth = await repository.getDateOfBirth();
    _email = await repository.getEmail();
    _profilePicture = await repository.getProfilePicture();
    notifyListeners();
  }

  Future<void> updateProfile(String name, String major, String dateOfBirth,
      String email, String profilePicture) async {
    await repository.setName(name);
    await repository.setMajor(major);
    await repository.setDateOfBirth(dateOfBirth);
    await repository.setEmail(email);
    await repository.setProfilePicture(profilePicture);
    fetchProfile();
  }
}
