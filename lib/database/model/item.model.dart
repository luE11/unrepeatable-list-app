import 'tag.model.dart';

class Item {
  final int _id;
  final String _concept;
  final String _description;
  final Tag? _tag;

  Item(this._id, this._concept, this._description, this._tag);

  int get id => _id;
  String get concept => _concept;
  String get description => _description;
  Tag? get tag => _tag;

  @override
  String toString() {
    return 'Item{id: $_id, concept: $_concept}';
  }
}