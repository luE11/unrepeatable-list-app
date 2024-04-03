import 'dart:developer';

import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart';
import '../utils/fileutils.dart' as fu;

const String dbPath = 'sqlite.db';
final String assetDb = join('assets', 'empty.db');

void initSqlite(){
  if(!fu.checkFileExists(dbPath)){
    fu.copyFile(assetDb, dbPath);
    log("db copied");
  }
  final db = sqlite3.open( dbPath);
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
  final db = sqlite3.open( dbPath);
  db.execute(operation, parameters); 
  db.dispose();
}

ResultSet executeQuery(String query, [List<Object?> parameters = const []]){
  final db = sqlite3.open( dbPath);
  ResultSet rows = db.select(query, parameters);
  db.dispose();
  return rows;
}