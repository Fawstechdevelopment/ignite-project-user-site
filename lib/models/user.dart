class User {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  User({this.id, this.email, this.firstName, this.lastName});
  factory User.fromJson(Map<String, dynamic> j) => User(
    id: j['id'],
    email: j['email'],
    firstName: j['first_name'],
    lastName: j['last_name'],
  );
}
