import 'package:sqlite3/sqlite3.dart';

import '../dbmanage.dart';
import '../../components/uilogger.dart';
import '../model/item.model.dart';

void createItem(Item item){
  String operation = '';
  try {
    operation = 'INSERT INTO items (concept, description, tag_id) VALUES (?,?,?)';
    executeDatabaseOperation(operation, 
      [
        item.concept,
        item.description,
        (item.tag!=null) ? item.tag!.id : null
      ]
    );
    logInfo('Concept "${item.concept}" added');
  } catch (e) {
    logError('Could not create concept "${item.concept}". Already exists?');
  }
}

ResultSet fetchAllItems(){
  String query = '''
    SELECT i.id, concept, description, t.id t_id, t.tag
      FROM items i
      LEFT JOIN tags t
      ON i.tag_id=t.id;
  ''';
  return executeQuery(query);
}

ResultSet fetchItemsFilter(String search){
  String query = '''
    SELECT i.id, concept, description, t.id t_id, t.tag
      FROM items i
      LEFT JOIN tags t
      ON i.tag_id=t.id
      WHERE concept LIKE ?;
  ''';
  return executeQuery(query, ['%$search%']);
}

ResultSet getByTagId(int tagId){
  String query = '''
    SELECT i.id, concept, description, t.id t_id, t.tag
      FROM items i, tags t
      WHERE i.tag_id=t.id
      AND t.id = ?;
  ''';
  return executeQuery(query, [tagId]);
}

ResultSet getItemById(int itemId){
  String query = '''
    SELECT i.id, concept, description, t.id t_id, t.tag
      FROM items i
      LEFT JOIN tags t
        ON i.tag_id=t.id
      WHERE i.id=?
      LIMIT 1;
  ''';
  return executeQuery(query, [itemId]);
}

void editItem(Item item){
  String operation = '''
    UPDATE items
      SET concept = ?, description = ?, tag_id = ?
    WHERE id = ?;
  ''';
  try {
    executeDatabaseOperation(operation,
      [
        item.concept,
        item.description,
        (item.tag!=null) ? item.tag!.id : null,
        item.id
      ]
    );
    logInfo('Concept "${item.concept}" updated');
  } catch (e) {
    logError('Could not update concept. Does "${item.concept}" item already exist?');
  }
}

void deleteItemById(int id){
  String operation = 'DELETE FROM items WHERE id=?';
  try {
    executeDatabaseOperation(operation, [id]);
    logInfo('Item deleted succesfully');
  } catch (e) {
    logError('Could not delete the item');
  }
}