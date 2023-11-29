import '../dbmanage.dart' show executeDatabaseOperation;
import '../../components/uilogger.dart';

createTag(String tag){
  String operation = '''
    INSERT INTO tags (tag) VALUES (?)
  ''';
  try {
    executeDatabaseOperation(operation, [tag]);
    logInfo('Tag "$tag" added');
  } catch (e) {
    logInfo('Could not create tag "$tag". Already exists?');
  }
}