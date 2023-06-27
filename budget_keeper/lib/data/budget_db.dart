import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../domain/entity/account.dart';

class BudgetDB {

  late final BudgetDB instance;
  static Database? _database;

  BudgetDB.initDatabaseConection() : instance = BudgetDB._init();

  BudgetDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('budget.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const decimalType = 'DECIMAL(6,1)';

    await db.execute('''CREATE TABLE $tableAccounts ( 
      ${AccountFields.id} $idType,
      ${AccountFields.name} $textType,
      ${AccountFields.amount} $decimalType)''');
  }

  Future<Account> insert(Account account) async {
    final db = await instance.database;
    final id = await db.insert(tableAccounts, account.toJson());
    return account.copy(id: id);
  }

  Future<Account> getAccount(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableAccounts,
      columns: AccountFields.values,
      where: '${AccountFields.id} = ?',
      whereArgs: [id],
    );

    return (maps.isNotEmpty)
        ? Account.fromJson(maps.first)
        : throw Exception('ID $id not found');
  }

  Future<List<Account>> getAllAccounts() async {
    final db = await instance.database;
    const orderBy = '${AccountFields.id} DESC';
    final result = await db.query(tableAccounts, orderBy: orderBy);
    return result.map((json) => Account.fromJson(json)).toList();
  }

  Future<int> update(Account account) async {
    final db = await instance.database;
    return db.update(
      tableAccounts,
      account.toJson(),
      where: '${AccountFields.id} = ?',
      whereArgs: [account.id],
    );
  }

  Future delete(int id) async {
    final db = await instance.database;
    await db.delete(
      tableAccounts,
      where: '${AccountFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
