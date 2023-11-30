import 'package:sqlite3/sqlite3.dart';

import '../database/model/tag.model.dart';
import '../database/operations/tag_manager.dart' as manager;

void createTag(String tag){
  manager.createTag(tag);
}

List<Tag> getAllTags(){
  ResultSet rows = manager.fetchAllTags();
  Iterator<Row> rI = rows.iterator;
  return List<Tag>.generate(rows.length, 
    (index) {
      rI.moveNext();
      Row current = rI.current;
      return Tag(current['id'], current['tag']);
    });
}

void deleteTagById(int id){
  manager.deleteTagById(id);
}
