import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) removeTransaction;

  const TransactionList(this.transactions, this.removeTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transactions.isEmpty
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
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
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
                            onPressed: () => removeTransaction(tr.id),
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
                            onPressed: () => removeTransaction(tr.id),
                            child: const Icon(Icons.delete, color: Colors.red),
                          ),
                  ),
                );
              },
            ),
    );
  }
}
