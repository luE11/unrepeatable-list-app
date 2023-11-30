import 'package:flutter/material.dart';
import '../../services/tag_service.dart' show createTag;

class CreateTagModal extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ThemeData? themeData;
  final ButtonStyle? btnStyle;
  final tagController = TextEditingController();

  CreateTagModal({super.key, this.themeData, this.btnStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        padding: const EdgeInsets.all(50),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Creating a new tag',
                style: themeData?.textTheme.headlineLarge?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter new tag name',
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
                controller: tagController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      createTag(tagController.text);
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
        ),
      );
  }
}