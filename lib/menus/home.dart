import 'package:flutter/material.dart';
import 'package:paynvio/more/clients.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F1EA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 90),
            _uppersection(),
            const SizedBox(height: 25),
            _uppercards(),
            const SizedBox(height: 20),
            _reportsCard(),
            const SizedBox(height: 20),
            _clientCard(context),
            const SizedBox(height: 20),
            _recentInvoices(),
            const SizedBox(height: 110),
          ],
        ),
      ),
    );
  }
}

Widget _uppersection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back,",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A2B61),
              ),
            ),
            Text(
              "Jeremiah",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A2B61),
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0xFF543B36),
          child: const Icon(Icons.person, color: Colors.white, size: 30),
        ),
      ],
    ),
  );
}

Widget _uppercards() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      children: [
        Row(
          children: [
            StatCard(
              title: 'Inbox',
              value: '18',
              label: 'Invoice',
              icon: Icons.grid_view_rounded,
            ),
            SizedBox(width: 10),
            StatCard(
              title: 'Archived',
              value: '18',
              label: 'Invoice',
              icon: Icons.archive_rounded,
              backgroundColor: Colors.white,
              textColor: const Color(0xFF1A2B61),
              iconBackgroundColor: const Color(
                0xFF543B36,
              ).withValues(alpha: 0.15),
              iconColor: const Color(0xFF543B36),
            ),
          ],
        ),
      ],
    ),
  );
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color? iconBackgroundColor;
  final Color? iconColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.label,
    required this.icon,
    this.backgroundColor = const Color(0xFF1A2B61),
    this.textColor = Colors.white,
    this.iconBackgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: backgroundColor == Colors.white
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      iconBackgroundColor ?? textColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor ?? textColor, size: 20),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.6),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _reportsCard() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: ReportCard(
      title: 'Report',
      value: '\$1980.00',
      label: 'Invoice',
      icon: Icons.pie_chart_rounded,
    ),
  );
}

Widget _clientCard(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ClientsScreen()));
    },
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ClientCard(title: 'Client', subtitle: '51 Clients', avatarCount: 48),
    ),
  );
}

class ClientCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int avatarCount;

  const ClientCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.avatarCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1A2B61),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: const Color(0xFF1A2B61).withValues(alpha: 0.4),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
            width: 120,
            child: Stack(
              children: [
                _avatar(0, 'https://i.pravatar.cc/150?u=1'),
                _avatar(1, 'https://i.pravatar.cc/150?u=2'),
                _avatar(2, 'https://i.pravatar.cc/150?u=3'),
                Positioned(
                  left: 85,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2196F3),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Center(
                      child: Text(
                        '+$avatarCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(int index, String imageUrl) {
    return Positioned(
      left: index * 28.0,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final String value;
  final String label;
  final IconData icon;

  const ReportCard({
    super.key,
    required this.title,
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1A2B61),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF543B36).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.pie_chart_rounded,
                  color: Color(0xFF543B36),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFF1A2B61),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: const Color(0xFF1A2B61).withValues(alpha: 0.6),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const BarChartGraphic(),
            ],
          ),
        ],
      ),
    );
  }
}

class BarChartGraphic extends StatelessWidget {
  const BarChartGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _bar(30),
        const SizedBox(width: 6),
        _bar(45),
        const SizedBox(width: 6),
        _bar(25),
        const SizedBox(width: 6),
        _bar(60),
        const SizedBox(width: 6),
        _bar(35),
        const SizedBox(width: 6),
        _bar(55),
        const SizedBox(width: 6),
        _bar(40),
        const SizedBox(width: 6),
        _bar(65),
      ],
    );
  }

  Widget _bar(double height) {
    return Container(
      width: 7,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2B61).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

Widget _recentInvoices() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Invoices",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A2B61),
          ),
        ),
        const SizedBox(height: 16),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            const InvoiceTile(
              invoiceId: '#001',
              dueDate: 'Due 15 Feb 2026',
              amount: '\$450.00',
            ),
            const SizedBox(height: 12),
            const InvoiceTile(
              invoiceId: '#002',
              dueDate: 'Due 20 Feb 2026',
              amount: '\$1,230.00',
            ),
          ],
        ),
      ],
    ),
  );
}

class InvoiceTile extends StatelessWidget {
  final String invoiceId;
  final String dueDate;
  final String amount;

  const InvoiceTile({
    super.key,
    required this.invoiceId,
    required this.dueDate,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF543B36).withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          invoiceId,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A2B61),
          ),
        ),
        subtitle: Text(
          dueDate,
          style: TextStyle(
            color: const Color(0xFF1A2B61).withValues(alpha: 0.6),
            fontSize: 14,
          ),
        ),
        trailing: Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF1A2B61),
          ),
        ),
      ),
    );
  }
}
