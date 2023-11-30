import 'package:flutter/material.dart';
import 'modals/create_tag_modal.dart';
import 'modals/delete_tag_modal.dart';

void showCreateTagModal(BuildContext context, ThemeData? themeData, ButtonStyle? btnStyle){
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return CreateTagModal(themeData: themeData, btnStyle: btnStyle);
    },
  );
}

void showDeleteTagModal(BuildContext context, ThemeData? themeData, ButtonStyle? btnStyle){
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return DeleteTagModal(themeData: themeData, btnStyle: btnStyle);
    },
  );
}