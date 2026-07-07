class User {
  static int _nextId = 1;

  final int id;
  final String name;
  final String email;
  final String role;

  User({
    int? id,

    required this.name,
    required this.email,
    required this.role,
  }): id = id ?? _nextId++;

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, role: $role)';
  }
}