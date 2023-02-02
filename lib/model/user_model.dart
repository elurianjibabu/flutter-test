class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.password,
    this.email,
    this.phoneNumber,
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? password;
  final String? email;
  final int? phoneNumber;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        password: json["password"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "password": password,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}
