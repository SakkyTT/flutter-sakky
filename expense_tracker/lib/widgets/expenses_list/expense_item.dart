import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

// Listan yksi item, eli yksi ostoksen UI-kortti

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contekstilla voidaan hakea vanhempien objekteja
            Text(
              expense.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(letterSpacing: 4),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('${expense.amount.toStringAsFixed(2)}€'),
                // 34.33333333333333333333  escape syntax = esim. \$
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expense.formattedDate),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
