import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

void showAboutDialog(BuildContext context){
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('About unrepeteable app'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text('Simple app to create an unrepeteable list.'),
              const SizedBox(height: 10,),
              const Text('Developed by Luis Martínez'),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    launchUrlString("https://github.com/luE11");
                  },
                  child: const Text(
                    'Github @luE11',
                    style: TextStyle(
                      color: Color.fromARGB(255, 46, 161, 255),
                    ),
                  ),
                ),
              )
                
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}