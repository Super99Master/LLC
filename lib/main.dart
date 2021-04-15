import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets.dart';
import 'nonWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp () : super(){}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LLC',
      home: Main(),
    );
  }
}

class Main extends StatelessWidget{
  final Lang lang = Lang();

  Main() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/bg.png"),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Logo(),
                LangDropButton(this.lang),
                Container(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      String title;
                      String content;
                      if (!getGamePath("league").existsSync()){
                        title = "Wrong Folder";
                        content = "Cannot find LoL, please update location by clicking the icon";
                      }
                      if (this.lang.code == null){
                        title = "Select a language";
                        content = "Select a language in the Dropdown list";
                      }
                      if (title != null && content != null){
                        showDialog(
                          context: context, 
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text(title),
                              content: Text(content),
                              actions: [TextButton(
                                child: Text("OK"),
                                onPressed: (){Navigator.of(context).pop();},
                              )],
                            );
                          }
                        );
                        return;
                      }
                      runGame("league",["--locale=" + this.lang.code]);
                    },
                    child: Text(
                      "Apply Language",
                      textAlign: TextAlign.left,
                    ),
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(BorderSide(width: 1.0, color: Color.fromARGB(255, 255, 170, 0))),
                      overlayColor: MaterialStateProperty.all<Color>(Color.fromARGB(200, 255, 170, 0)),
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(0, 255, 170, 0)),
                    ),
                  )
                )
              ],
            ),
          ),
          Container(
            width: 25,
            height: 25,
            child: IconButton(
              icon: Icon(
                Icons.help,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: (){launch("https://github.com/Super99Master/LLC#guide");}, //Todo
            ),
          ),
        ], 
      ),
      bottomNavigationBar: Container(
        height: 25,
        width: 300,
        color: Color.fromARGB(255, 25, 25, 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 25,
              //width: 50,
              child: TextButton(
                onPressed: (){launch("https://github.com/Super99Master/LLC");},
                child: Text(
                  "V1.0.0",
                  style: TextStyle(color: Colors.white24),
                ),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(Color.fromARGB(0, 0, 0, 0)),
                ),
              ),
            ),
            Container(
              height: 25,
              //width: 125,
              child: TextButton(
                onPressed: (){launch("https://github.com/Super99Master");},
                child: Text(
                  "@Super99Master",
                  style: TextStyle(color: Colors.white24),
                ),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(Color.fromARGB(0, 0, 0, 0)),
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}