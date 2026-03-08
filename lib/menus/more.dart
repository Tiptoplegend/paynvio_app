import 'package:flutter/material.dart';
import 'package:paynvio/more/business.dart';
import 'package:paynvio/more/clients.dart';
import 'package:paynvio/more/templates.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F1EA),
      body: Scaffold(
        backgroundColor: Color(0xFFF4F1EA),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFF4F1EA),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'More',
            style: TextStyle(
              color: Color(0xFF1A2B61),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: _moreitems(),
      ),
    );
  }
}

Widget _moreitems() {
  // Step 1: Create a list of menu items with their data AND actions
  final menuItems = [
    {
      'icon': Icons.person,
      'title': 'Business Info',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BusinessinfoScreen()),
        );
      },
    },
    {
      'icon': Icons.people,
      'title': 'Clients',
      'onTap': (BuildContext context) {
        // Navigate to Settings page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClientsScreen()),
        );
      },
    },
    {
      'icon': Icons.description,
      'title': 'Templates',
      'onTap': (BuildContext context) {
        // Navigate to Settings page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TemplatesScreen()),
        );
      },
    },
    {
      'icon': Icons.logout,
      'title': 'Logout',
      'onTap': (BuildContext context) {
        // Show logout confirmation dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Add logout logic here
                  Navigator.pop(context);
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        );
      },
    },
  ];

  // Step 2: Use .map() to convert each item into a ListTile
  return ListView(
    padding: const EdgeInsets.all(20),
    children: menuItems.map((item) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Builder(
            builder: (context) => ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF1A2B61),
                child: Icon(item['icon'] as IconData, color: Colors.white),
              ),
              title: Text(
                item['title'] as String,
                style: const TextStyle(
                  color: Color(0xFF1A2B61),
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF1A2B61),
                size: 18,
              ),
              // Step 3: Call the onTap function when tapped
              onTap: () {
                final onTapFunction = item['onTap'] as Function(BuildContext);
                onTapFunction(context);
              },
            ),
          ),
        ),
      );
    }).toList(),
  );
}
