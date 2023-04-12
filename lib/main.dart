import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'gameengine.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  GameController gm = GameController();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenu(),
        '/page': (context) => Page(gm: gm),
        '/selecter': (context) => BallanceIncome(gm: gm)
      },
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Expanded(child: Text("Main menu will be later")),
        Expanded(
            child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/selecter');
          },
          child: const Text("Next page"),
        ))
      ]),
    );
  }
}

class Cell extends StatelessWidget {
  final List<String> colors;
  final List<int> values;
  const Cell({super.key, required this.colors, required this.values});
  @override
  Widget build(BuildContext context) {
    Map<String, Color> conversion = {
      "red": Colors.red,
      "green": Colors.green,
      "blue": Colors.blue,
      "black": Colors.black
    };
    if (colors.length == 1) {
      return Text(
        values[0].toString(),
        style: TextStyle(color: conversion[colors[0]], fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );
    } else if (colors.length == 2) {
      return Row(
        children: [
          const SizedBox(width: 5),
          Expanded(
              child: Text(
            values[0].toString(),
            style: TextStyle(color: conversion[colors[0]], fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )),
          Expanded(
              child: Text(
            values[1].toString(),
            style: TextStyle(color: conversion[colors[1]], fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )),
          const SizedBox(width: 5),
        ],
      );
    } else if (colors.length == 3) {
      return Column(children: [
        Expanded(
            child: Row(
          children: [
            const SizedBox(width: 5),
            Expanded(
                child: Text(
              values[0].toString(),
              style: TextStyle(color: conversion[colors[0]], fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            Expanded(
                child: Text(
              values[1].toString(),
              style: TextStyle(color: conversion[colors[1]], fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            const SizedBox(width: 5),
          ],
        )),
        Expanded(
            child: Text(
          values[2].toString(),
          style: TextStyle(color: conversion[colors[2]], fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
      ]);
    } else {
      return Column(
        children: [
          Expanded(
              child: Row(
            children: [
              const SizedBox(width: 5),
              Expanded(
                  child: Text(
                values[0].toString(),
                style: TextStyle(color: conversion[colors[0]], fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                values[1].toString(),
                style: TextStyle(color: conversion[colors[1]], fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
              const SizedBox(width: 5),
            ],
          )),
          Expanded(
              child: Row(
            children: [
              const SizedBox(width: 5),
              Expanded(
                  child: Text(
                values[2].toString(),
                style: TextStyle(color: conversion[colors[2]], fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                values[3].toString(),
                style: TextStyle(color: conversion[colors[3]], fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
              const SizedBox(width: 5),
            ],
          )),
        ],
      );
    }
  }
}

class Snake extends StatefulWidget {
  final GameController gm;
  final int side;
  //final List<List<int>>? map;
  const Snake({super.key, required this.gm, required this.side});

  @override
  State<Snake> createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> colorMap = {1: Colors.white, 2: Colors.green, 3: Colors.red};
    String name = widget.gm.onScreen[widget.side];
    if (name == "") {
      return Column(
        children: const [],
      );
    }
    var map = widget.gm.generateMap(name, widget.side);
    List<Widget> result = [];
    int t = 0;
    for (var i = 0; i < map.length; i++) {
      List<Widget> tmp = [];
      for (var j = 0; j < map[i].length; j++) {
        if (map[i][j] != 0) {
          tmp.add(Expanded(
              child: Stack(alignment: Alignment.center, children: [
            Container(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            )),
            Cell(colors: widget.gm.nameToColor[name]!, values: widget.gm.tosnake[name]![t]),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 5, color: colorMap[map[i][j]] as Color))),
          ])));
          t += 1;
        } else {
          tmp.add(const Expanded(child: Text("")));
        }
      }
      result.add(Expanded(
          child: Row(
        children: tmp,
      )));
    }
    return Column(
      children: result,
    );
  }
}

class Page extends StatefulWidget {
  GameController gm;
  Page({super.key, required this.gm});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    var snake1 = Snake(
      gm: widget.gm,
      side: 0,
    );
    var snake2 = Snake(
      gm: widget.gm,
      side: 1,
    );
    return Scaffold(
        backgroundColor: Colors.brown,
        body: Center(
            child: Column(children: [
          const SizedBox(height: 20),
          Expanded(
              child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(child: snake1),
              Expanded(
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(
                  "${widget.gm.onScreen[0]} -> ${widget.gm.onScreen[1]}",
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    onPressed: () {
                      widget.gm.gameState += 1;
                      widget.gm.gameState %= 15;
                      widget.gm.makeMove();
                      if (widget.gm.gameOver) {
                        Navigator.pushNamed(context, "/");
                      }
                      if (widget.gm.gameState == 0) {
                        Navigator.pushNamed(context, "/selecter");
                      }
                      setState(() {});
                    },
                    child: const Text("Next Page"))
              ])),
              const SizedBox(width: 20),
              Expanded(child: snake2),
              const SizedBox(width: 20),
            ],
          )),
          const SizedBox(height: 20),
        ])));
  }
}

class BallanceIncome extends StatefulWidget {
  GameController gm;
  BallanceIncome({super.key, required this.gm});

  @override
  State<BallanceIncome> createState() => _BallanceIncomeState();
}

class _BallanceIncomeState extends State<BallanceIncome> {
  @override
  Widget build(BuildContext context) {
    int a = 0;
    return Scaffold(
        backgroundColor: Colors.brown,
        body: Center(
            child: Row(children: [
          const SizedBox(
            width: 40,
          ),
          Expanded(
              child: Column(
            children: [
              Expanded(
                  child: Row(children: [
                ElevatedButton(
                  child: const Text("dec"),
                  onPressed: () {
                    a += 1;
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "production",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  child: const Text("dec"),
                  onPressed: () {
                    a -= 1;
                  },
                ),
              ])),
              Expanded(
                  child: Row(children: [
                ElevatedButton(
                  child: const Text("dec"),
                  onPressed: () {
                    a += 1;
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "production",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  child: const Text("dec"),
                  onPressed: () {
                    a -= 1;
                  },
                ),
              ])),
              Expanded(
                  child: Row(children: [
                ElevatedButton(
                  child: const Text("dec"),
                  onPressed: () {
                    a += 1;
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "production",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  child: const Text("dec"),
                  onPressed: () {
                    a -= 1;
                  },
                ),
              ])),
              Expanded(
                  child: Row(children: [
                ElevatedButton(
                  child: const Text("dec"),
                  onPressed: () {
                    a += 1;
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "production",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  child: const Text("dec"),
                  onPressed: () {
                    a -= 1;
                  },
                ),
              ])),
              Expanded(
                  child: Row(children: [
                ElevatedButton(
                  child: const Text("dec"),
                  onPressed: () {
                    a += 1;
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "production",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  child: const Text("dec"),
                  onPressed: () {
                    a -= 1;
                  },
                ),
              ])),
            ],
          )),
          ElevatedButton(
              onPressed: () {
                widget.gm.gameState += 1;
                widget.gm.makeMove();
                Navigator.pushNamed(context, "/page");
              },
              child: const Text("Confirm")),
          const SizedBox(
            width: 20,
          )
        ])));
  }
}
