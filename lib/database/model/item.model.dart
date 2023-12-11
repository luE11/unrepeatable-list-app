// ignore_for_file: unnecessary_getters_setters

import 'tag.model.dart';

class Item {
  int? _id;
  String _concept;
  String _description;
  Tag? _tag;
  
  Item(this._concept, this._description);

  int? get id => _id;
  String get concept => _concept;
  String get description => _description;
  Tag? get tag => _tag;

  set concept(String concept) => _concept = concept;
  set description(String description) => _description = description;
  set tag(Tag? tag) => _tag = tag;

  @override
  String toString() {
    return 'Item{id: $_id, concept: $_concept}';
  }
}