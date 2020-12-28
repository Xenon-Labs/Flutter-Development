class User {
  User({
    this.id,
    this.name,
    this.email,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
        id: data['id'], name: data['name'], email: data['email']);
  }

  final String id;
  final String name;
  final String email;
}
