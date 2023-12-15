import 'package:flutter/material.dart';
import '../../database/model/item.model.dart';
import '../../database/model/tag.model.dart';
import '../../services/tag_service.dart' show getAllTags;
import '../../services/item_service.dart' show getItemById, editItem;

class EditConsultItemModal extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ThemeData themeData;
  final ButtonStyle btnStyle;
  final int itemId;
  final Function onEdit;

  EditConsultItemModal({super.key, required this.themeData, required this.btnStyle, required this.onEdit, required this.itemId});
  
  @override
  State<StatefulWidget> createState() {
    return _EditConsultItemModalState();
  }
}

class _EditConsultItemModalState extends State<EditConsultItemModal> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    List<Tag> tags = getAllTags();
    TextEditingController tagController = TextEditingController();

    Item? model = getItemById(widget.itemId);

    Widget? content;

    if(isEditing){
      content = 
        Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Editing item with id: ${widget.itemId}',
                  style: widget.themeData.textTheme.headlineLarge?.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  initialValue: model!.concept,
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
                  initialValue: model.description,
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
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    DropdownMenu<Tag>(
                      label: const Text('Select a tag'),
                      onSelected: (Tag? changed) { 
                        model.tag = changed;
                      },
                      initialSelection: model.tag,
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
                      style: widget.btnStyle.copyWith(
                        backgroundColor: MaterialStatePropertyAll(widget.themeData.colorScheme.error),
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
                      if (widget.formKey.currentState!.validate()) {
                        editItem(model);
                        widget.onEdit();
                        Navigator.pop(context);
                      }
                    },
                    style: widget.btnStyle.copyWith(
                      backgroundColor: MaterialStatePropertyAll(widget.themeData.colorScheme.primary),
                    ),
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          );
    }else {
      content = 
        Container(
          child: Column(
            children: [ // Format consult content
              Text('Consulting xd'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isEditing = true;
                  });
                },
                child: Text('edit')
              )
            ],
          )
        );
    }

    return Container(
      padding: const EdgeInsets.all(50),
      child: Wrap(
        verticalDirection: VerticalDirection.up,
        children: [
          content
        ],
      ),
    );
  }

}