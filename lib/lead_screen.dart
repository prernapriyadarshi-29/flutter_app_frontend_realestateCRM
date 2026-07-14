import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp1/routes/app_routes.dart';
import '../lead_for_list.dart';
import '../services/api_service.dart';
import '../auth_service.dart';
import 'lead_add_form_screen.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  final List<LeadForList> leads = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedStatus = '';

  final List<String> statuses = ['', 'New', 'Contacted', 'Visited', 'Closed'];

  @override
  void initState() {
    super.initState();
    _loadLeads();
  }

  Future<void> _loadLeads({String search = '', String status = ''}) async {
    try {
      setState(() {
        leads.clear();
      });

      final response = await ApiService.getLeads(
        search: search,
        status: status,
      );

      if (response['status'] == true) {
        final dataContainer = response['data'] as Map<String, dynamic>;
        final leadsList = dataContainer['data'] as List<dynamic>? ?? [];

        setState(() {
          leads.clear();
          for (var item in leadsList) {
            final map = item as Map<String, dynamic>;
            final lead = LeadForList.fromMap(map);
            leads.add(lead);
          }
        });
      }
    } catch (e) {
      print('Error loading leads: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load leads')),
      );
    }
  }

  Future<void> _deleteLead(int id, int index) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Lead'),
        content: const Text('Are you sure you want to delete this lead?'),
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
      final response = await ApiService.deleteLead(id);

      if (response['status'] == true) {
        _loadLeads(search: _searchQuery, status: _selectedStatus);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lead deleted successfully!')),
        );
      }
    }
  }

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
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/propertylist',  // Change this to match your actual route
                  );
                  },
                  ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Leads'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await Provider.of<AuthService>(context, listen: false).logout();
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
                hintText: 'Search leads by name...',
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
                          _loadLeads(status: _selectedStatus);
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
                _loadLeads(search: value, status: _selectedStatus);
              },
            ),
          ),
          // STATUS FILTER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: InputDecoration(
                labelText: 'Filter by Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: statuses.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.isEmpty ? 'All Statuses' : status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedStatus = value ?? '');
                _loadLeads(search: _searchQuery, status: value ?? '');
              },
            ),
          ),
          const SizedBox(height: 10),
          // LEADS LIST
          Expanded(
            child: leads.isEmpty
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
                            Icons.people_outline,
                            size: 90,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('No leads found'),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: leads.length,
                    itemBuilder: (context, index) {
                      final lead = leads[index];

                      Color statusColor = Colors.blue;
                      if (lead.status == 'Contacted') {
                        statusColor = Colors.orange;
                      } else if (lead.status == 'Visited') {
                        statusColor = Colors.green;
                      } else if (lead.status == 'Closed') {
                        statusColor = Colors.red;
                      }

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.indigo.shade100,
                                child: Text(
                                  lead.customerName[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lead.customerName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      lead.customerPhone,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        lead.status,
                                        style: TextStyle(
                                          color: statusColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    color: Colors.blue,
                                    onPressed: () {
                                      // TODO: Add Edit Lead Screen
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () => _deleteLead(lead.id, index),
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
        ],
      ),
     floatingActionButton: FloatingActionButton.extended(
  backgroundColor: Colors.indigo,
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddLeadFormScreen()),
    ).then((_) {
      // Reload leads after adding
      _loadLeads(search: _searchQuery, status: _selectedStatus);
    });
  },
        icon: const Icon(Icons.add),
        label: const Text('Add Lead'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            //Navigator.pushNamed(context, '/dashboard');
            Navigator.pushNamed(context, AppRoutes.dashboard);
          } else if (index == 1) {
            Navigator.pushNamed(context, '/propertylist');
          } else if (index == 3) {
           // Navigator.pushNamed(context, '/profile');
           Navigator.pushNamed(context, AppRoutes.profile);
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
}