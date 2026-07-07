import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'property_for_list.dart';

class PropertyAddFormScreen extends StatefulWidget {
  final PropertyForList? property;

  const PropertyAddFormScreen({
    super.key,
    this.property,
  });

  @override
  State<PropertyAddFormScreen> createState() =>
      _PropertyAddFormScreenState();
}

class _PropertyAddFormScreenState
    extends State<PropertyAddFormScreen> {
  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _cityController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Focus Nodes
  final _titleFocus = FocusNode();
  final _priceFocus = FocusNode();
  final _cityFocus = FocusNode();
  final _bedroomsFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  // Dropdown value
  String _selectedPropertyType = 'Flat';

  // Switch value
  bool _isAvailable = true;
  @override
void initState() {
  super.initState();

  if (widget.property != null) {
    _titleController.text =
        widget.property!.title;

    _priceController.text = NumberFormat(
      '#,##,##0',
      'en_IN',
    ).format(widget.property!.price);

    _cityController.text =
        widget.property!.city;

    _bedroomsController.text =
        widget.property!.bedrooms.toString();

    _descriptionController.text =
        widget.property!.description;

    _selectedPropertyType =
        widget.property!.propertyType;

    _isAvailable =
        widget.property!.isAvailable;
  }
}

  // Format price with Indian commas
  void _formatPrice(String value) {
    if (value.isEmpty) return;

    final number = value.replaceAll(',', '');

    if (number.isEmpty) return;

    try {
      final formatted = NumberFormat(
        '#,##,##0',
        'en_IN',
      ).format(int.parse(number));

      _priceController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(
          offset: formatted.length,
        ),
      );
    } catch (e) {
      // Ignore invalid input
    }
  }

void _saveProperty() {
  FocusScope.of(context).unfocus();

  if (_formKey.currentState!.validate()) {
    final property = PropertyForList(
      title: _titleController.text.trim(),
      price: int.parse(_priceController.text.replaceAll(',', '').trim()),
      city: _cityController.text.trim(),
      bedrooms: int.parse(_bedroomsController.text.trim()),
      propertyType: _selectedPropertyType,
      description: _descriptionController.text.trim(),
      isAvailable: _isAvailable,
    );

    Navigator.of(context).pop(property);
  }
}
  @override
  void dispose() {
    // Dispose controllers
    _titleController.dispose();
    _priceController.dispose();
    _cityController.dispose();
    _bedroomsController.dispose();
    _descriptionController.dispose();

    // Dispose focus nodes
    _titleFocus.dispose();
    _priceFocus.dispose();
    _cityFocus.dispose();
    _bedroomsFocus.dispose();
    _descriptionFocus.dispose();

    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.property == null
           ? 'Add Property'
           : 'Edit Property',),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title
              TextFormField(
                controller: _titleController,
                focusNode: _titleFocus,
                textInputAction:
                    TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                      .requestFocus(_priceFocus);
                },
                decoration:
                    const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                   return 'Please enter title';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Price
              TextFormField(
                controller: _priceController,
                focusNode: _priceFocus,
                textInputAction:
                    TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                      .requestFocus(_cityFocus);
                },
                keyboardType:
                    TextInputType.number,
                onChanged: _formatPrice,
                decoration:
                    const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter price';
                  }

                  final price =
                      value.replaceAll(
                        ',',
                        '',
                      );

                  if (double.tryParse(
                        price,
                      ) ==
                      null) {
                    return 'Please enter a valid price';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // City
              TextFormField(
                controller: _cityController,
                focusNode: _cityFocus,
                textInputAction:
                    TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                      .requestFocus(
                        _bedroomsFocus,
                      );
                },
                decoration:
                    const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter city';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Bedrooms
              TextFormField(
                controller:
                    _bedroomsController,
                focusNode:
                    _bedroomsFocus,
                textInputAction:
                    TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                      .requestFocus(
                        _descriptionFocus,
                      );
                },
                keyboardType:
                    TextInputType.number,
                decoration:
                    const InputDecoration(
                  labelText: 'Bedrooms',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter bedrooms';
                  }

                  if (int.tryParse(
                        value,
                      ) ==
                      null) {
                    return 'Please enter valid number of bedrooms';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Property Type
              DropdownButtonFormField<
                  String>(
                value:
                    _selectedPropertyType,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Property Type',
                  border:
                      OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Flat',
                    child: Text('Flat'),
                  ),
                  DropdownMenuItem(
                    value: 'House',
                    child: Text('House'),
                  ),
                  DropdownMenuItem(
                    value: 'Plot',
                    child: Text('Plot'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedPropertyType =
                        value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller:
                    _descriptionController,
                focusNode:
                    _descriptionFocus,
                textInputAction:
                    TextInputAction.done,
                onFieldSubmitted: (_) {
                  _saveProperty();
                },
                maxLines: 4,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Description',
                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              // Status Switch
              SwitchListTile(
                title: Text(
                  _isAvailable
                      ? 'Available'
                      : 'Sold',
                ),
                value: _isAvailable,
                onChanged: (value) {
                  setState(() {
                    _isAvailable = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      _saveProperty,
                  child: Text( widget.property == null   ? 'Save': 'Update',),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}