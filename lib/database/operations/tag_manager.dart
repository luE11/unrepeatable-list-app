import 'package:sqlite3/sqlite3.dart';

import '../dbmanage.dart';
import '../../components/uilogger.dart';
import './item_manager.dart' show getByTagId;

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
  ResultSet itemsTag = getByTagId(id);
  if(itemsTag.isEmpty){
    String operation = 'DELETE FROM tags WHERE id=?';
    try {
      executeDatabaseOperation(operation, [id]);
      logInfo('Tag deleted succesfully');
    } catch (e) {
      logError('Could not delete the tag');
    }
  }else {
    logError('Could not delete the tag. There are ${itemsTag.length} items using it');
  }
}