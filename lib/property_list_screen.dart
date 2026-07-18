
   /* import 'package:flutter/material.dart';
import 'package:testapp1/services/api_service.dart';
import 'property_for_list.dart';
import 'property_add_form_screen.dart';
import 'routes/app_routes.dart';
import 'services/storage_service.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'services/api_service.dart';

class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({super.key});

  @override
  State<PropertyListScreen> createState() =>
      _PropertyListScreenState();
}

class _PropertyListScreenState
    extends State<PropertyListScreen> {
  final List<PropertyForList> properties = [];


  @override
void initState() {
  super.initState();
  _loadProperties();
}

Future<void> _loadProperties() async {
  try {
    final response = await ApiService.index();

    if (response['status'] == true) {
      // Extract properties from paginated response
      final dataContainer = response['data'] as Map<String, dynamic>;
      final propertiesList = dataContainer['data'] as List<dynamic>? ?? [];

      setState(() {
        properties.clear();
        for (var item in propertiesList) {
          final map = item as Map<String, dynamic>;
          
          // Convert to PropertyForList with correct field mapping
          final property = PropertyForList(
            id: map['id'] ?? 0,
            title: map['title'] ?? '',
            price: int.tryParse(map['price']?.toString() ?? '0') ?? 0,
            city: map['city'] ?? '',
            address: map['address'],
            bedrooms: map['bedrooms'] ?? 0,
            propertyType: map['type'] ?? '',  // ← Map 'type' to 'propertyType'
            description: map['description'] ?? '',
            isAvailable: (map['status'] ?? 0) == 1,
            photos: map['photos'],
          );
          properties.add(property);
        }
      });
    }
  } catch (e) {
    print('Error loading properties: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to load properties')),
    );
  }
}


Future<void> _saveProperties() async {
  final email =
    await StorageService.getCurrentUser();

await StorageService.saveProperties(
  email!,
  properties
      .map((e) => e.toMap())
      .toList(),
);
}

  Future<void> _addProperty() async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const PropertyAddFormScreen(),
    ),
  );

  if (result != null && result is PropertyForList) {
    // Save to Laravel API
    final response = await ApiService.store(
      title: result.title,
      price: result.price,
      city: result.city,
      address: result.address ?? '',
      bedrooms: result.bedrooms,
      type: result.propertyType,
      photo: result.photos ?? '',
      status: result.isAvailable ? 1 : 0,
    );

    if (response['status'] == true) {
      _loadProperties();  // Reload from API
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Property added successfully!')),
      );
    }
  }
}

  Future<void> _editProperty(int index) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => PropertyAddFormScreen(
        property: properties[index],
      ),
    ),
  );

  if (result != null && result is PropertyForList) {
    // Update to Laravel API
    final response = await ApiService.update(
      properties[index].id,
      title: result.title,
      price: result.price,
      city: result.city,
      address: result.address ?? '',
      bedrooms: result.bedrooms,
      type: result.propertyType,
      photo: result.photos ?? '',
      status: result.isAvailable ? 1 : 0,
    );

    if (response['status'] == true) {
      _loadProperties();  // Reload from API
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Property updated successfully!')),
      );
    }
  }
}

  Future<void> _deleteProperty(
      int index) async {
    final shouldDelete =
        await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title:
                      const Text('Delete Property'),
                  content: const Text(
                    'Are you sure you want to delete this property?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context, false);
                      },
                      child:
                          const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                            context, true);
                      },
                      child:
                          const Text('Delete'),
                    ),
                  ],
                );
              },
            ) ??
            false;

    if (shouldDelete) {
  // Delete from Laravel API
  final response = await ApiService.destroy(properties[index].id);

  if (response['status'] == true) {
    _loadProperties();  // Reload from API
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Property deleted successfully!')),
    );
  }
}
      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: const Text(
          "My Properties",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: properties.isEmpty
          ? Center(
              child: Text('No properties yet'),
            )
          : ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final p = properties[index];
                return ListTile(
                  title: Text(p.title),
                  subtitle: Text(p.city),
                  onTap: () {},
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProperty,
        child: const Icon(Icons.add),
      ),
    );
  }
}
       @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: const Text(
          "My Properties",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: properties.isEmpty
          ? Center(
              child: Text('No properties yet'),
            )
          : ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final p = properties[index];
                return ListTile(
                  title: Text(p.title),
                  subtitle: Text(p.city),
                  onTap: () {},
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProperty,
        child: const Icon(Icons.add),
      ),
    );
  }
    
      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: const Text(
          "My Properties",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: properties.isEmpty
          ? Center(
              child: Text('No properties yet'),
            )
          : ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                final p = properties[index];
                return ListTile(
                  title: Text(p.title),
                  subtitle: Text(p.city),
                  onTap: () {},
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProperty,
        child: const Icon(Icons.add),
      ),
    );
  }
    }*/
    import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../property_for_list.dart';
import '../property_add_form_screen.dart';
import '../services/api_service.dart';
import '../auth_service.dart';
import '../UploadPropertyPhotoScreen.dart';

class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({super.key});

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  final List<PropertyForList> properties = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';


  @override
void initState() {
  super.initState();
  _loadProperties();
}

Future<void> _loadPropertiesFromAPI() async {
  print("========== _loadPropertiesFromAPI CALLED ==========");//.....check
  try {
    final data = await ApiService.getProperties();
    print("Received ${data.length} properties");//.....check
    print("First property title: ${data.isNotEmpty ? data[0].title : 'EMPTY'}");//....check
    setState(() {
  properties.clear();
  properties.addAll(data);
});
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

  void _filterPropertiesLocally(String query) {
  // Call API but also filter locally for instant display
  _loadProperties(search: query).then((_) {
    // After API returns, properties are already filtered by backend
    // But we can do additional local filtering if needed
    setState(() {
      if (query.isEmpty) {
        // Show all
      } else {
        // Backend already filtered, but we can add extra filter here
        // This ensures multiple words match
      }
    });
  });
}

  Future<void> _loadProperties({String search = ''}) async {
  try {
    final response = await ApiService.index(search: search);

      if (response['status'] == true) {
        final dataContainer = response['data'] as Map<String, dynamic>;
        final propertiesList = dataContainer['data'] as List<dynamic>? ?? [];

        print("First property price: ${propertiesList.isNotEmpty ? propertiesList[0]['price'] : 'EMPTY'}");

        setState(() {
          properties.clear();
          for (var item in propertiesList) {
            final map = item as Map<String, dynamic>;
            final property = PropertyForList(
              id: map['id'] ?? 0,
              title: map['title'] ?? '',
              price: (double.tryParse(map['price'].toString()) ?? 0).toInt(),
              city: map['city'] ?? '',
              address: map['address'],
              bedrooms: map['bedrooms'] ?? 0,
              propertyType: map['type'] ?? '',
              description: map['description'] ?? '',
              isAvailable: (map['status'] ?? 0) == 1,
              photo: map['photo']==null
              ?null
              :_cleanPhotoUrl(map['photo']),
            );

            print(property.photo);// picture FINALLY VISIBLE YAYAYAYAYAY
            properties.add(property);
          }
        });
      }
    } catch (e) {
      print('Error loading properties: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load properties')),
      );
    }
  }

  Future<void> _addProperty() async {
    final result = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const PropertyAddFormScreen(),
  ),
  );

    if (result != null && result is PropertyForList) {
      final response = await ApiService.store(
        title: result.title,
        price: result.price,
        city: result.city,
        address: result.address ?? '',
        bedrooms: result.bedrooms,
        type: result.propertyType,
        photo: result.photo ,
        status: result.isAvailable ? 1 : 0,
      );

      if (response['status'] == true) {
        await _loadProperties(search: _searchQuery);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Property added successfully!')),
        );
      }
    }
  }

  Future<void> _editProperty(int index) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => PropertyAddFormScreen(
        property: properties[index],
      ),
    ),
  );

  if (result == true) {
    await _loadProperties(search: _searchQuery);
    ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(content: Text('Property updated successfully!')),
    );
  }
}

  Future<void> _deleteProperty(int index) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Property'),
        content: const Text('Are you sure you want to delete this property?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    ) ?? false;

    if (shouldDelete) {
      final response = await ApiService.destroy(properties[index].id);

      if (response['status'] == true) {
        await _loadProperties(search: _searchQuery);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Property deleted successfully!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: const Text(
          "My Properties",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Agent Name'),
              accountEmail: Text('agent@email.com'),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Properties'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Customers'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Leads'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await Provider.of<AuthService>(context, listen: false)
                    .logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search properties...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                          _loadProperties();
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
                if (value.isEmpty) {
                   _loadProperties();  // Load all if empty
                   } else {
    // Instant filter locally
       _filterPropertiesLocally(value);
       }
       },
            ),
          ),
          // PROPERTIES LIST
          Expanded(
             child: RefreshIndicator(  // ← ADD THIS LINE
    onRefresh: () => _loadProperties(search: _searchQuery),  // ← ADD THIS LINE
            child: properties.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.home_work_outlined,
                            size: 90,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('No properties found'),
                      ],
                    ),
                  )
                : ListView.builder(
                  key: ValueKey(properties.length),  
                    padding: const EdgeInsets.all(10),
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      final p = properties[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.grey.shade200,
                                    backgroundImage: p.photo != null && p.photo!.isNotEmpty
                                    ? NetworkImage(_cleanPhotoUrl(p.photo!))
                                    : null,
                                    child: (p.photo == null || p.photo!.isEmpty)
                                    ? const Icon(
                                      Icons.home,
                                      color: Colors.indigo,
                                      size: 30,
                                      )
                                      : null,
                                      ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          p.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          p.city,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                           '₹${p.price.toStringAsFixed(0)}',  // ← ADD toStringAsFixed(0)
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        color: Colors.blue,
                                        onPressed: () => _editProperty(index),
                                      ),
                                      IconButton(
  icon: const Icon(Icons.photo_camera),
  color: Colors.green,
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UploadPropertyPhotoScreen(propertyId: p.id),
      ),
    ).then((refresh) {
      if (refresh == true) {
        _loadPropertiesFromAPI();
        };
      
    });
  },
),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: Colors.red,
                                        onPressed: () => _deleteProperty(index),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigo,
        onPressed: _addProperty,
        icon: const Icon(Icons.add),
        label: const Text("Add Property"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/dashboard');
          } else if (index == 1) {
            _loadPropertiesFromAPI();
            // Already on Properties
          } else if (index == 2) {
            Navigator.pushNamed(context, '/leads');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Properties',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Leads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
 String _cleanPhotoUrl(String photo) {
  // If already starts with http, return as is
  if (photo.startsWith('http')) {
    return photo;
  }
  
  // If starts with 'properties/', just add the base storage URL
  if (photo.startsWith('properties/')) {
    return 'http://192.168.1.20:8000/storage/$photo';
  }
  
  // Otherwise add both storage and properties
  return 'http://192.168.1.20:8000/storage/properties/$photo';
}
}