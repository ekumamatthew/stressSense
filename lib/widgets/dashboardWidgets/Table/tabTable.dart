import 'package:flutter/material.dart';

class TransactionTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Transaction History'),
                Tab(text: 'Insurance History'),
              ],
            ),
            title: const Text('History'),
          ),
          body: TabBarView(
            children: [
              TransactionHistory(),
              InsuranceHistory(), // Placeholder for your other tab content
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TransactionItem(
          icon: Icons.call_received,
          title: 'Jane Doe - GT Bank',
          subtitle: '16/6/2023 - 8:30am',
          amount: '+₦20,000',
          color: Colors.green,
        ),
        TransactionItem(
          icon: Icons.call_made,
          title: 'MTN Ng Vtu 23456745463',
          subtitle: '16/6/2023 - 8:30am',
          amount: '-₦10,000',
          color: Colors.red,
        ),
        // Add more TransactionItem widgets...
      ],
    );
  }
}

class TransactionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final Color color;

  const TransactionItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(
        amount,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class InsuranceHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for the content of the Insurance History tab
    return Center(child: Text('Insurance History Content'));
  }
}
