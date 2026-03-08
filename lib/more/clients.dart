import 'package:flutter/material.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F1EA),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Clients',
          style: TextStyle(
            color: Color(0xFF1A2B61),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _Searchbar(),
            _ClientList(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: _createclientbtn(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _Searchbar() {
  return Padding(
    padding: const EdgeInsets.all(20),
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

Widget _ClientList() {
  // Proper list structure with Maps for each client
  final clients = [
    {
      'name': 'Jerry Oboat',
      'email': 'jerry@example.com',
      'phone': '+1 234 567 8900',
      'image': 'https://i.pravatar.cc/150?u=jerry',
    },
    {
      'name': 'Sarah Johnson',
      'email': 'sarah.j@example.com',
      'phone': '+1 234 567 8901',
      'image': 'https://i.pravatar.cc/150?u=sarah',
    },
    {
      'name': 'Mike Chen',
      'email': 'mike.chen@example.com',
      'phone': '+1 234 567 8902',
      'image': 'https://i.pravatar.cc/150?u=mike',
    },
    {
      'name': 'Emma Davis',
      'email': 'emma.d@example.com',
      'phone': '+1 234 567 8903',
      'image': 'https://i.pravatar.cc/150?u=emma',
    },
  ];

  return Expanded(
    child: GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns
        crossAxisSpacing: 12, // Space between columns
        mainAxisSpacing: 12, // Space between rows
        childAspectRatio: 0.85, // Width/Height ratio of each card
      ),
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1A2B61).withAlpha(100)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(client['image'] as String),
              ),
              const SizedBox(height: 12),
              Text(
                client['name'] as String,
                style: const TextStyle(
                  color: Color(0xFF1A2B61),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                client['email'] as String,
                style: TextStyle(
                  color: const Color(0xFF1A2B61).withOpacity(0.6),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                client['phone'] as String,
                style: TextStyle(
                  color: const Color(0xFF1A2B61).withOpacity(0.6),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget _createclientbtn() {
  return SizedBox(
    width: double.infinity,
    child: Builder(
      builder: (context) => ElevatedButton(
        onPressed: () => showCreateClientSheet(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A2B61),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: const Text('Create Client'),
      ),
    ),
  );
}

void showCreateClientSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            SizedBox(height: 20),
            Text(
              'Create Client',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A2B61),
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                // TODO: Add photo picker
              },
              child: CircleAvatar(
                radius: 32,
                backgroundColor: Color(0xFF1A2B61).withOpacity(0.08),
                child: Icon(
                  Icons.add_a_photo,
                  size: 28,
                  color: Color(0xFF1A2B61).withOpacity(0.6),
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Color(0xFF1A2B61)),
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF1A2B61), width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Color(0xFF1A2B61)),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF1A2B61), width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone, color: Color(0xFF1A2B61)),
                  hintText: 'Phone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF1A2B61), width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: Save client with form data
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A2B61),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Create Client'),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
          ),
        ),
      );
    },
  );
}
