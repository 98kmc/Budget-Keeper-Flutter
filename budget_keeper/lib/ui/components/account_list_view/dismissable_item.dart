 import 'package:budget_keeper/data/budget_keeper_repository.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/account.dart';
import 'list_item_card.dart';

class DismissableItem extends StatelessWidget {
  final Function() refreshHomeCallBack;
  final Function() getDataCallBack;
  final Future Function(Account, BuildContext) navigateToUpdateScreenCallback;
  final List<Account> accountList;
  final int index;
  const DismissableItem(
      {super.key,
      required this.index,
      required this.accountList,
      required this.getDataCallBack,
      required this.navigateToUpdateScreenCallback,
      required this.refreshHomeCallBack});

  @override
  Widget build(BuildContext context) {
    final key = ValueKey(accountList[index].id.toString());
    return Dismissible(
        key: key,
        direction: DismissDirection.endToStart,
        background: const DismissableItemBackground(),
        onDismissed: (direction) async {
          await BudgetKeeperRepository.delete(id: accountList[index].id)
              .then((_) {
            accountList.removeAt(index);
            getDataCallBack();
            refreshHomeCallBack();
          });
        },
        child: ListItemCard(
            key: key,
            account: accountList[index],
            navigateToUpdateScreenCallback: navigateToUpdateScreenCallback));
  }
}

class DismissableItemBackground extends StatelessWidget {
  const DismissableItemBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.only(left: 5),
      child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white)),
    );
  }
}
