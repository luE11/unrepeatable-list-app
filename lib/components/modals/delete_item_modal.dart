import 'package:flutter/material.dart';
import '../../database/model/item.model.dart';
import '../../services/item_service.dart' show getItemById;

class DeleteItemModal extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ThemeData? themeData;
  final ButtonStyle? btnStyle;
  final int itemId;

  DeleteItemModal({super.key, this.themeData, this.btnStyle, required this.itemId});

  @override
  Widget build(BuildContext context) {
    Item? item = getItemById(itemId);
    return Container(
      height: 150,
      padding: const EdgeInsets.all(10), // Center?
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  child: const Text('Delete item'),
                  onPressed: () {
      
                  },
                ),
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}