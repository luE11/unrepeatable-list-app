import 'package:flutter/material.dart';
import 'uilogger.dart';

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavBar(this.appTheme, this.appTitle, this.btnStyle, this.menuItemStyle, {super.key});
  final ThemeData? appTheme;
  final String? appTitle;
  final ButtonStyle? btnStyle;
  final ButtonStyle? menuItemStyle;
  
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
              // TODO: Add item to sqlite
              logInfo("Add item");
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
                // TODO: Add tag to sqlite
                logInfo("Add tag");
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
                      logInfo("about");
                    },
                    style: menuItemStyle,
                    child: const Text("About")
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