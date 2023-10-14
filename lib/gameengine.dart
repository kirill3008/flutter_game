import 'dart:ffi';

import 'data.dart' as data;
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GameController extends Object {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int gameState = 0;
  int budget = 10;
  bool choice = true;
  bool gameOver = false;
  List<List<int>> enviroment = data.enviroment;
  List<List<int>> production = data.production;
  List<List<int>> damage = data.damage;
  List<List<int>> education = data.education;
  List<List<int>> qualityoflife = data.qualityoflife;
  List<List<int>> populationadd = data.populationadd;
  List<List<int>> population = data.population;
  List<List<int>> policy = data.policy;
  Map<String, List<List<int>>> tosnake = {};
  List<String> onScreen = ["", ""];
  Map<String, int> currentPos = {
    "enviroment": 0,
    "production": 11,
    "damage": 12,
    "education": 7,
    "qualityoflife": 9,
    "populationadd": 19,
    "population": 20,
    "policy": 10
  };
  Map<String, int> prevPos = {
    "enviroment": 0,
    "production": 11,
    "damage": 12,
    "education": 7,
    "qualityoflife": 9,
    "populationadd": 19,
    "population": 20,
    "policy": 10
  };
  Map<String, int> snakeSize = {
    "enviroment": 29,
    "production": 29,
    "damage": 29,
    "education": 29,
    "qualityoflife": 29,
    "populationadd": 29,
    "population": 48,
    "policy": 48
  };
  Map<String, List<String>> nameToColor = {
    "enviroment": ["blue", "red"],
    "production": ["red", "black", "blue", "green"],
    "damage": ["red", "blue"],
    "education": ["red", "green", "blue"],
    "qualityoflife": ["red", "blue", "green", "black"],
    "populationadd": ["red"],
    "population": ["red", "black", "blue"],
    "policy": ["blue", "black"]
  };
  GameController() {
    tosnake = {
      "enviroment": enviroment,
      "production": production,
      "damage": damage,
      "education": education,
      "qualityoflife": qualityoflife,
      "populationadd": populationadd,
      "population": population,
      "policy": policy
    };
    Future<bool> status = initDropbox();
  }

  Future<bool> initDropbox() async {
    await Dropbox.init(data.dropboxClientId, data.dropboxKey, data.dropboxSecret);
    final SharedPreferences prefs = await _prefs;
    String? accessToken = prefs.getString('ecopoly_token');
    var result = [];
    if (accessToken != null) {
      await Dropbox.authorizeWithAccessToken(accessToken);
      result = await Dropbox.listFolder('');
    }
    if (accessToken == null || result.isEmpty) {
      var auth = 'Basic ${base64Encode(utf8.encode("${data.dropboxKey}:${data.dropboxSecret}"))}';
      var httpPost = await http.post(Uri.parse("https://api.dropbox.com/oauth2/token"),
          headers: {"authorization": auth},
          body: {"grant_type": "refresh_token", "refresh_token": data.dropboxRefresh});
      var jsonPostResponse = jsonDecode(httpPost.body);
      accessToken = jsonPostResponse["access_token"]!;
      await Dropbox.authorizeWithAccessToken(accessToken!);
    }
    await Dropbox.authorizeWithAccessToken(accessToken);
    result = await Dropbox.listFolder('');
    if (result.isEmpty) {
      return false;
    }
    return true;
  }

  List<List<int>> generateMap(String name, int side) {
    if (snakeSize[name] == null) {
      return [];
    }
    List<List<int>> ans = [];
    int current = 0;
    int valToMark = 0;
    int oldVal = -1;
    if (side == 0) {
      valToMark = prevPos[name]!;
    } else {
      valToMark = currentPos[name]!;
      oldVal = prevPos[name]!;
    }
    if (snakeSize[name] == 29) {
      for (int i = 0; i < 9; i++) {
        if (i % 2 == 0) {
          //
          if (current + 4 < oldVal || current > oldVal) {
            ans.add([1, 1, 1, 1, 1]);
          } else {
            var tmp = [1, 1, 1, 1, 1];
            tmp[oldVal - current] = 3;
            ans.add(tmp);
          }
          if (current + 4 < valToMark || current > valToMark) {
          } else {
            ans[i][valToMark - current] = 2;
          }
          current += 5;
        } else if (i % 4 == 3) {
          if (current == oldVal) {
            ans.add([3, 0, 0, 0, 0]);
          } else {
            ans.add([1, 0, 0, 0, 0]);
          }
          if (current == valToMark) {
            ans[i][0] = 2;
          }
          current += 1;
        } else {
          if (current == oldVal) {
            ans.add([0, 0, 0, 0, 3]);
          } else {
            ans.add([0, 0, 0, 0, 1]);
          }
          if (current == valToMark) {
            ans[i][4] = 2;
          }
          current += 1;
        }
      }
    } else {
      for (int i = 0; i < 13; i++) {
        if (i % 2 == 0) {
          //
          if (current + 5 < oldVal || current > oldVal) {
            ans.add([1, 1, 1, 1, 1, 1]);
          } else {
            var tmp = [1, 1, 1, 1, 1, 1];
            tmp[oldVal - current] = 3;
            ans.add(tmp);
          }
          if (current + 5 < valToMark || current > valToMark) {
          } else {
            ans[i][valToMark - current] = 2;
          }
          current += 6;
        } else if (i % 4 == 3) {
          if (current == oldVal) {
            ans.add([3, 0, 0, 0, 0, 0]);
          } else {
            ans.add([1, 0, 0, 0, 0, 0]);
          }
          if (current == valToMark) {
            ans[i][0] = 2;
          }
          current += 1;
        } else {
          if (current == oldVal) {
            ans.add([0, 0, 0, 0, 0, 3]);
          } else {
            ans.add([0, 0, 0, 0, 0, 1]);
          }
          if (current == valToMark) {
            ans[i][5] = 2;
          }
          current += 1;
        }
      }
    }
    return ans;
  }

  void makeMove() {
    switch (gameState) {
      //принимайте решение
      case 0:
        {
          onScreen = ["", ""];
        }
        break;
      //Влияние на состояние окружающей среды
      case 1:
        {
          onScreen = ["enviroment", "damage"];
          prevPos["damage"] = currentPos["damage"]!;
          currentPos["damage"] = max(currentPos["damage"]! - tosnake["enviroment"]![currentPos["enviroment"]!][0], 0);
        }
        break;
      //Амортизация средств очистки
      case 2:
        {
          onScreen = ["enviroment", "enviroment"];
          prevPos["enviroment"] = currentPos["enviroment"]!;
          currentPos["enviroment"] =
              min(currentPos["enviroment"]! + tosnake["enviroment"]![currentPos["enviroment"]!][1], 28);
        }
        break;
      //саморазвитие производства
      case 3:
        {
          onScreen = ["production", "production"];
          prevPos["production"] = currentPos["production"]!;
          currentPos["production"] =
              min(currentPos["production"]! + tosnake["production"]![currentPos["production"]!][0], 28);
        }
        break;
      //Влияние на среду
      case 4:
        {
          onScreen = ["production", "damage"];
          prevPos["damage"] = currentPos["damage"]!;
          currentPos["damage"] = min(currentPos["damage"]! + tosnake["production"]![currentPos["production"]!][2], 28);
        }
        break;
      //самоочищение среды
      case 5:
        {
          onScreen = ["damage", "damage"];
          prevPos["damage"] = currentPos["damage"]!;
          currentPos["damage"] = max(currentPos["damage"]! - tosnake["damage"]![currentPos["damage"]!][0], 0);
        }
        break;
      //Влияние на качество жизни
      case 6:
        {
          onScreen = ["damage", "qualityoflife"];
          prevPos["qualityoflife"] = currentPos["qualityoflife"]!;
          currentPos["qualityoflife"] =
              max(currentPos["qualityoflife"]! - tosnake["damage"]![currentPos["damage"]!][1], 0);
        }
        break;
      //Саморазвитие в блоке просвещение
      case 7:
        {
          onScreen = ["education", "education"];
          prevPos["education"] = currentPos["education"]!;
          currentPos["education"] =
              max(currentPos["education"]! - tosnake["education"]![currentPos["education"]!][1], 0);
        }
        break;
      //Влияние на качество жизни
      case 8:
        {
          onScreen = ["education", "qualityoflife"];
          prevPos["qualityoflife"] = currentPos["qualityoflife"]!;
          currentPos["qualityoflife"] =
              min(max(currentPos["qualityoflife"]! - tosnake["education"]![currentPos["education"]!][2], 0), 28);
        }
        break;
      //Влияние на прирост населения
      case 9:
        {
          onScreen = ["education", "populationadd"];
          prevPos["populationadd"] = currentPos["populationadd"]!;
          if (choice) {
            currentPos["populationadd"] =
                min(max(currentPos["populationadd"]! + tosnake["education"]![currentPos["education"]!][1], 0), 28);
          } else {
            currentPos["populationadd"] =
                min(max(currentPos["populationadd"]! - tosnake["education"]![currentPos["education"]!][1], 0), 28);
          }
        }
        break;
      //Саморзвитие качества жизни
      case 10:
        {
          onScreen = ["qualityoflife", "qualityoflife"];
          prevPos["qualityoflife"] = currentPos["qualityoflife"]!;
          currentPos["qualityoflife"] = min(
              max(currentPos["qualityoflife"]! + tosnake["qualityoflife"]![currentPos["qualityoflife"]!][0], 0), 28);
        }
        break;
      //Влияние на прирост населения
      case 11:
        {
          onScreen = ["qualityoflife", "populationadd"];
          prevPos["populationadd"] = currentPos["populationadd"]!;
          currentPos["populationadd"] = min(
              max(currentPos["populationadd"]! + tosnake["qualityoflife"]![currentPos["qualityoflife"]!][1], 0), 28);
        }
        break;
      //развитие населения
      case 12:
        {
          onScreen = ["populationadd", "population"];
          prevPos["population"] = currentPos["population"]!;
          currentPos["population"] = min(
              max(
                  currentPos["populationadd"]! +
                      tosnake["populationadd"]![currentPos["populationadd"]!][0] *
                          tosnake["population"]![currentPos["population"]!][0],
                  0),
              47);
        }
        break;
      //влияние на качество жизни
      case 13:
        {
          onScreen = ["population", "qualityoflife"];
          prevPos["qualityoflife"] = currentPos["qualityoflife"]!;
          currentPos["qualityoflife"] =
              min(max(currentPos["qualityoflife"]! + tosnake["population"]![currentPos["population"]!][2], 0), 28);
        }
        break;
      //влияние на политику
      case 14:
        {
          onScreen = ["qualityoflife", "policy"];
          prevPos["policy"] = currentPos["policy"]!;
          currentPos["policy"] =
              min(max(currentPos["policy"]! + tosnake["qualityoflife"]![currentPos["qualityoflife"]!][2], 0), 47);
        }
        budget += (tosnake["production"]![currentPos["production"]!][1] +
            tosnake["population"]![currentPos["population"]!][1] +
            tosnake["qualityoflife"]![currentPos["qualityoflife"]!][3] +
            tosnake["policy"]![currentPos["policy"]!][1]);
        break;
      //something went wrong, shouldn't be here
      default:
        {}
        break;
    }
    if (currentPos["policy"] == 0) {
      gameOver = true;
    }
  }
}
