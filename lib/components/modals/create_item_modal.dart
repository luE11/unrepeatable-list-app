import 'package:flutter/material.dart';
import '../../database/model/item.model.dart';
import '../../database/model/tag.model.dart';
import '../../services/tag_service.dart' show getAllTags;
import '../../services/item_service.dart' show createItem;

class CreateItemModal extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ThemeData? themeData;
  final ButtonStyle? btnStyle;

  CreateItemModal({super.key, this.themeData, this.btnStyle});

  @override
  Widget build(BuildContext context) {
    List<Tag> tags = getAllTags();

    Item model = Item('', '');
    Tag? itemTag;

    return Container(
      padding: const EdgeInsets.all(50),
      child: Wrap(
        verticalDirection: VerticalDirection.up,
          children: [Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Creating a new item',
                style: themeData?.textTheme.headlineLarge?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter new item concept',
                  alignLabelWithHint: true
                ),
                maxLength: 30,
                autofocus: true,
                textAlign: TextAlign.center,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter concept description',
                  alignLabelWithHint: true
                ),
                maxLength: 200,
                autofocus: true,
                maxLines: null,
                textAlign: TextAlign.justify,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              DropdownMenu<Tag>(
                label: Text('Select a tag'),
                onSelected: (Tag? changed) { 
                  itemTag = changed!;
                },
                dropdownMenuEntries: tags.map<DropdownMenuEntry<Tag>>((Tag tag) {
                  return DropdownMenuEntry<Tag>(value: tag, label: tag.tag);
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      //createTag(tagController.text);
                      Navigator.pop(context);
                    }
                  },
                  style: btnStyle?.copyWith(
                    backgroundColor: MaterialStatePropertyAll(themeData?.colorScheme.primary),
                  ),
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        )],
      ),
    );
  }
}