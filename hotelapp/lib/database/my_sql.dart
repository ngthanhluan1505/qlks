import 'package:mysql1/mysql1.dart';

class MySQL {
  final String _host = '10.0.2.2',
      _user = 'luan',
      _passWord = '1234',
      _dbName = 'quanlykhachsan';

  final int _port = 3306;

  Future<MySqlConnection> connectDB() async {
    return await MySqlConnection.connect(ConnectionSettings(
        host: _host,
        port: _port,
        user: _user,
        password: _passWord,
        db: _dbName));
  }

  Future closeDB(MySqlConnection connect) async {
    await connect.close();
  }
}
/* Example

Future<String> _testdb() async {
  MySQL db = MySQL();
  String data = '';
  var conn = await db.connectDB();
  String sql = 'select * from test';
  await conn.query(sql).then((rs) {
    for (var row in rs) {
      data = row[1].toString();
    }
  });
  db.closeDB(conn);
  return data;
}

Future _testdb2() async {
  MySQL db = MySQL();
  var conn = await db.connectDB();
  String sql =
      "INSERT INTO `test`(`id`, `name`, `sex`) VALUES ('5','ppp','lll')";
  await conn.query(sql);
  db.closeDB(conn);
}

void _incrementCounter() async {
  String t = await _testdb();
  await _testdb2();
  setState(() {
    _counter++;
    _row = t;
    print(_counter);
  });
}
*/