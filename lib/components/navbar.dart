import 'package:flutter/material.dart';
import 'uilogger.dart';
import 'modal_manager.dart';
import '../database/sqlite_file_manager.dart' show restoreSqliteData;
import 'dialog_manager.dart' as dialog_manager;

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavBar(this.appTheme, this.appTitle, this.btnStyle, this.menuItemStyle, this.updateItemsList, {super.key});
  final ThemeData? appTheme;
  final String? appTitle;
  final ButtonStyle? btnStyle;
  final ButtonStyle? menuItemStyle;
  final Function updateItemsList;

  
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: appTheme?.colorScheme.background,
        title: Text(appTitle!),
        shape: const Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 218, 218, 218),
            width: 3
          )
        ),
        actions: [ 
          ElevatedButton(
            onPressed: () {
              showCreateItemModal(context, appTheme!, btnStyle!, updateItemsList);
            },
            style: btnStyle?.copyWith(
              backgroundColor: const MaterialStatePropertyAll(Colors.blue),
            ),
            child: const Text('Add Item'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ElevatedButton(
              onPressed: () {
                showCreateTagModal(context, appTheme, btnStyle);
              },
              style: btnStyle?.copyWith(
                backgroundColor: const MaterialStatePropertyAll(Colors.lightBlue),
              ),
              child: const Text('Add Tag'),
            ),
          ),
          MenuBar(
            style: const MenuStyle(
              shadowColor: MaterialStatePropertyAll(Colors.transparent),
              padding: MaterialStatePropertyAll(EdgeInsets.only(left: 0, right: 0)),
            ),
            children: [
              SubmenuButton(
                style: btnStyle?.copyWith( 
                  backgroundColor: MaterialStatePropertyAll(appTheme?.colorScheme.background),
                  foregroundColor: const MaterialStatePropertyAll(Colors.black),
                ),
                menuChildren: [ 
                  MenuItemButton(
                    onPressed: () {
                      logInfo("color");
                    },
                    style: menuItemStyle,
                    child: const Text("Change primary \ncolor"),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      showDeleteTagModal(context, appTheme, btnStyle);
                    },
                    style: menuItemStyle,
                    child: const Text("Delete tag")
                  ),
                  MenuItemButton(
                    onPressed: () {
                      logInfo("to csv");
                    },
                    style: menuItemStyle,
                    child: const Text("Export data to csv")
                  ),
                  MenuItemButton(
                    onPressed: () {
                      logInfo("to pdf");
                    },
                    style: menuItemStyle,
                    child: const Text("Export data to pdf")
                  ),
                  const Divider(height: 1,),
                  MenuItemButton(
                    onPressed: () {
                      dialog_manager.showAboutDialog(context);
                    },
                    style: menuItemStyle,
                    child: const Text("About")
                  ),
                  MenuItemButton(
                    onPressed: () {
                      restoreSqliteData();
                      updateItemsList();
                      logInfo("Data restore");
                    },
                    style: menuItemStyle?.copyWith(
                      backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 247, 156, 150)),
                    ),
                    child: const Text("Restore data")
                  ),
                ],
                trailingIcon: const Icon(Icons.keyboard_arrow_down),
                child: const Text('Options')
              ),
            ],
          ),
         ]
      );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}