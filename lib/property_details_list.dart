import 'package:flutter/material.dart';
import '/property_for_list.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final PropertyForList? property;

  const PropertyDetailsScreen({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    if (property == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Property Details'),
        ),
        body: const Center(
          child: Text('No Property Data Found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(property!.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${property!.title}'),
            Text('Price: ₹${property!.price}'),
            Text('City: ${property!.city}'),
            Text('Bedrooms: ${property!.bedrooms}'),
            Text('Type: ${property!.propertyType}'),
            Text('Description: ${property!.description}'),
            Text(
              property!.isAvailable
                  ? 'Available'
                  : 'Not Available',
            ),
          ],
        ),
      ),
    );
  }
}