import 'package:flutter/material.dart';
import '../database/operations/tag_manager.dart' show createTag;
import 'modals/create_tag_modal.dart';
import 'modals/delete_tag_modal.dart';

void showCreateTagModal(BuildContext context, ThemeData? themeData){
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return CreateTagModal(themeData: themeData);
    },
  );
}

void showDeleteTagModal(BuildContext context, ThemeData? themeData){
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return DeleteTagModal(themeData: themeData);
    },
  );
}