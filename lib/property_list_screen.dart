/*import 'package:flutter/material.dart';
import 'property_for_list.dart';
import 'property_add_form_screen.dart';

class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({super.key});

  @override
  State<PropertyListScreen> createState() =>
      _PropertyListScreenState();
}

class _PropertyListScreenState
    extends State<PropertyListScreen> {
  final List<PropertyForList> properties = [];

  Future<void> _addProperty() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const PropertyAddFormScreen(),
      ),
    );

    if (result != null &&
        result is PropertyForList) {
      setState(() {
        properties.add(result);
      });
    }
  }

  Future<void> _editProperty(
      int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            PropertyAddFormScreen(
          property: properties[index],
        ),
      ),
    );

    if (result != null &&
        result is PropertyForList) {
      setState(() {
        properties[index] = result;
      });
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
      setState(() {
        properties.removeAt(index);
      });
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

            const SizedBox(height: 30),

            const Text(
              "No Properties Added",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Tap the + button to add your first property.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      )
    : ListView.builder(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 90,
        ),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final p = properties[index];

          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor:
                            Colors.indigo.shade100,
                        child: const Icon(
                          Icons.home,
                          color: Colors.indigo,
                          size: 30,
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.title,
                              style:
                                  const TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                                height: 5),

                            Text(
                              p.city,
                              style:
                                  const TextStyle(
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(
                                height: 5),

                            Text(
                              "₹${p.price}",
                              style:
                                  const TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration:
                            BoxDecoration(
                          color: p.isAvailable
                              ? Colors
                                  .green.shade100
                              : Colors.red.shade100,
                          borderRadius:
                              BorderRadius.circular(
                                  20),
                        ),
                        child: Text(
                          p.isAvailable
                              ? "Available"
                              : "Sold",
                          style: TextStyle(
                            color: p.isAvailable
                                ? Colors.green
                                : Colors.red,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          _editProperty(index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _deleteProperty(index);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

floatingActionButton:
    FloatingActionButton.extended(
  backgroundColor: Colors.indigo,
  onPressed: _addProperty,
  icon: const Icon(Icons.add),
  label: const Text("Add Property"),
),
    );
  }
    }*/
    import 'package:flutter/material.dart';
import 'property_for_list.dart';
import 'property_add_form_screen.dart';
import 'routes/app_routes.dart';
import 'services/storage_service.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

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

final email = await StorageService.getCurrentUser();

final data = await StorageService.getProperties(
  email!,
);
  setState(() {
    properties.clear();

    properties.addAll(
      data.map((e) => PropertyForList.fromMap(e)).toList(),
    );
  });
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
        builder: (_) =>
            const PropertyAddFormScreen(),
      ),
    );

    if (result != null &&
        result is PropertyForList) {
      setState(() {
  properties.add(result);
});

await _saveProperties();
    }
  }

  Future<void> _editProperty(
      int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            PropertyAddFormScreen(
          property: properties[index],
        ),
      ),
    );

    if (result != null &&
        result is PropertyForList) {
      setState(() {
  properties[index] = result;
});

await _saveProperties();
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
      setState(() {
  properties.removeAt(index);
});

await _saveProperties();
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
              accountName:
                  Text('Rahul Sharma'),
              accountEmail:
                  Text('rahul@gmail.com'),
              currentAccountPicture:
                  CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading:
                  const Icon(Icons.dashboard),
              title:
                  const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.home),
              title:
                  const Text('Properties'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const ListTile(
              leading:
                  Icon(Icons.people),
              title: Text('Customers'),
            ),
            const ListTile(
              leading:
                  Icon(Icons.person_add),
              title: Text('Leads'),
            ),
            const ListTile(
              leading:
                  Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading:
                  const Icon(Icons.logout),
              title:
                  const Text('Logout'),
              onTap: () async {
  await Provider.of<AuthService>(
    context,
    listen: false,
  ).logout();

  Navigator.pushNamedAndRemoveUntil(
    context,
    AppRoutes.login,
    (route) => false,
  );
},
            ),
          ],
        ),
      ),

      body: properties.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(
                            25),
                    decoration:
                        BoxDecoration(
                      color: Colors
                          .indigo.shade50,
                      shape:
                          BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons
                          .home_work_outlined,
                      size: 90,
                      color:
                          Colors.indigo,
                    ),
                  ),
                  const SizedBox(
                      height: 30),
                  const Text(
                    "No Properties Added",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                      height: 10),
                  const Text(
                    "Tap the + button to add your first property.",
                    textAlign:
                        TextAlign.center,
                    style: TextStyle(
                      color:
                          Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding:
                  const EdgeInsets.only(
                top: 10,
                bottom: 90,
              ),
              itemCount:
                  properties.length,
              itemBuilder:
                  (context, index) {
                final p =
                    properties[index];

                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes
                          .propertyDetails,
                      arguments: p,
                    );
                  },
                  child: Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                                  20),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets
                              .all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor:
                                    Colors
                                        .indigo
                                        .shade100,
                                child:
                                    const Icon(
                                  Icons.home,
                                  color: Colors
                                      .indigo,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                  width: 15),
                              Expanded(
                                child:
                                    Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      p.title,
                                      style:
                                          const TextStyle(
                                        fontSize:
                                            18,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            5),
                                    Text(
                                      p.city,
                                      style:
                                          const TextStyle(
                                        color:
                                            Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            5),
                                    Text(
                                      "₹${p.price}",
                                      style:
                                          const TextStyle(
                                        fontSize:
                                            16,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal:
                                      12,
                                  vertical:
                                      6,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color: p
                                          .isAvailable
                                      ? Colors
                                          .green
                                          .shade100
                                      : Colors
                                          .red
                                          .shade100,
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              20),
                                ),
                                child: Text(
                                  p.isAvailable
                                      ? "Available"
                                      : "Sold",
                                  style:
                                      TextStyle(
                                    color: p
                                            .isAvailable
                                        ? Colors
                                            .green
                                        : Colors
                                            .red,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 15),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .end,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(
                                  Icons.edit,
                                  color:
                                      Colors
                                          .blue,
                                ),
                                onPressed:
                                    () {
                                  _editProperty(
                                      index);
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(
                                  Icons
                                      .delete,
                                  color:
                                      Colors
                                          .red,
                                ),
                                onPressed:
                                    () {
                                  _deleteProperty(
                                      index);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor: Colors.indigo,
        onPressed: _addProperty,
        icon: const Icon(Icons.add),
        label:
            const Text("Add Property"),
      ),

      bottomNavigationBar:
          BottomNavigationBar(
        currentIndex: 1,
        type:
            BottomNavigationBarType.fixed,
        onTap: (index) {
           if (index == 0) {
            Navigator.pushNamed(context, AppRoutes.dashboard,
            );
            } else if (index == 1) {
    // Already on Properties page
       } else if (index == 2) {
        Navigator.pushReplacementNamed(
          context,AppRoutes.leads,
          );
          } else if (index == 3) {
            Navigator.pushNamed(
              context,
              AppRoutes.profile,
              );
              }
              },
        items: const [
          BottomNavigationBarItem(
            icon:
                Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Properties',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.people),
            label: 'Leads',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

