import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:paynvio/menus/home.dart';
import 'package:paynvio/menus/invoice.dart';
import 'package:paynvio/menus/more.dart';
import 'package:paynvio/menus/reports.dart';
import 'package:paynvio/menus/widgets/addinvoice.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const invoicescreen(),
    const AddinvoiceScreen(),
    const ReportsScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: GNav(
            gap: 5,
            // backgroundColor: Colors.white,
            color: const Color(0xFF1A2B61).withOpacity(0.8),
            activeColor: Colors.white,
            tabBackgroundColor: const Color(0xFF1A2B61),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            onTabChange: (index) {
              if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddinvoiceScreen(),
                  ),
                );
              } else {
                setState(() {
                  currentIndex = index;
                  // print('NavigationScreen: currentIndex set to $currentIndex');
                });
              }
            },
            selectedIndex: currentIndex,
            tabs: const [
              GButton(icon: Icons.home_rounded, text: 'Home'),
              GButton(icon: Icons.receipt_long_rounded, text: 'Invoice'),
              GButton(icon: Icons.add_circle_outline, text: 'Add'),
              GButton(icon: Icons.analytics_sharp, text: 'Reports'),
              GButton(icon: Icons.menu_rounded, text: 'More'),
            ],
          ),
        ),
      ),
    );
  }
}
