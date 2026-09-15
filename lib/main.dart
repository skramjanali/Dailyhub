import 'package:flutter/material.dart';

void main() {
  runApp(const DailyHub());
}

// ============================================================
// DAILYHUB APP
// ============================================================

class DailyHub extends StatelessWidget {
  const DailyHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DailyHub',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7FB),
        colorSchemeSeed: const Color(0xFF5B45E8),
        fontFamily: 'Roboto',
      ),
      home: const MainShell(),
    );
  }
}

// ============================================================
// WALLET MANAGER
// ============================================================

class WalletManager {
  static final ValueNotifier<double> balance =
      ValueNotifier<double>(1250.00);

  static final ValueNotifier<List<TransactionItem>> transactions =
      ValueNotifier<List<TransactionItem>>([
    TransactionItem(
      icon: Icons.phone_android,
      title: 'Mobile Recharge',
      subtitle: 'Today • Successful',
      amount: -199.00,
    ),
    TransactionItem(
      icon: Icons.card_giftcard,
      title: 'Referral Reward',
      subtitle: 'Yesterday • Successful',
      amount: 10.00,
    ),
  ]);

  static void addMoney(double amount) {
    balance.value += amount;

    transactions.value = [
      TransactionItem(
        icon: Icons.add_card,
        title: 'Money Added',
        subtitle: 'Just now • Successful',
        amount: amount,
      ),
      ...transactions.value,
    ];
  }
}

// ============================================================
// TRANSACTION MODEL
// ============================================================

class TransactionItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final double amount;

  const TransactionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
  });
}

// ============================================================
// MAIN SHELL
// ============================================================

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selected = 0;

  final pages = const [
    Home(),
    Services(),
    Wallet(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selected],
      bottomNavigationBar: NavigationBar(
        height: 72,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFEAE6FF),
        selectedIndex: selected,
        onDestinationSelected: (value) {
          setState(() {
            selected = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.apps_outlined),
            selectedIcon: Icon(Icons.apps),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.account_balance_wallet_outlined,
            ),
            selectedIcon: Icon(
              Icons.account_balance_wallet,
            ),
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

// ============================================================
// HOME
// ============================================================

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning 👋',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'DailyHub',
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'No new notifications',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.notifications_none,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // ==================================================
          // WALLET CARD
          // ==================================================

          Container(
            padding: const EdgeInsets.all(21),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF5A43E7),
                  Color(0xFF8767F2),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 22,
                  offset: Offset(0, 10),
                  color: Color(0x225A43E7),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Total Wallet Balance',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'SAFE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                ValueListenableBuilder<double>(
                  valueListenable:
                      WalletManager.balance,
                  builder:
                      (context, balance, child) {
                    return Text(
                      '₹ ${balance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor:
                              const Color(0xFF5A43E7),
                        ),
                        onPressed: () {
                          _showAddMoneyDialog(context);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'Add Money',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(
                            color: Colors.white54,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const TransactionHistoryPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.history,
                        ),
                        label: const Text(
                          'History',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 23),

          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 13),

          Row(
            children: const [
              Quick(
                Icons.phone_android,
                'Recharge',
              ),
              Quick(
                Icons.tv,
                'DTH',
              ),
              Quick(
                Icons.bolt,
                'Electricity',
              ),
              Quick(
                Icons.receipt_long,
                'Bills',
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              const Expanded(
                child: Text(
                  'Rewards & Offers',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _showComingSoon(context);
                },
                child: const Text('View all'),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: () {
                _showComingSoon(context);
              },
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0ECFF),
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.card_giftcard,
                      color: Color(0xFF5A43E7),
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Invite & Earn',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Share your code and earn eligible rewards',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          ValueListenableBuilder<
              List<TransactionItem>>(
            valueListenable:
                WalletManager.transactions,
            builder:
                (context, transactions, child) {
              final recent =
                  transactions.take(3).toList();

              return Column(
                children: recent
                    .map(
                      (item) =>
                          Activity(item: item),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ADD MONEY DIALOG
  // ==========================================================

  void _showAddMoneyDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Add Money',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: controller,
            keyboardType:
                const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Enter amount',
              hintText: '100',
              prefixText: '₹ ',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final amount = double.tryParse(
                  controller.text.trim(),
                );

                if (amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please enter a valid amount',
                      ),
                    ),
                  );
                  return;
                }

                if (amount > 100000) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Maximum demo amount is ₹1,00,000',
                      ),
                    ),
                  );
                  return;
                }

                WalletManager.addMoney(amount);

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      '₹${amount.toStringAsFixed(2)} added successfully',
                    ),
                  ),
                );
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'This service will be connected soon',
        ),
      ),
    );
  }
}

// ============================================================
// QUICK ACTION
// ============================================================

class Quick extends StatelessWidget {
  final IconData icon;
  final String text;

  const Quick(
    this.icon,
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.only(right: 7),
        child: InkWell(
          borderRadius:
              BorderRadius.circular(19),
          onTap: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              SnackBar(
                content: Text(
                  '$text service selected',
                ),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                height: 68,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(19),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x09000000),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color:
                      const Color(0xFF5A43E7),
                  size: 28,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// ACTIVITY
// ============================================================

class Activity extends StatelessWidget {
  final TransactionItem item;

  const Activity({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = item.amount >= 0;

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              const Color(0xFFF0ECFF),
          child: Icon(
            item.icon,
            color:
                const Color(0xFF5A43E7),
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(item.subtitle),
        trailing: Text(
          '${isPositive ? '+' : '-'} ₹${item.amount.abs().toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isPositive
                ? Colors.green
                : Colors.black87,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SERVICES
// ============================================================

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      [
        Icons.phone_android,
        'Mobile Recharge',
        'Prepaid & Postpaid'
      ],
      [
        Icons.tv,
        'DTH Recharge',
        'Quick recharge'
      ],
      [
        Icons.bolt,
        'Electricity',
        'Pay your bill'
      ],
      [
        Icons.water_drop,
        'Water Bill',
        'Utility payment'
      ],
      [
        Icons.qr_code_scanner,
        'QR Scanner',
        'Scan & pay'
      ],
      [
        Icons.calculate,
        'Calculator',
        'Everyday tools'
      ],
      [
        Icons.pie_chart_outline,
        'Expenses',
        'Track spending'
      ],
      [
        Icons.card_giftcard,
        'Rewards',
        'Offers & referral'
      ],
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Services',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Everything you need in one place',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 18),

          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.45,
            ),
            itemBuilder: (_, index) {
              return Card(
                elevation: 0,
                color: Colors.white,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(12),
                  onTap: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          '${items[index][1]} selected',
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Icon(
                          items[index][0]
                              as IconData,
                          color: const Color(
                            0xFF5A43E7,
                          ),
                          size: 28,
                        ),
                        const Spacer(),
                        Text(
                          items[index][1]
                              as String,
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        Text(
                          items[index][2]
                              as String,
                          style:
                              const TextStyle(
                            fontSize: 11,
                            color:
                                Colors.black54,
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
}

// ============================================================
// WALLET PAGE
// ============================================================

class Wallet extends StatelessWidget {
  const Wallet({super.key});

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
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 18),

          Container(
            padding:
                const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient:
                  const LinearGradient(
                colors: [
                  Color(0xFF5A43E7),
                  Color(0xFF8767F2),
                ],
              ),
              borderRadius:
                  BorderRadius.circular(26),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available Balance',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 5),
                ValueListenableBuilder<double>(
                  valueListenable:
                      WalletManager.balance,
                  builder:
                      (context, balance, child) {
                    return Text(
                      '₹ ${balance.toStringAsFixed(2)}',
                      style:
                          const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              const Expanded(
                child: Text(
                  'Transactions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const TransactionHistoryPage(),
                    ),
                  );
                },
                child:
                    const Text('View all'),
              ),
            ],
          ),

          ValueListenableBuilder<
              List<TransactionItem>>(
            valueListenable:
                WalletManager.transactions,
            builder:
                (context, transactions, child) {
              return Column(
                children: transactions
                    .take(5)
                    .map(
                      (item) =>
                          Activity(item: item),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TRANSACTION HISTORY
// ============================================================

class TransactionHistoryPage
    extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F7FB),
      appBar: AppBar(
        title: const Text(
          'Transaction History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            const Color(0xFFF7F7FB),
      ),
      body: ValueListenableBuilder<
          List<TransactionItem>>(
        valueListenable:
            WalletManager.transactions,
        builder:
            (context, transactions, child) {
          if (transactions.isEmpty) {
            return const Center(
              child: Text(
                'No transactions yet',
              ),
            );
          }

          return ListView.builder(
            padding:
                const EdgeInsets.all(18),
            itemCount:
                transactions.length,
            itemBuilder: (_, index) {
              return Activity(
                item: transactions[index],
              );
            },
          );
        },
      ),
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final menu = [
      [
        Icons.person_outline,
        'Account'
      ],
      [
        Icons.card_giftcard,
        'Referral & Rewards'
      ],
      [
        Icons.notifications_none,
        'Notifications'
      ],
      [
        Icons.help_outline,
        'Help & Support'
      ],
      [
        Icons.privacy_tip_outlined,
        'Privacy Policy'
      ],
    ];

    return SafeArea(
      child: ListView(
        padding:
            const EdgeInsets.all(18),
        children: [
          const CircleAvatar(
            radius: 44,
            backgroundColor:
                Color(0xFFEAE6FF),
            child: Icon(
              Icons.person,
              size: 48,
              color: Color(0xFF5A43E7),
            ),
          ),

          const SizedBox(height: 12),

          const Center(
            child: Text(
              'DailyHub User',
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 24),

          ...menu.map(
            (item) => Card(
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  item[0] as IconData,
                  color:
                      const Color(0xFF5A43E7),
                ),
                title: Text(
                  item[1] as String,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${item[1]} selected',
                      ),
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
