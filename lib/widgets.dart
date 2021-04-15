import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:desktop_window/desktop_window.dart';

import 'nonWidget.dart';
import 'dart:io';

class Lang{
  String code = "en_US";
}

class Logo extends StatefulWidget{
  final List<String> pathGif = ["assets/gif.gif","assets/gifError.gif"];

  Logo() : super();

  _Logo createState() => _Logo();
}

class _Logo extends State<Logo> with AfterLayoutMixin<Logo>{
  int index = 0;

  _Logo () : super (){
    updateIndex();
  }

  void updateIndex(){
    File path = getGamePath("league");
    index = path.existsSync() ? 0 : 1;
  }

  @override
  void afterFirstLayout(BuildContext context) async{
    await DesktopWindow.setWindowSize(Size(316,439));
    await DesktopWindow.setMinWindowSize(Size(316,439));
    await DesktopWindow.setMaxWindowSize(Size(316,439));
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: 150,
      height: 150,
      child: TextButton(
        child: Stack(
          children: [ 
            Container(
              padding: EdgeInsetsDirectional.only(top: 10),
              width: 135,
              height: 140,
              child: Image.asset(widget.pathGif[this.index]),
            ),            
            Image.asset("assets/lologoEmpty.png"),
          ],
        ),
        onPressed: (){
          changeGamePath("league");
          setState(() {
            updateIndex();
          });
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(Color.fromARGB(0, 0, 0, 0)),
        ),
      ),
    );
  }
}

class LangButton extends StatelessWidget{
  LangButton (this.lang, this.code) : super ();

  final String lang;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 50,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 5,),
          Image.asset(
            "assets/flags/" + this.code + ".png",
            width: 25,
            height: 25,
          ),
          Container(width: 15,),
          Text(
            this.lang,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}


class LangDropButton extends StatefulWidget{
  final Map<String, String> langDict = {
  "American": "en_US", "Australian": "en_AU", "Čeština": "cs_CZ", "Deutsch": "de_DE", "English": "en_GB",
  "Español": "es_ES", "Français": "fr_FR", "Italiano": "it_IT", "Magyar": "hu_HU", "Mexican": "es_MX",
  "Polski": "pl_PL", "Português": "pt_BR", "Română": "ro_RO", "Türkçe": "tr_TR", "Ελληνικά": "el_GR",
  "Русский": "ru_RU", "日本語": "ja_JP", "한국어": "ko_KR"};

  LangDropButton(this.lang) : super();

  final Lang lang;

  _LangDropButton createState() => _LangDropButton();
}

class _LangDropButton extends State<LangDropButton>{
  String lang = "American";

  _LangDropButton() : super();

  @override
  Widget build(BuildContext context){
    return Container(
      width: 150,
      height: 50,
      child: DropdownButton<String>(
        value: this.lang,
        items: widget.langDict.keys.map((lang) => DropdownMenuItem<String>(child: LangButton(lang,widget.langDict[lang]), value: lang)).toList(),
        dropdownColor: Color.fromARGB(255, 25, 25, 25),
        onChanged: (newValue) {
          setState(() {
            this.lang = newValue;
            widget.lang.code = widget.langDict[lang];
          });
        },
      ),
    );
  }
}