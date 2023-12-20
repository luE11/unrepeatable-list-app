import 'package:sqlite3/sqlite3.dart';

import '../database/model/item.model.dart';
import '../database/model/tag.model.dart';
import '../database/operations/item_manager.dart' as manager;

void createItem(Item item){
  manager.createItem(item);
}

List<Item> getAllItems(){
  ResultSet rows = manager.fetchAllItems();
  if(rows.isEmpty) return [];
  Iterator<Row> rI = rows.iterator;
  return List<Item>.generate(rows.length, 
    (index) {
      rI.moveNext();
      Row current = rI.current;
      Tag? tag = current['t_id']==null
                ? null
                : Tag(current['t_id'], current['tag']);
      return Item.full(current['id'], current['concept'], current['description'], tag);
    });
}

Item? getItemById(int id){
  ResultSet result = manager.getItemById(id);
  if(result.isEmpty) return null;
  Row first = result.first;
  Tag? tag = first['t_id']==null
                ? null
                : Tag(first['t_id'], first['tag']);
  return Item.full(first['id'], first['concept'], first['description'], tag);
}

void editItem(Item item){
  manager.editItem(item);
}

void deleteItem(int itemId){
  manager.deleteItemById(itemId);
}