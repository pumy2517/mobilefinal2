import 'package:sqflite/sqflite.dart';

final String tableTodo = "account";
final String columnId = "_id";
final String columnUser = "userid";
final String columnName = "name";
final String columnAge = "age";
final String columnPassword = "password";

class Account {
  int id;
  String userid;
  String name;
  int age;
  String password;

   Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnUser: userid,
      columnName: name,
      columnAge: age,
      columnPassword: password,

    };
    if (id != null) { map[columnId] = this.id; }
    
    return map;
  }

  Account({int id,String userid, String name, int age, String password}){
    this.id = id;
    this.userid = userid;
    this.name = name;
    this.age = age;
    this.password = password;
  }


  Account.formMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.userid = map[columnUser];
    this.name = map[columnName];
    this.age = map[columnAge];
    this.password = map[columnPassword];
  }

}

class TodoProvider {
  Database db;

  Future open({String path = 'account.db'}) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $tableTodo (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnUser TEXT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnAge INTEGER NOT NULL,
            $columnPassword TEXT NOT NULL

      )
      ''');
    });
  }

  Future<Account> insert(Account account) async {
    account.id = await db.insert(tableTodo, account.toMap());
    return account;
  }

    Future<Account> getAccount(int id) async {
    List<Map> maps = await this.db.query(
          tableTodo,
          columns: [columnId, columnUser, columnName, columnAge, columnPassword],
          where: '$columnId = ?',
          whereArgs: [id],
        );

    if (maps.length > 0) {
      return Account.formMap(maps.first);
    }

    return null;
  }

  Future<Account> getAccountByUserId(String userId) async {
    List<Map> maps = await this.db.query(
          tableTodo,
          columns: [columnId, columnUser, columnName, columnAge, columnPassword],
          where: '$columnUser = ?',
          whereArgs: [userId],
        );

    if (maps.length > 0) {
      return Account.formMap(maps.first);
    }

    return null;
  }

  Future<int> delete(int id) async {
    return await this.db.delete(
      tableTodo,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteByUserId(String userId) async {
    return await this.db.delete(
      tableTodo,
      where: '$columnId = ?',
      whereArgs: [userId],
    );
  }

  Future<void> update(Account account) async {
    await this.db.update(
      tableTodo,
      account.toMap(),
      where: '$columnId = ?',
      whereArgs: [account.id],
    );
  }

  Future close() async => db.close();

}