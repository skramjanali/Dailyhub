import 'package:flutter/material.dart';

void main() => runApp(const DailyHubApp());

class DailyHubApp extends StatelessWidget {
  const DailyHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DailyHub',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF3157E8),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int tab = 0;

  final pages = const [
    HomePage(),
    ServicesPage(),
    WalletPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) {
          setState(() => tab = v);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Welcome back 👋',
            style: TextStyle(color: Colors.black54),
          ),
          const Text(
            'DailyHub',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF3157E8),
                  Color(0xFF7048E8),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wallet Balance',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 5),
                Text(
                  '₹ 1,250.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Demo balance',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          const Text(
            'Quick Services',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            childAspectRatio: .8,
            children: const [
              ActionTile(Icons.phone_android, 'Recharge'),
              ActionTile(Icons.tv, 'DTH'),
              ActionTile(Icons.bolt, 'Electricity'),
              ActionTile(Icons.receipt_long, 'Bills'),
              ActionTile(Icons.qr_code_scanner, 'QR Scan'),
              ActionTile(Icons.calculate, 'Calculator'),
              ActionTile(Icons.pie_chart, 'Expenses'),
              ActionTile(Icons.card_giftcard, 'Rewards'),
            ],
          ),

          const SizedBox(height: 18),

          Card(
            elevation: 0,
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.card_giftcard),
              ),
              title: const Text('Invite & Earn'),
              subtitle: const Text(
                'Share your referral code',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => const AlertDialog(
                    title: Text('Referral'),
                    content: Text(
                      'Your referral code: DH2026\n\n'
                      'Demo reward: ₹10 per eligible referral.',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionTile(
    this.icon,
    this.label, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 27,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      'Mobile Recharge',
      'DTH Recharge',
      'Electricity Bill',
      'Water Bill',
      'QR Scanner',
      'Expense Tracker',
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Services',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...services.map(
            (service) => Card(
              elevation: 0,
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.flash_on),
                ),
                title: Text(service),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$service demo opened'),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Wallet',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          const Card(
            elevation: 0,
            child: ListTile(
              title: Text('Available Balance'),
              subtitle: Text(
                '₹ 1,250.00',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'Transactions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.phone_android),
            ),
            title: Text('Mobile Recharge'),
            subtitle: Text('SUCCESS • Demo'),
            trailing: Text('-₹199'),
          ),

          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.card_giftcard),
            ),
            title: Text('Referral Reward'),
            subtitle: Text('SUCCESS • Demo'),
            trailing: Text('+₹10'),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      'Account',
      'Referral & Rewards',
      'Notifications',
      'Help & Support',
      'Privacy Policy',
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const CircleAvatar(
            radius: 42,
            child: Icon(
              Icons.person,
              size: 45,
            ),
          ),
          const SizedBox(height: 12),

          const Center(
            child: Text(
              'DailyHub User',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 22),

          ...items.map(
            (item) => Card(
              elevation: 0,
              child: ListTile(
                title: Text(item),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
