import 'package:sqlite3/sqlite3.dart';

import '../database/model/item.model.dart';
import '../database/model/tag.model.dart';
import '../database/operations/item_manager.dart' as manager;

void createItem(Item item){
  manager.createItem(item);
}

List<Item> getAllTags(){
  ResultSet rows = manager.fetchAllItems();
  Iterator<Row> rI = rows.iterator;
  return List<Item>.generate(rows.length, 
    (index) {
      rI.moveNext();
      Row current = rI.current;
      Tag tag = Tag(current['t_id'], current['tag']);
      return Item.full(current['id'], current['concept'], current['description'], tag);
    });
}