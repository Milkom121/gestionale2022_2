import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
class DBConnection {

  static DBConnection? _instance;

  final String _getConnectionString = "MONGODB_ATLAS_URI";

  Db? _db;

  static getInstance(){
    if(_instance == null) {
      _instance = DBConnection();
    }
    return _instance;
  }

  Future<Db?> getConnection() async{
    if (_db == null){
      try {
        _db = Db.create(_getConnectionString) as Db?;
        await _db!.open();
      } catch(e){
        print(e);
      }
    }
    return _db;
  }

  closeConnection() {
    _db!.close();
  }
}