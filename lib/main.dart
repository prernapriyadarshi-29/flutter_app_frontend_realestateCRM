import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';
import 'splash_screen.dart';
import 'welcome_screen.dart';
import 'dashboard_screen.dart';
import 'routes/route_generator.dart';
import 'theme provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
void initState() {
  super.initState();

  Future.microtask(() async {
    //load token from storage
    await Provider.of<AuthService>(context,
    listen:false,
    ).loadTokenFromStorage();

    //then check login status
    Provider.of<AuthService>(
      context,
      listen: false,
    ).checkLogin();
  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real Estate CRM',
      theme: ThemeData.light(),

darkTheme: ThemeData.dark(),

themeMode: Provider.of<ThemeProvider>(
  context,
).themeMode,
      home: Consumer<AuthService>(
        builder: (context, authService, _) {
          // Show Splash first
          if (!authService.splashComplete) {
            return const SplashScreen();
          }

          // After login show Dashboard
          if (authService.isLoggedIn) {
            return const DashboardScreen();
          }

          // Otherwise show Welcome Screen
          return const WelcomeScreen();
        },
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

//import 'agent_profile_screen.dart';  <-- uncomment the line later, if of any use.
/*import 'package:flutter/material.dart';
import 'models/Property.dart';
import 'models/customer.dart';
import 'models/lead.dart';
import 'models/user.dart';
import 'utils.dart';

import 'property_add_form_screen.dart';
import 'property_list_screen.dart';

void testModels() {
  final property = Property(
    title: 'Luxury Apartment',
    price: 4500000,
    city: 'Delhi',
    bedrooms: 3,
    status: 'Available',
  );

  final customer = Customer(
    name: 'Rahul Sharma',
    phone: '9876543210',
    email: 'rahul@gmail.com',
    city: 'Mumbai',
  );

  final lead = Lead(
    customerName: 'Rahul Sharma',
    propertyTitle: 'Luxury Apartment',
    status: 'New',
  );

  final user = User(
    name: 'Priya Singh',
    email: 'priya@company.com',
    role: 'Agent',
  );

  print(property);
  print(customer);
  print(lead);
  print(user);
  print(formatPrice(property.price));
}

void main() {
  testModels();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Property> properties = [];

  void addProperty(Property property) {
    setState(() {
      properties.add(property);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PropertyListScreen(
        properties: properties,
        onAddPressed: () async {
          final newProperty = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PropertyAddFormScreen(),
            ),
          );

          if (newProperty != null && newProperty is Property) {
            addProperty(newProperty);
          }
        },
      ),
    );
  }
}*/
/*import 'package:flutter/material.dart';<----------04/07
import 'property_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PropertyListScreen(),
    );
  }
}*/ //<---------------04/07
