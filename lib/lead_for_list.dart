class LeadForList {
  final int id;
  final int customerId;
  final int propertyId;
  final String status;
  final String? note;
  final String? followUpDate;
  final String customerName;
  final String customerPhone;

  LeadForList({
    required this.id,
    required this.customerId,
    required this.propertyId,
    required this.status,
    this.note,
    this.followUpDate,
    required this.customerName,
    required this.customerPhone,
  });

  factory LeadForList.fromMap(Map<String, dynamic> map) {
    return LeadForList(
      id: map['id'] ?? 0,
      customerId: map['customer_id'] ?? 0,
      propertyId: map['property_id'] ?? 0,
      status: map['status'] ?? 'New',
      note: map['note'],
      followUpDate: map['follow_up_date'],
      customerName: map['customer_name'] ?? '',
      customerPhone: map['customer_phone'] ?? '',
    );
  }
}