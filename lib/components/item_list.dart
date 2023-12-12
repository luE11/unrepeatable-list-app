import 'package:flutter/material.dart';
import '../database/model/item.model.dart';
import '../services/item_service.dart';
import 'package:eventify/eventify.dart';

final EventEmitter emitter = new EventEmitter();


class ItemList extends StatefulWidget {
  const ItemList(this.appTheme, this.btnStyle, this.menuItemStyle, {super.key});
  final ThemeData? appTheme;
  final ButtonStyle? btnStyle;
  final ButtonStyle? menuItemStyle;

  refreshList() {
    emitter.emit("refreshList");
  }
  
  @override
  State<ItemList> createState() => _ItemListState();

}

class _ItemListState extends State<ItemList> {
  final List<String> headers = List.from(['concepts', 'description', 'tag']);
  List<Item> _items = getAllItems();

  @override
  void initState() {
    super.initState();
    emitter.on('refreshList', null, (event, eventContext) {
      setState(() {
        _items = getAllItems();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'Items ${_items.length}',
              style: widget.appTheme!.textTheme.headlineLarge?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: headers.map<TableCell>((String header) {
                  return TableCell(child: Text(header));
                }).toList()
              ),
              ...(_items.map<TableRow>((Item item) {
                  return TableRow(
                    children: [
                      TableCell(
                        child: Text(item.concept),
                      ),
                      TableCell(
                        child: Text(item.description),
                      ),
                      TableCell(
                        child: Text(
                          item.tag!=null ? item.tag!.tag : '',
                        ),
                      ),
                    ]
                  );
              }).toList()),
            ],
          ),
        ]
        ),
    );
  }
  
}