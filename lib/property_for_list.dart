class PropertyForList {
  final int id;
  final String title;
  final int price;
  final String city;
  final int bedrooms;
  final String propertyType;
  final String description;
  final bool isAvailable;
  final String? photos;
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
    this.photos,
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
      'photos': photos,
    };
  }

  factory PropertyForList.fromMap(
      Map<String, dynamic> map) {
    return PropertyForList(
      id: map['id']??0,
      title: map['title']??'',
      price: map['price']??0,
      city: map['city']??'',
      address: map['address'],
      bedrooms: map['bedrooms']??0,
      propertyType: map['propertyType']??'',
      description: map['description']??'',
      isAvailable: map['isAvailable']??false,
      photos: map['photos'],
    );
  }
}