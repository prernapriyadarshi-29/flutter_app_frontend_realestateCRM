import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddLeadFormScreen extends StatefulWidget {
  const AddLeadFormScreen({super.key});

  @override
  State<AddLeadFormScreen> createState() => _AddLeadFormScreenState();
}

class _AddLeadFormScreenState extends State<AddLeadFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _customerIdController = TextEditingController();
  final TextEditingController _propertyIdController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _followUpDateController = TextEditingController();

  String _selectedStatus = 'New';
  final List<String> statuses = ['New', 'Contacted', 'Visited', 'Closed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Lead'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer ID
              TextFormField(
                controller: _customerIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Customer ID',
                  border: OutlineInputBorder(),
                  hintText: 'Enter customer ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter customer ID';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Property ID
              TextFormField(
                controller: _propertyIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Property ID',
                  border: OutlineInputBorder(),
                  hintText: 'Enter property ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter property ID';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Status Dropdown
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: statuses.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedStatus = value ?? 'New');
                },
              ),
              const SizedBox(height: 16),

              // Note
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Note (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Follow-up Date
              TextFormField(
                controller: _followUpDateController,
                decoration: const InputDecoration(
                  labelText: 'Follow-up Date (Optional)',
                  border: OutlineInputBorder(),
                  hintText: 'YYYY-MM-DD',
                ),
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Add Lead',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final customerId = int.parse(_customerIdController.text);
      final propertyId = int.parse(_propertyIdController.text);

      final response = await ApiService.createLead(
        customerId: customerId,
        propertyId: propertyId,
        status: _selectedStatus,
        note: _noteController.text.isEmpty ? null : _noteController.text,
        followUpDate: _followUpDateController.text.isEmpty ? null : _followUpDateController.text,
      );

      if (response['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lead added successfully!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Failed to add lead')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}