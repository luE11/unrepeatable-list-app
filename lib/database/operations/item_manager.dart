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