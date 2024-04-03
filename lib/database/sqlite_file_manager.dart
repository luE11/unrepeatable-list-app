import '../utils/fileutils.dart' as fu;
import './dbmanage.dart' show initSqlite, dbPath;

void restoreSqliteData(){
  fu.deleteFile(dbPath);
  initSqlite();
}