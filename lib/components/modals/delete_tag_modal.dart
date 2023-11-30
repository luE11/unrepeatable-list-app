import 'package:flutter/material.dart';
import '../../database/model/tag.model.dart';
import '../../services/tag_service.dart' show getAllTags, deleteTagById;

class DeleteTagModal extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ThemeData? themeData;
  final ButtonStyle? btnStyle;
  final tagController = TextEditingController();

  DeleteTagModal({super.key, this.themeData, this.btnStyle});

  @override
  Widget build(BuildContext context) {
    List<Tag> list = getAllTags();

    if(list.isEmpty){
      return Container(
        height: 200,
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Text(
              'Tags not found',
              style: themeData?.textTheme.headlineLarge?.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: btnStyle?.copyWith(
                backgroundColor: MaterialStatePropertyAll(themeData?.colorScheme.primary),
              ),
              child: const Text('Close'))
          ],
        ),
      );
    }

    Tag selected = list.first;

    return Container(
        height: 300,
        width: 500,
        padding: const EdgeInsets.all(50),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Deleting tag',
                style: themeData?.textTheme.headlineLarge?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              DropdownMenu<Tag>(
                initialSelection: list.first,
                onSelected: (Tag? changed) { 
                  selected = changed!;
                },
                dropdownMenuEntries: list.map<DropdownMenuEntry<Tag>>((Tag tag) {
                  return DropdownMenuEntry<Tag>(value: tag, label: tag.tag);
                }).toList(),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      deleteTagById(selected.id);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Delete selection'),
                ),
              ),
            ],
          ),
        ),
      );
  }
}