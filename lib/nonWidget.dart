import 'dart:io';
import 'package:filepicker_windows/filepicker_windows.dart';

File getGamePath (String game){
  File pathFile = File('path.txt');
  List<String> games = pathFile.readAsLinesSync();
  for (String line in games){
    List<String> sLine = line.split("=");
    if (sLine[0].toLowerCase().trimRight() == game.toLowerCase()){
      return File(sLine[1].trimLeft());
    }
  }
  return null;
}

void setGamePath (String game, String path){
  File pathFile = File('path.txt');
  List<String> games = pathFile.readAsLinesSync();
  String endFile = "";
  for (String line in games){
    List<String> sLine = line.split("=");
    if (sLine[0].toLowerCase().trimRight() == game.toLowerCase()){
      sLine[1] = " " + path;
    }
    endFile += sLine.join("=") + "\n";
  }
  pathFile.writeAsStringSync(endFile);
}

void changeGamePath (String game) {
  String gameExe;
  switch (game.toLowerCase()){
    case "league":
      gameExe = "LeagueClient";
      break;
    case "runeterra":
      gameExe = "LoR";
      break;
  }
      
  final path = OpenFilePicker()
    ..filterSpecification = { gameExe + '.exe': gameExe + '.exe' }
    ..defaultFilterIndex = 0
    ..defaultExtension = 'exe'
    ..fileMustExist = true
    ..title = 'Select ' + gameExe + '.exe';

  final result = path.getFile();
  if (result != null){
    setGamePath(game, result.path);
  }
}

void runGame (String game, List<String> args){
  File file = getGamePath(game);
  Process.run(file.path, args);
}