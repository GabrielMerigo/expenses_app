import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final void Function(String) removeTransaction;

  const TransactionList(this.transactions, this.removeTransaction, {super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.green,
    Colors.blue,
  ];

  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();

    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    print(_backgroundColor);

    return Expanded(
      child: widget.transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constrains) {
              return Column(
                children: [
                  SizedBox(height: 20),
                  Text('Não há transações cadastradas'),
                  SizedBox(height: 30),
                  SizedBox(
                    height: constrains.maxHeight * 0.3,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemCount: widget.transactions.length,
              itemBuilder: (ctx, index) {
                final tr = widget.transactions[index];

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _backgroundColor,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('R\$ ${tr.value}'),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 480
                        ? TextButton(
                            onPressed: () => widget.removeTransaction(tr.id),
                            child: Row(
                              children: const [
                                Icon(Icons.delete, color: Colors.red),
                                Text(
                                  'Excluir',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          )
                        : TextButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.zero,
                              ),
                            ),
                            onPressed: () => widget.removeTransaction(tr.id),
                            child: const Icon(Icons.delete, color: Colors.red),
                          ),
                  ),
                );
              },
            ),
    );
  }
}
