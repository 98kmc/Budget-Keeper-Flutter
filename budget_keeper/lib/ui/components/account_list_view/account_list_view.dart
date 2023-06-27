import 'package:budget_keeper/data/budget_keeper_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../domain/entity/account.dart';
import '../../screens/update_screen/update_screen.dart';
import 'dismissable_item.dart';

class BudgetListView extends StatefulWidget {
  final Function() refreshHomeCallBack;

  const BudgetListView({required this.refreshHomeCallBack, super.key});

  @override
  MiLista createState() => MiLista();
}

class MiLista extends State<BudgetListView> {
  List<Account> accountList = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getData();
  }

  @override
  void didUpdateWidget(covariant BudgetListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: accountList.length,
        itemBuilder: (context, i) {
          return DismissableItem(
              index: i,
              accountList: accountList,
              getDataCallBack: _getData,
              navigateToUpdateScreenCallback: navigateToUpdateScreen,
              refreshHomeCallBack: widget.refreshHomeCallBack);
        });
  }

//Private Methods
  void _getData() async {
    final List<Account> accountsResponse =
        await BudgetKeeperRepository.getAllAccounts();
    setState(() {
      accountList = accountsResponse;
    });
  }

  Future navigateToUpdateScreen(
      Account currentAccount, BuildContext context) async {
    String? _ = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                UpdateScreen(currentAccount: currentAccount, isNew: false)));
    widget.refreshHomeCallBack();
  }

  void showErrorToast() {
    Fluttertoast.showToast(
      msg: "THE toast message",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
