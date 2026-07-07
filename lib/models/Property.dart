class Property {
  static int _nextId = 1;

  final int id;
  final String title;
  final int price;
  final String city;
  final int bedrooms;
  final String status;

  Property({
    int? id,
    required this.title,
    required this.price,
    required this.city,
    required this.bedrooms,
    required this.status,
  }) : id = id ?? _nextId++;

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      city: map['city'],
      bedrooms: map['bedrooms'],
      status: map['status'],
    );
  }

  @override
  String toString() {
    return 'Property(id: $id, title: $title, price: $price, city: $city, bedrooms: $bedrooms, status: $status)';
  }
}