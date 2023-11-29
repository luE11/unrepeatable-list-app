import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'components/navbar.dart';
import 'database/dbmanage.dart';
import 'components/uilogger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowTitle("Unrepeteable list app");
  runApp(const MyApp());
  initSqlite();
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
      scaffoldMessengerKey: snackbarKey,
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
      appBar: AppNavBar(
        appTheme,
        appTitle,
        btnStyle,
        menuItemStyle
      ),
      body: const Center(
        child: Placeholder()
      ),
    );
  }
}
