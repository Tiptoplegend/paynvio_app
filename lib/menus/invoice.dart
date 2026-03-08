import 'package:flutter/material.dart';

// --- Invoice card color thresholds (tune these later) ---
// When days left <= this and still unpaid, card uses warning (orange) theme.
// When overdue (days left < 0), card uses red theme. Paid always green, unpaid normal = blue.
const int kInvoiceWarningDaysThreshold = 7;
const int kInvoiceOverdueDaysThreshold = 0; // any past due → red

/// Theme colors for the invoice card based on status and due date.
class InvoiceCardTheme {
  const InvoiceCardTheme({
    required this.primary,
    required this.primaryLight,
    required this.isUrgent,
    required this.isOverdue,
  });

  final Color primary;
  final Color primaryLight;
  final bool isUrgent;
  final bool isOverdue;

  static const Color kBlue = Color(0xFF1A2B61);
  static const Color kGreen = Color(0xFF2E7D32);
  static const Color kOrange = Color(0xFFE65100);
  static const Color kRed = Color(0xFFC62828);

  /// Computes card theme from status and due date. Uses [kInvoiceWarningDaysThreshold]
  /// and [kInvoiceOverdueDaysThreshold] for urgency/overdue.
  static InvoiceCardTheme fromStatusAndDue(String status, DateTime? dueDate) {
    if (status == 'Paid') {
      return InvoiceCardTheme(
        primary: kGreen,
        primaryLight: kGreen.withOpacity(0.15),
        isUrgent: false,
        isOverdue: false,
      );
    }
    if (status == 'Draft') {
      return InvoiceCardTheme(
        primary: kBlue,
        primaryLight: kBlue.withOpacity(0.08),
        isUrgent: false,
        isOverdue: false,
      );
    }
    if (dueDate == null) {
      return InvoiceCardTheme(
        primary: kBlue,
        primaryLight: kBlue.withOpacity(0.08),
        isUrgent: false,
        isOverdue: false,
      );
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    final daysLeft = due.difference(today).inDays;

    if (daysLeft < kInvoiceOverdueDaysThreshold) {
      // Overdue → red
      return InvoiceCardTheme(
        primary: kRed,
        primaryLight: kRed.withOpacity(0.15),
        isUrgent: true,
        isOverdue: true,
      );
    }
    if (daysLeft <= kInvoiceWarningDaysThreshold) {
      // Urgent/warning (e.g. 1–7 days left) → orange
      return InvoiceCardTheme(
        primary: kOrange,
        primaryLight: kOrange.withOpacity(0.15),
        isUrgent: true,
        isOverdue: false,
      );
    }
    // Normal unpaid → blue
    return InvoiceCardTheme(
      primary: kBlue,
      primaryLight: kBlue.withOpacity(0.08),
      isUrgent: false,
      isOverdue: false,
    );
  }
}

class invoicescreen extends StatefulWidget {
  const invoicescreen({super.key});

  @override
  State<invoicescreen> createState() => _invoicescreenState();
}

class _invoicescreenState extends State<invoicescreen> {
  String _selectedTab = 'All';

  final List<String> _tabOptions = [
    'All',
    'Paid',
    'Unpaid',
    'Overdue',
    'Draft',
  ];

  final List<Map<String, dynamic>> _invoices = [
    {
      'name': 'Jansen Ackless',
      'email': 'jansen@06gmail.com',
      'amount': '\$5.200',
      'id': '#0023',
      'date': '04 Dec 2024',
      'status': 'Paid',
      'image': 'https://i.pravatar.cc/150?u=1',
      'dueDate': DateTime(2024, 12, 4),
    },
    {
      'name': 'Mia Wong',
      'email': 'mia.wong@example.com',
      'amount': '\$3.450',
      'id': '#0024',
      'date': '05 Dec 2024',
      'status': 'Unpaid',
      'image': 'https://i.pravatar.cc/150?u=2',
      'dueDate': DateTime.now().add(const Duration(days: 5)),
    },
    {
      'name': 'Liam Smith',
      'email': 'liam.smith@test.com',
      'amount': '\$8.100',
      'id': '#0025',
      'date': '06 Dec 2024',
      'status': 'Overdue',
      'image': 'https://i.pravatar.cc/150?u=3',
      'dueDate': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'name': 'Emma Davis',
      'email': 'emma.d@demo.com',
      'amount': '\$1.200',
      'id': '#0026',
      'date': '07 Dec 2024',
      'status': 'Draft',
      'image': 'https://i.pravatar.cc/150?u=4',
      'dueDate': DateTime.now().add(const Duration(days: 14)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F1EA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF4F1EA),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Invoice',
          style: TextStyle(
            color: Color(0xFF1A2B61),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _invoicesearchbtn(),
            const SizedBox(height: 20),
            _tabs(),
            const SizedBox(height: 20),
            _invoiceList(),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Widget _invoicesearchbtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Color(0xFF1A2B61), width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _tabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: _tabOptions.map((tab) {
          final isSelected = _selectedTab == tab;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTab = tab;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF1A2B61)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFF1A2B61), width: 1.5),
              ),
              child: Text(
                tab,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF1A2B61),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _invoiceList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _invoices.length,
      itemBuilder: (context, index) {
        final invoice = _invoices[index];
        // simple filter logic
        if (_selectedTab != 'All' && invoice['status'] != _selectedTab) {
          return Container();
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: InvoiceCard(
            name: invoice['name'],
            email: invoice['email'],
            amount: invoice['amount'],
            id: invoice['id'],
            date: invoice['date'],
            status: invoice['status'],
            image: invoice['image'],
            dueDate: invoice['dueDate'] as DateTime?,
          ),
        );
      },
    );
  }
}

class InvoiceCard extends StatelessWidget {
  final String name;
  final String email;
  final String amount;
  final String id;
  final String date;
  final String status;
  final String image;
  final DateTime? dueDate;

  const InvoiceCard({
    super.key,
    required this.name,
    required this.email,
    required this.amount,
    required this.id,
    required this.date,
    required this.status,
    required this.image,
    this.dueDate,
  });

  InvoiceCardTheme get _theme =>
      InvoiceCardTheme.fromStatusAndDue(status, dueDate);

  @override
  Widget build(BuildContext context) {
    final theme = _theme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content: padding on sides and top only
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top: avatar (initials) + name/email + status pill
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.primary,
                            child: Text(
                              _getInitials(name),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A2B61),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  email,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: const Color(
                                      0xFF1A2B61,
                                    ).withOpacity(0.6),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: theme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                // Middle: circular timer + days left / due date / term / urgent
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _buildTimerSection(theme),
                ),
              ],
            ),
          ),
          // Bottom bar: full-bleed, theme color, rounded bottom corners only
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: theme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(child: _buildInfoColumn('Amount', amount)),
                VerticalDivider(
                  color: Colors.white.withOpacity(0.35),
                  thickness: 1,
                  indent: 4,
                  endIndent: 4,
                ),
                Expanded(child: _buildInfoColumn('No', id)),
                VerticalDivider(
                  color: Colors.white.withOpacity(0.35),
                  thickness: 1,
                  indent: 4,
                  endIndent: 4,
                ),
                Expanded(child: _buildInfoColumn('Date', date)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const int _defaultTermDays = 30;

  Widget _buildTimerSection(InvoiceCardTheme theme) {
    final isPaid = status == 'Paid';
    final isDraft = status == 'Draft';

    if (dueDate == null) {
      if (isPaid) {
        return Text(
          'Paid',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: theme.primary,
          ),
        );
      }
      return const SizedBox.shrink();
    }

    final now = DateTime.now();
    final due = dueDate!;
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(due.year, due.month, due.day);
    final daysLeft = dueDay.difference(today).inDays;
    final isOverdue = daysLeft < 0;

    if (isPaid) {
      final paidAgo = now.difference(due).inDays;
      final label = paidAgo <= 0
          ? 'Paid today'
          : 'Paid $paidAgo ${paidAgo == 1 ? 'day' : 'days'} ago';
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, size: 22, color: theme.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.primary,
            ),
          ),
        ],
      );
    }

    // Unpaid / Overdue / Draft: circular timer + text column
    final daysLabel = isOverdue
        ? '${-daysLeft} ${daysLeft == -1 ? 'day' : 'days'} overdue'
        : daysLeft == 0
        ? 'Due today'
        : '$daysLeft ${daysLeft == 1 ? 'day' : 'days'} left${theme.isUrgent ? '!' : ''}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InvoiceTimerRing(
          daysLeft: daysLeft,
          termDays: _defaultTermDays,
          color: theme.primary,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                daysLabel,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: theme.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDueDate(due),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$_defaultTermDays-day term',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (theme.isUrgent && !isDraft) ...[
                const SizedBox(height: 6),
                Text(
                  theme.isOverdue ? 'Overdue' : '▲ Urgent',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: theme.primary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  static String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      final s = parts[0];
      return s.length >= 2 ? s.substring(0, 2).toUpperCase() : s.toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  static String _formatDueDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return 'Due ${d.day} ${months[d.month - 1]} ${d.year}';
  }
}

/// Circular timer ring: outer grey ring + colored progress arc, "X DAYS" inside.
class _InvoiceTimerRing extends StatelessWidget {
  const _InvoiceTimerRing({
    required this.daysLeft,
    required this.termDays,
    required this.color,
  });

  final int daysLeft;
  final int termDays;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final progress = termDays <= 0
        ? 0.0
        : (daysLeft / termDays).clamp(0.0, 1.0);
    final displayDays = daysLeft < 0 ? 0 : daysLeft;
    final label = daysLeft < 0 ? 'OVERDUE' : '$displayDays DAYS';

    return SizedBox(
      width: 80,
      height: 80,
      child: CustomPaint(
        painter: _TimerRingPainter(
          progress: progress,
          color: color,
          isOverdue: daysLeft < 0,
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  _TimerRingPainter({
    required this.progress,
    required this.color,
    required this.isOverdue,
  });

  final double progress;
  final Color color;
  final bool isOverdue;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const strokeWidth = 6.0;
    final radius = size.width / 2 - strokeWidth;
    final innerRadius = radius - strokeWidth - 4;

    // 1. Inner filled circle (theme color)
    if (innerRadius > 0) {
      canvas.drawCircle(center, innerRadius, Paint()..color = color);
    }

    // 2. Outer grey ring (full circle)
    final ringPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, ringPaint);

    // 3. Progress arc (sweep from top, clockwise = time left)
    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    const startAngle = -3.14159 / 2; // top
    final sweepAngle = 2 * 3.14159 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimerRingPainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.isOverdue != isOverdue;
}
