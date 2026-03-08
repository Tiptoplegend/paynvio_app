import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    print('ReportsScreen: Building');
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
            'Reports',
            style: TextStyle(
              color: Color(0xFF1A2B61),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [_datefilter(), _reportcard(), _recentinvoicelist()],
          ),
        ),
      ),
    );
  }
}

Widget _datefilter() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      width: double.infinity, // Full width
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ), // Reduced vertical padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF1A2B61).withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8), // Slightly smaller icon container
            decoration: BoxDecoration(
              color: const Color(0xFF543B36).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.calendar_month,
              color: Color(0xFF543B36),
              size: 20, // Slightly smaller icon
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Date Range',
                style: TextStyle(
                  color: const Color(0xFF1A2B61).withOpacity(0.6),
                  fontSize: 11, // Slightly smaller label
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                '24th January 2025',
                style: TextStyle(
                  color: Color(0xFF1A2B61),
                  fontSize: 14, // Slightly smaller date
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(), // Push dropdown arrow to the right
          Icon(
            Icons.arrow_drop_down,
            color: const Color(0xFF1A2B61).withOpacity(0.6),
            size: 24,
          ),
        ],
      ),
    ),
  );
}

Widget _reportcard() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A2B61), Color(0xFF2A3B71)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A2B61).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Financial Overview',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Main Stats Grid
          Row(
            children: [
              // Total Earning
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Earning',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '\$78,264',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Divider
              Container(
                height: 60,
                width: 1,
                color: Colors.white.withOpacity(0.2),
              ),
              const SizedBox(width: 20),

              // Right side stats
              Expanded(
                child: Column(
                  children: [
                    // Paid this month
                    _buildStatRow('Paid this month', '\$1,525.25'),
                    const SizedBox(height: 16),
                    // Awaiting payment
                    _buildStatRow('Awaiting payment', '\$1,525.25'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildStatRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _recentinvoicelist() {
  final invoices = [
    {
      'id': '#001',
      'client': 'Jerry Oboat',
      'amount': '\$450.00',
      'status': 'Paid',
    },
    {
      'id': '#002',
      'client': 'Sarah Johnson',
      'amount': '\$1,230.00',
      'status': 'Pending',
    },
    {
      'id': '#003',
      'client': 'Mike Chen',
      'amount': '\$890.00',
      'status': 'Overdue',
    },
  ];

  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Invoices',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A2B61),
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: invoices.length,
          itemBuilder: (context, index) {
            final invoice = invoices[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF1A2B61).withOpacity(0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF543B36).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.receipt_long,
                      color: Color(0xFF543B36),
                      size: 20,
                    ),
                  ),
                  title: Text(
                    invoice['id'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2B61),
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    invoice['client'] as String,
                    style: TextStyle(
                      color: const Color(0xFF1A2B61).withOpacity(0.6),
                      fontSize: 13,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        invoice['amount'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF1A2B61),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(
                            invoice['status'] as String,
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          invoice['status'] as String,
                          style: TextStyle(
                            color: _getStatusColor(invoice['status'] as String),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'Paid':
      return const Color(0xFF4CAF50);
    case 'Pending':
      return const Color(0xFFFFA726);
    case 'Overdue':
      return const Color(0xFFEF5350);
    default:
      return const Color(0xFF1A2B61);
  }
}
