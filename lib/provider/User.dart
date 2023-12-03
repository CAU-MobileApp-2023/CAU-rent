import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _email = '';
  String _name = '';
  String _studentId = '';
  String _phoneNumber = '';

  String get userEmail => _email;
  String get userName => _name;
  String get userStudentId => _studentId;
  String get userPhoneNumber => _phoneNumber;

  void setUserEmail(String email) {
    _email = email;
    notifyListeners();
  }
  void setUserName(String name) {
    _name = name;
    notifyListeners();
  }
  void setUserStudentId(String studentId) {
    _studentId = studentId;
    notifyListeners();
  }
  void setUserPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }
}