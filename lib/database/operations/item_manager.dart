import 'package:sqlite3/sqlite3.dart';

import '../dbmanage.dart';
import '../../components/uilogger.dart';
import '../model/item.model.dart';

void createItem(Item item){
  String operation = '';
  try {
    if(item.tag!=null){
      operation = 'INSERT INTO items (concept, description, tag_id) VALUES (?,?,?)';
      executeDatabaseOperation(operation, [item.concept, item.description, item.tag!.id]);
    }else {
      operation = 'INSERT INTO items (concept, description) VALUES (?,?)';
      executeDatabaseOperation(operation, [item.concept, item.description]);
    }
    logInfo('Concept "${item.concept}" added');
  } catch (e) {
    logError('Could not create concept "${item.concept}". Already exists?');
  }
}

ResultSet fetchAllItems(){
  String query = '''
    SELECT id, concept, description, t.id t_id, t.tag
      FROM items i, tags t
      WHERE i.tag_id=t.id;
  ''';
  return executeQuery(query);
}