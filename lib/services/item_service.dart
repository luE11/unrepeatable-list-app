import '../database/model/item.model.dart';
import '../database/operations/item_manager.dart' as manager;

void createItem(Item item){
  manager.createItem(item);
}