class Users {
  final String username;
  final String email;
  final String phone;
  final bool verified;

  Users(this.username, this.email, this.phone, this.verified);

  static toMap(Users user) {
    return;
  }
}
