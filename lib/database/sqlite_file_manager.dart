import '../utils/fileutils.dart' as fu;
import 'package:path/path.dart';
import './dbmanage.dart' show initSqlite;

final String dbPath = join('assets', 'sqlite.db');

void restoreSqliteData(){
  fu.deleteFile(dbPath);
  initSqlite();
}