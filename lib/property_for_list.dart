class PropertyForList {
  final String title;
  final int price;
  final String city;
  final int bedrooms;
  final String propertyType;
  final String description;
  final bool isAvailable;

  PropertyForList({
    required this.title,
    required this.price,
    required this.city,
    required this.bedrooms,
    required this.propertyType,
    required this.description,
    required this.isAvailable,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'city': city,
      'bedrooms': bedrooms,
      'propertyType': propertyType,
      'description': description,
      'isAvailable': isAvailable,
    };
  }

  factory PropertyForList.fromMap(
      Map<String, dynamic> map) {
    return PropertyForList(
      title: map['title'],
      price: map['price'],
      city: map['city'],
      bedrooms: map['bedrooms'],
      propertyType: map['propertyType'],
      description: map['description'],
      isAvailable: map['isAvailable'],
    );
  }
}