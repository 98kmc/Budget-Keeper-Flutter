class Account {
  int? id;
  String? name;
  num? amount;

  Account({required this.id, required this.name, required this.amount});

  Account copy({int? id, String? name, num? amount}) => Account(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount);

  static Account fromJson(Map<String, dynamic> json) => Account(
      id: json[AccountFields.id] as int,
      name: json[AccountFields.name] as String,
      amount: json[AccountFields.amount] as num);

  Map<String, dynamic> toJson() => {
        AccountFields.id: id,
        AccountFields.name: name,
        AccountFields.amount: amount
      };
}

const String tableAccounts = 'Account';

class AccountFields {
  static final List<String> values = [id, name, amount];
  static const String id = '_id';
  static const String name = 'name';
  static const String amount = 'amount';
}