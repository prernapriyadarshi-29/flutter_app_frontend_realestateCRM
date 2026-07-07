class Customer {
  static int _nextId = 1;
  final int id;
  final String name;
  final String phone;
  final String email;
  final String city;

  Customer({
      int? id,
    required this.name,
    required this.phone,
    required this.email,
    required this.city,
  }) : id = id ?? _nextId++;

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, phone: $phone, email: $email, city: $city)';
  }
}