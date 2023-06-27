
import '../domain/entity/account.dart';
import 'budget_db.dart';

class BudgetKeeperRepository {
  
  static BudgetDB? _databaseInstance;

  static BudgetDB _shared() {
    return _databaseInstance ??= BudgetDB.initDatabaseConection();
  }

  static Future<String> insert({required String name}) async {
    try {
      Account account = Account(
          id: null, name: (name.isEmpty) ? 'New Account' : name, amount: 0.0);
      _shared().insert(account);
      return 'Done';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> update(
      {required int? id,
      required String? name,
      required String? amount}) async {
    try {
      if (id != null && name != null && amount != null) {
        Account account = Account(
            id: id,
            name: (name.isEmpty) ? 'New Account' : name,
            amount: (amount.isEmpty) ? 0 : formatAmount(amount: amount));
        _shared().update(account);
        return 'Done';
      } else {
        return 'Error';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<Account>> getAllAccounts() async {
    try {
      List<Account> accountList = await _shared().getAllAccounts();
      return accountList;
    } catch (e) {
      return [];
    }
  }

  static Future<String> delete({required int? id}) async {
    try {
      if (id != null) {
        await _shared().delete(id);
        return 'Account has been deleted';
      } else {
        return 'ID not found';
      }
    } catch (e) {
      return e.toString();
    }
  }

  static double formatAmount({required String? amount}) {
    String formatedAmount =
        amount?.replaceAll(",", ".").replaceAll('_', '') ?? '0';
    return double.parse(formatedAmount).abs();
  }
}
