import 'dart:io';

import 'package:mysql1/mysql1.dart';

class DbConnection {
  static const user = '';
  static const port = 3306;
  static const host = '';
  static const password = '';
  static const db = '';

  connectToDb() async {
    return await MySqlConnection.connect(ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db));
  }

  connectionClose(var connection) async {
    connection.close();
  }
}
