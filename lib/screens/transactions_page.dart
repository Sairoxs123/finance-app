import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart' as app_transaction;
import '../services/transaction_service.dart';
import 'add_transaction_screen.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTransactionScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamProvider<List<app_transaction.Transaction>>.value(
        value: TransactionService().getTransactions(),
        initialData: const [],
        child: const TransactionList(),
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<List<app_transaction.Transaction>>(context);

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(transaction.description),
          subtitle: Text(transaction.date.toString()),
          trailing: Text('\$${transaction.amount.toStringAsFixed(2)}'),
        );
      },
    );
  }
}
