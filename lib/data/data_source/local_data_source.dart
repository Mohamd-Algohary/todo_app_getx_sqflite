import 'package:sqflite/sqflite.dart';

import '../../app/constants.dart';

class LocalDataSource {
  static Database? db;

  static Future<void> initDB() async {
    //! Check if db existing
    if (db != null)
      return;
    else {
      try {
        //! Get a location using getDatabasesPath
        String dbPath = '${await getDatabasesPath()}tasks.db';
        //! open the database
        db = await openDatabase(
          dbPath,
          version: Constants.version,
          onCreate: (db, version) async {
            //! When creating the db, create the table
            await db.execute('CREATE TABLE ${Constants.tableName}('
                'id INTEGER PRIMARY KEY autoincrement, '
                'title TEXT, note TEXT, '
                'isCompleted INTEGER, '
                'date TEXT, '
                'startTime TEXT, '
                'endTime TEXT, '
                'color INTEGER, '
                'remind INTEGER, '
                'repeat TEXT)');
          },
        );
      } catch (ex) {
        throw Exception(ex);
      }
    }
  }

  //! Colse Database
  Future close() async => db!.close();
}
