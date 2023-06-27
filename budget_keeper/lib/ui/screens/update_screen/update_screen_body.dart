import 'package:budget_keeper/data/budget_keeper_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money2/money2.dart';

import '../../../domain/entity/account.dart';


class UpdateScreenFields extends StatelessWidget {
  final Currency usd = Currency.create('\$', 2);
  final errorMsg = 'Se permiten unicamente valores numericos';
  final TextEditingController _textField = TextEditingController();
  late final Account? currentAccount;
  late final bool isNew;
  late final String amountHint;

  UpdateScreenFields(
      {super.key, required this.isNew, required this.currentAccount}) {
    amountHint =
        Money.fromNumWithCurrency(currentAccount?.amount ?? 0, usd).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InputText(amountHint: amountHint, textField: _textField, isNew: isNew),
        SaveButton(accountActionCallBack: () {
          addOrUpdateAccount(currentAccount, _textField.text).then((value) {
            if (value != 'Done') {
              showErrorToast(errorMsg);
              return;
            }
            Navigator.pop(context);
          });
        })
      ],
    );
  }

  //Private Methods
  Future<String> addOrUpdateAccount(Account? account, String text) async {
    return isNew
        ? await BudgetKeeperRepository.insert(name: text)
        : await BudgetKeeperRepository.update(
            id: account?.id, name: account?.name, amount: text);
  }

  void showErrorToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(200, 0, 0, 0),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

class SaveButton extends StatelessWidget {
  final Function() accountActionCallBack;
  final saveButtonTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );
  final style = ElevatedButton.styleFrom(
    minimumSize: const Size(120, 50),
    backgroundColor: (const Color.fromARGB(255, 67, 86, 200)),
  );
  SaveButton({required this.accountActionCallBack, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style,
      onPressed: () {
        accountActionCallBack();
      },
      child: Text('save', style: saveButtonTextStyle),
    );
  }
}

class InputText extends StatelessWidget {
  late final TextEditingController _textField;
  final bool isNew;
  final String amountHint;
  final numbersOnlyInputType =
      const TextInputType.numberWithOptions(signed: false, decimal: true);
  late final InputDecoration decoration;
  InputText(
      {super.key,
      required this.amountHint,
      required TextEditingController textField,
      required this.isNew}) {
    decoration = InputDecoration(
      border: InputBorder.none,
      hintText: (isNew) ? 'Enter the Name' : amountHint,
    );
    _textField = textField;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 90, right: 90),
      child: TextField(
        controller: _textField,
        maxLength: (isNew) ? 10 : 6,
        textAlign: TextAlign.center,
        autofocus: true,
        keyboardType: (!isNew) ? numbersOnlyInputType : TextInputType.text,
        decoration: decoration,
      ),
    );
  }
}
