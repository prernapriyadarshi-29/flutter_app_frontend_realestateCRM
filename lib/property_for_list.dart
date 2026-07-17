class PropertyForList {
  final int id;
  final String title;
  final int price;
  final String city;
  final int bedrooms;
  final String propertyType;
  final String description;
  final bool isAvailable;
   String? photo;
  final String? address;

  PropertyForList({
    required this.id,
    required this.title,
    required this.price,
    required this.city,
    this.address,
    required this.bedrooms,
    required this.propertyType,
    required this.description,
    required this.isAvailable,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'city': city,
      'address': address,
      'bedrooms': bedrooms,
      'propertyType': propertyType,
      'description': description,
      'isAvailable': isAvailable,
      'photos': photo,
    };
  }

  factory PropertyForList.fromMap(Map<String, dynamic> map) {
  return PropertyForList(
    id: map['id'] ?? 0,
    title: map['title'] ?? '',
    price: int.tryParse(map['price']?.toString() ?? '0') ?? 0,  // FIX THIS LINE
    city: map['city'] ?? '',
    address: map['address'],
    bedrooms: map['bedrooms'] ?? 0,
    propertyType: map['type'] ?? '',
    description: map['description'] ?? '',
    isAvailable: (map['status'] ?? 0) == 1,
    photo: map['photo_url'],
  );
}
}