class Lead {
  static int _nextId = 1;

  final int id;
  final String customerName;
  final String propertyTitle;
  final String status;

  Lead({
    int? id,
    
    required this.customerName,
    required this.propertyTitle,
    required this.status,
  }) : id = id ?? _nextId++;

  @override
  String toString() {
    return 'Lead(id: $id, customerName: $customerName, propertyTitle: $propertyTitle, status: $status)';
  }
}