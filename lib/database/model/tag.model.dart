class Tag {
  int _id;
  final String _tag;

  Tag(this._id, this._tag);

  Map<String, dynamic> toMap(){
    return {
      'id': _id,
      'tag': _tag
    };
  }

  int get id => _id;
  String get tag => _tag;

  @override
  String toString() {
    return 'Tag{id: $_id, tag: $_tag}';
  }
}