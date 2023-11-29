class Tag {
  int id;
  final String tag;

  Tag({
    this.id = 0,
    required this.tag
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'tag': tag
    };
  }

  @override
  String toString() {
    return 'Tag{id: $id, tag: $tag}';
  }
}