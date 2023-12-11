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
    TextEditingController tagController = TextEditingController();

    Item model = Item('', '');

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
              const SizedBox(height: 20,),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter new item concept',
                  alignLabelWithHint: true,
                  labelText: 'Concept',
                  focusedBorder: OutlineInputBorder(),
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
                onChanged: (String? value) {
                  model.concept = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter concept description',
                  alignLabelWithHint: true,
                  labelText: 'Concept description',
                  focusedBorder: OutlineInputBorder(),
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
                onChanged: (String? value) {
                  model.description = value!;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownMenu<Tag>(
                    label: const Text('Select a tag'),
                    onSelected: (Tag? changed) { 
                      model.tag = changed;
                    },
                    controller: tagController,
                    hintText: 'Type to search',
                    dropdownMenuEntries: tags.map<DropdownMenuEntry<Tag>>((Tag tag) {
                      return DropdownMenuEntry<Tag>(value: tag, label: tag.tag);
                    }).toList(),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      model.tag = null;
                      tagController.clear();
                    },
                    style: btnStyle?.copyWith(
                      backgroundColor: MaterialStatePropertyAll(themeData?.colorScheme.error),
                      padding: const MaterialStatePropertyAll(EdgeInsets.fromLTRB(20, 15, 20, 15)),
                    ),
                    child: const Text('Clear tag'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      createItem(model);
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