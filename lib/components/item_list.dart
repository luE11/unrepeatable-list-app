import 'package:flutter/material.dart';
import '../database/model/item.model.dart';
import '../services/item_service.dart';
import 'package:eventify/eventify.dart';
import './modal_manager.dart' show showEditConsultItemModal, showDeleteItemModal;

final EventEmitter emitter = EventEmitter();

class ItemDataSource extends DataTableSource {
  List<Item> items;
  ThemeData? appTheme;
  ButtonStyle? btnStyle;
  ButtonStyle? menuItemStyle;
  BuildContext? context;

  ItemDataSource(this.items);

  setData(List<Item> items){
    this.items = items;
    notifyListeners();
  }

  setStyles(ThemeData appTheme, ButtonStyle btnStyle, ButtonStyle menuItemStyle){
    this.appTheme = appTheme;
    this.btnStyle = btnStyle;
    this.menuItemStyle = menuItemStyle;
  }

  setContext(BuildContext context){
    this.context = context;
  }

  @override
  DataRow? getRow(int index) {
    Item current = items.elementAt(index);
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (bool? selected) {
        if(selected!){
          showEditConsultItemModal(
            context!,
            appTheme!,
            btnStyle!,
            () {
              items = getAllItems();
              notifyListeners();
            },
            current.id!
          );
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
        DataCell(
          ElevatedButton(
            style: btnStyle!.copyWith(
              backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 255, 147, 139)),
            ),
            onPressed: () {
              showDeleteItemModal(
                context!,
                appTheme!,
                btnStyle!,
                () {
                  items = getAllItems();
                  notifyListeners();
                },
                current.id!
              );
            },
            child: const Icon(Icons.delete_outline, color: Colors.red),
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
  final List<String> headers = List.from(['Concepts', 'Description', 'Tag', 'Actions']);
  List<Item> items = getAllItems();
  late ItemDataSource dataSource = ItemDataSource(items);

  @override
  void initState() {
    super.initState();
    dataSource.setStyles(widget.appTheme!, widget.btnStyle!, widget.menuItemStyle!);
    emitter.on('refreshList', null, (event, eventContext) {
      setState(() {
        items = getAllItems();
      });
      dataSource.setData(items);
    });
  }

  @override
  Widget build(BuildContext context) {
    dataSource.setContext(context);
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
                showCheckboxColumn: false,
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