import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/user.dart';  // Make sure the Saham model is defined in this path

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'example.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Sahaminaja("
              "tickerid INTEGER PRIMARY KEY AUTOINCREMENT, "
              "ticker TEXT NOT NULL,"
              "open INTEGER,"
              "high INTEGER,"
              "last INTEGER,"
              "change TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertSahaminaja(dynamic SahamAja) async {
    int result = 0;
    final Database db = await initializeDB();

    if (SahamAja is Sahaminaja) {
      return await db.insert('Sahaminaja', SahamAja.toMap());
    } else if (SahamAja is List<Sahaminaja>) {
      for (var Sahaminaja in SahamAja) {
        result = await db.insert('Sahaminaja', Sahaminaja.toMap());
      }
      return result;
    } else {
      throw ArgumentError('Expected either a Sahaminaja or List<Sahaminaja> argument');
    }
  }

  Future<List<Sahaminaja>> retrieveSahamAja() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('Sahaminaja');
    return queryResult.map((e) => Sahaminaja.fromMap(e)).toList();
  }
}