import 'package:sqlite3/sqlite3.dart';

import '../dbmanage.dart';
import '../../components/uilogger.dart';

void createTag(String tag){
  String operation = '''
    INSERT INTO tags (tag) VALUES (?)
  ''';
  try {
    executeDatabaseOperation(operation, [tag]);
    logInfo('Tag "$tag" added');
  } catch (e) {
    logError('Could not create tag "$tag". Already exists?');
  }
}

ResultSet fetchAllTags(){
  String query = 'SELECT id, tag FROM tags;';
  return executeQuery(query);
}

void deleteTagById(int id){
  String operation = 'DELETE FROM tags WHERE id=?';
  try {
    executeDatabaseOperation(operation, [id]);
    logInfo('Tag deleted succesfully');
  } catch (e) {
    logError('Could not delete the tag');
  }
}