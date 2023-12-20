import 'package:flutter/material.dart';
import 'modals/create_tag_modal.dart';
import 'modals/delete_tag_modal.dart';
import 'modals/create_item_modal.dart';
import 'modals/edit_consult_item_modal.dart';
import 'modals/delete_item_modal.dart';

void showModal(BuildContext context, Widget modal, [BoxConstraints? constraints]){
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return modal;
    },
    constraints: constraints,
    isScrollControlled: true,
  );
}

void showCreateTagModal(BuildContext context, ThemeData? themeData, ButtonStyle? btnStyle){
  showModal(context, CreateTagModal(themeData: themeData, btnStyle: btnStyle));
}

void showDeleteTagModal(BuildContext context, ThemeData? themeData, ButtonStyle? btnStyle){
  showModal(context, DeleteTagModal(themeData: themeData, btnStyle: btnStyle));
}

void showCreateItemModal(BuildContext context, ThemeData themeData, ButtonStyle btnStyle, Function onCreate){
  showModal(context, CreateItemModal(themeData: themeData, btnStyle: btnStyle, onCreate: onCreate));
}

void showEditConsultItemModal(BuildContext context, ThemeData themeData, ButtonStyle btnStyle, Function onEdit, int itemId){
  showModal(context, EditConsultItemModal(themeData: themeData, btnStyle: btnStyle, onEdit: onEdit, itemId: itemId,));
}

void showDeleteItemModal(BuildContext context, ThemeData themeData, ButtonStyle btnStyle, int itemId){
  showModal(context, DeleteItemModal(themeData: themeData, btnStyle: btnStyle, itemId: itemId,));
}