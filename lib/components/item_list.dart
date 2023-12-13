import 'package:flutter/material.dart';
import '../database/model/item.model.dart';
import '../services/item_service.dart';
import 'package:eventify/eventify.dart';

final EventEmitter emitter = new EventEmitter();

class ItemDataSource extends DataTableSource {
  List<Item> items;

  ItemDataSource(this.items);

  setData(List<Item> items){
    this.items = items;
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    Item current = items.elementAt(index);
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (bool? selected) {
        if(selected!){
          print('selected ${current.concept}');
        }
      },
      cells: <DataCell> [
        DataCell(Text(current.concept)),
        DataCell(
          Text(
            current.description.length <= 50
              ? current.description
              : '${current.description.substring(0, 50).trim()}...',
          )
        ),
        DataCell(
          Text(
            current.tag != null
              ? current.tag!.tag
              : ''
          )
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => items.length;

  @override
  int get selectedRowCount => 0;

}

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
  List<Item> items = getAllItems();
  late ItemDataSource dataSource = ItemDataSource(items);

  @override
  void initState() {
    super.initState();
    emitter.on('refreshList', null, (event, eventContext) {
      setState(() {
        items = getAllItems();
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: <Widget> [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30),
              child: Row(
                children: [
                  Text(
                    '${items.length} Items recorded',
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
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: PaginatedDataTable(
                columns: headers.map<DataColumn>((String header) {
                  return DataColumn(
                    label: Text(
                      header,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
                source: dataSource,
              ),
            ),
          ),
        ]
      ),
    );
  }
  
}