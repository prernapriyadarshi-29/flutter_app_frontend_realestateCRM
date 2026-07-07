import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() =>
      _LeadScreenState();
}

class _LeadScreenState
    extends State<LeadScreen> {
  final List<Map<String, String>> leads = [
    {
      'name': 'Rahul Sharma',
      'phone': '9876543210',
      'status': 'New'
    },
    {
      'name': 'Priya Singh',
      'phone': '9876543211',
      'status': 'Follow Up'
    },
    {
      'name': 'Aman Kumar',
      'phone': '9876543212',
      'status': 'Site Visit'
    },
    {
      'name': 'Riya Gupta',
      'phone': '9876543213',
      'status': 'Closed'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leads'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName:
                  Text('Prerna Priyadarshi'),
              accountEmail:
                  Text('agent@givni.com'),
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
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.dashboard,
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.home),
              title:
                  const Text('Properties'),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.propertyList,
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.people),
              title:
                  const Text('Leads'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.person),
              title:
                  const Text('Profile'),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.profile,
                );
              },
            ),
          ],
        ),
      ),

      body: ListView.builder(
        padding:
            const EdgeInsets.all(12),
        itemCount: leads.length,
        itemBuilder:
            (context, index) {
          final lead = leads[index];

          Color statusColor =
              Colors.blue;

          if (lead['status'] ==
              'Follow Up') {
            statusColor =
                Colors.orange;
          } else if (lead['status'] ==
              'Site Visit') {
            statusColor =
                Colors.green;
          } else if (lead['status'] ==
              'Closed') {
            statusColor =
                Colors.red;
          }

          return Card(
            elevation: 4,
            margin:
                const EdgeInsets.only(
                    bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Colors.indigo,
                child: Text(
                  lead['name']![0],
                  style:
                      const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              title:
                  Text(lead['name']!),
              subtitle: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    lead['phone']!,
                  ),
                  const SizedBox(
                      height: 5),
                  Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration:
                        BoxDecoration(
                      color:
                          statusColor
                              .withOpacity(
                                  0.2),
                      borderRadius:
                          BorderRadius
                              .circular(
                                  20),
                    ),
                    child: Text(
                      lead['status']!,
                      style:
                          TextStyle(
                        color:
                            statusColor,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),
                ],
              ),
              trailing:
                  const Icon(
                Icons
                    .arrow_forward_ios,
                size: 18,
              ),
            ),
          );
        },
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor:
            Colors.indigo,
        onPressed: () {},
        icon:
            const Icon(Icons.add),
        label:
            const Text('Add Lead'),
      ),

      bottomNavigationBar:
          BottomNavigationBar(
        currentIndex: 2,
        type:
            BottomNavigationBarType
                .fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator
                .pushReplacementNamed(
              context,
              AppRoutes.dashboard,
            );
          } else if (index == 1) {
            Navigator
                .pushReplacementNamed(
              context,
              AppRoutes.propertyList,
            );
          } else if (index == 3) {
            Navigator
                .pushReplacementNamed(
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