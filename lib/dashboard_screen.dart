import 'package:flutter/material.dart';

import 'routes/app_routes.dart';

import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'services/storage_service.dart';
import 'theme provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();


  static Widget _buildCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding:
            const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 35,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style:
                  const TextStyle(
                fontSize: 26,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class _DashboardScreenState extends State<DashboardScreen> {

String userName = "";
String userEmail = "";

@override
void initState() {
  super.initState();
  _loadUser();
}

Future<void> _loadUser() async {
  final user = await StorageService.getCurrentUserData();

  print(user);

  if (user != null) {
    setState(() {
      userName = user['name'] ?? "";
    });
  }
}

  Widget build(BuildContext context) {
    int totalProperties = 36;
    int totalCustomers = 52;
    int totalLeads = 35;
    int availableProperties = 22;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
    children: [
      UserAccountsDrawerHeader(
  accountName: Text(userName),
  accountEmail: Text(userEmail),
  currentAccountPicture: const CircleAvatar(
    child: Icon(Icons.person),
  ),
),
      ListTile(
        leading: const Icon(Icons.dashboard),
        title: const Text('Dashboard'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Properties'),
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.propertyList,
          );
        },
      ),
      const ListTile(
        leading: Icon(Icons.people),
        title: Text('Customers'),
      ),
      const ListTile(
        leading: Icon(Icons.person_add),
        title: Text('Leads'),
      ),
      const ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
      ),

      Consumer<ThemeProvider>(
  builder: (context, themeProvider, child) {
    return SwitchListTile(
      secondary: const Icon(Icons.dark_mode),
      title: const Text("Dark Mode"),
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        themeProvider.toggleTheme(value);
      },
    );
  },
),


      ListTile(
  leading: const Icon(Icons.logout),
  title: const Text('Logout'),
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

bottomNavigationBar: BottomNavigationBar(
  currentIndex: 0,
  type: BottomNavigationBarType.fixed,
  onTap: (index) {
    if (index == 0) {
    // Already on Dashboard
     } else if (index == 1) {
      Navigator.pushReplacementNamed(
        context,AppRoutes.propertyList,
        );
        } else if (index == 2) {
          Navigator.pushReplacementNamed(
            context,AppRoutes.leads,
            );
            } else if (index == 3) {
              Navigator.pushReplacementNamed(
                context,AppRoutes.profile,
                );
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
      appBar: AppBar(
        
        title: const Text('CRM Dashboard'),
        
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, $userName 👋',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            

            const SizedBox(height: 8),

            const Text(
              'Welcome back to your CRM Dashboard',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                DashboardScreen._buildCard(
                  'Properties',
                  totalProperties.toString(),
                  Icons.home,
                  Colors.blue,
                ),
                DashboardScreen._buildCard(
                  'Customers',
                  totalCustomers.toString(),
                  Icons.people,
                  Colors.orange,
                ),
                DashboardScreen._buildCard(
                  'Leads',
                  totalLeads.toString(),
                  Icons.person_add,
                  Colors.green,
                ),
                DashboardScreen._buildCard(
                  'Available',
                  availableProperties.toString(),
                  Icons.check_circle,
                  Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Recent Leads',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: const Text('Rahul Sharma'),
                subtitle:
                    const Text('New Lead'),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: const Text('Priya Singh'),
                subtitle:
                    const Text('Follow Up'),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: const Text('Aman Kumar'),
                subtitle:
                    const Text(
                        'Site Visit Scheduled'),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon:
                      const Icon(Icons.home),
                  label:
                      const Text('Add Property'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon:
                      const Icon(Icons.people),
                  label:
                      const Text('Add Customer'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                      Icons.person_add),
                  label:
                      const Text('Add Lead'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}