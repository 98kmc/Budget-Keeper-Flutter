import 'package:flutter/material.dart';
import 'package:money2/money2.dart';

import '../../../domain/entity/account.dart';

class ListItemCard extends StatelessWidget {
  final Future Function(Account, BuildContext) navigateToUpdateScreenCallback;
  final Currency usd = Currency.create('\$', 2);
  final style = const TextStyle(
    color: Colors.white,
    fontSize: 28.0,
  );
  final decoration = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 67, 86, 200),
        Color.fromARGB(255, 147, 92, 173),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
  late final String cardTitleText;
  late final String cardAmountText;
  late final Account account;

  ListItemCard({
    super.key,
    required this.account,
    required this.navigateToUpdateScreenCallback,
  }) {
    cardTitleText = account.name ?? 'New Account';
    cardAmountText =
        Money.fromNumWithCurrency(account.amount ?? 0, usd).toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        navigateToUpdateScreenCallback(account, context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        height: 80,
        decoration: decoration,
        child: Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
                title: Text(cardTitleText, style: style),
                trailing: Text(cardAmountText, style: style))),
      ),
    );
  }
}
