class UserSignupData {
  String? email;
  String? name;
  String? password;
  String? studentId;
  String? phoneNumber;
  String? department;

  // UserSignupData({this.email, this.password});

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'password': password,
    'student_id': studentId,
    'phone_number': phoneNumber,
    'department': department
  };
}
