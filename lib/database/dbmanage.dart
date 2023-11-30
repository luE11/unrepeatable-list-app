import 'dart:developer';

import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart';
import '../utils/fileutils.dart' as fu;

final String dbPath = join('assets', 'sqlite.db');

void initSqlite(){
  if(!fu.checkFileExists(dbPath)){
    fu.copyFile(join('assets', 'empty.db'), dbPath);
    log("db copied");
  }
  final db = sqlite3.open( join('assets', 'sqlite.db'));
  try {
    db.execute('''
      CREATE TABLE tags (
        id INTEGER NOT NULL PRIMARY KEY,
        tag TEXT NOT NULL UNIQUE
      );
      CREATE TABLE items (
        id INTEGER NOT NULL PRIMARY KEY,
        concept TEXT NOT NULL UNIQUE,
        description TEXT NOT NULL,
        tag_id INTEGER,
        FOREIGN KEY(tag_id) REFERENCES tags(id)
      );
    ''');
  } catch (e) {
    log("Tables already created");
  }
  db.dispose();
}

void executeDatabaseOperation(String operation, [List<Object?> parameters = const []]){
  final db = sqlite3.open( join('assets', 'sqlite.db'));
  db.execute(operation, parameters); 
  db.dispose();
}

ResultSet executeQuery(String query, [List<Object?> parameters = const []]){
  final db = sqlite3.open( join('assets', 'sqlite.db'));
  ResultSet rows = db.select(query, parameters);
  db.dispose();
  return rows;
}