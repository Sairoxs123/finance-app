import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  final String id;
  final String description;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory Transaction.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Transaction(
      id: doc.id,
      description: data['description'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'description': description,
      'amount': amount,
      'date': Timestamp.fromDate(date),
    };
  }
}
