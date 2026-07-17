class UserAccount {
  int phoneNumber;
  String email;
  String name;
  String city;
  String street;
  String? password;
  UserAccount({
    required this.email,
    required this.name,
    required this.city,
    required this.street,
    required this.phoneNumber,
    this.password
  });
}
