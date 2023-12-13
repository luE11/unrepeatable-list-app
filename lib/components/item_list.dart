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
  final List<String> headers = List.from(['Concepts', 'Description', 'Tag']);
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
      child: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30),
                child: Row(
                  children: [
                    Text(
                      '${_items.length} Items recorded',
                      textAlign: TextAlign.left,
                      style: widget.appTheme!.textTheme.headlineLarge?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.symmetric(
                    inside: const BorderSide(width: 0.4, color: Colors.black),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(1.6),
                    1: FlexColumnWidth(4),
                    2: FlexColumnWidth(1.6),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      children: headers.map<TableCell>((String header) {
                        return TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              header,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        );
                      }).toList()
                    ),
                    ...(_items.map<TableRow>((Item item) {
                        return TableRow(
                          children: [
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item.concept),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item.description),
                              ),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.tag!=null ? item.tag!.tag : '',
                                ),
                              ),
                            ),
                          ]
                        );
                    }).toList()),
                  ],
                ),
              ),
            ),
          ]
          ),
      ),
    );
  }
  
}