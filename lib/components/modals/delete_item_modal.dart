import 'package:flutter/material.dart';
import '../../database/model/item.model.dart';
import '../../services/item_service.dart' show getItemById, deleteItem;

class DeleteItemModal extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ThemeData? themeData;
  final ButtonStyle? btnStyle;
  final Function onDelete;
  final int itemId;

  DeleteItemModal({super.key, this.themeData, this.btnStyle, required this.itemId, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    Item? item = getItemById(itemId);
    return Container(
      height: 150,
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.delete_sweep_rounded,
                color: Colors.redAccent,
                size: 40,
              ),
              title: const Text('Delete item confirmation'),
              subtitle: Text('You\'re about to delete concept: "${item!.concept}"'),
              visualDensity: VisualDensity.comfortable,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: btnStyle!.copyWith(
                    backgroundColor: const MaterialStatePropertyAll(Colors.red),
                  ),
                  onPressed: () {
                    deleteItem(item.id!);
                    onDelete();
                    Navigator.pop(context);
                  },
                  child: const Text('Delete item'),
                ),
                ElevatedButton(
                  style: btnStyle!.copyWith(
                    backgroundColor: const MaterialStatePropertyAll(Colors.lightBlue),
                    foregroundColor: const MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}