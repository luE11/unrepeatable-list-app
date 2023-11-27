import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowTitle("Unrepeteable list app");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unrepeteable list app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Sans-serif',
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String appTitle = "Unrepeteable List App";

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = Theme.of(context);
    ButtonStyle btnStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.fromLTRB(13, 15, 13, 15),
    );
    ButtonStyle menuItemStyle = ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(appTheme.colorScheme.background),
                      padding: const MaterialStatePropertyAll(EdgeInsets.fromLTRB(15, 15, 15, 15)),
                    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.colorScheme.background,
        title: Text(appTitle),
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
              print("Add item");
            },
            style: btnStyle.copyWith(
              backgroundColor: const MaterialStatePropertyAll(Colors.blue),
            ),
            child: const Text('Add Item'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Add tag to sqlite
                print("Add tag");
              },
              style: btnStyle.copyWith(
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
                style: btnStyle.copyWith( 
                  backgroundColor: MaterialStatePropertyAll(appTheme.colorScheme.background),
                  foregroundColor: const MaterialStatePropertyAll(Colors.black),
                ),
                menuChildren: [ 
                  MenuItemButton(
                    onPressed: () {
                      print("color");
                    },
                    style: menuItemStyle,
                    child: const Text("Change primary \ncolor"),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      print("to csv");
                    },
                    style: menuItemStyle,
                    child: const Text("Export data to csv")
                  ),
                  MenuItemButton(
                    onPressed: () {
                      print("to pdf");
                    },
                    style: menuItemStyle,
                    child: const Text("Export data to pdf")
                  ),
                  const Divider(height: 1,),
                  MenuItemButton(
                    onPressed: () {
                      print("about");
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
        
      ),
      body: const Center(
        child: Placeholder()
      ),
    );
  }
}
