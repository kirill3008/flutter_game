import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:dropbox_client/dropbox_client.dart';
//import 'package:path_provider/path_provider.dart';
//import 'dart:async';
//import 'dart:io';

const String dropboxClientId = 'boo';
const String dropboxKey = 's4but2m7b5dt9zf';
const String dropboxSecret = 'qcuogyb0l451z72';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, List<List<int>>> map = {
      0: [
        [1, 1, 1, 1, 1],
        [0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0],
        [1, 1, 2, 1, 1],
        [0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0],
        [1, 1, 1, 1, 1],
      ],
      1: [
        [2, 1, 1, 1, 1],
        [0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0],
        [1, 1, 1, 1, 1],
        [0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0],
        [1, 1, 1, 1, 1],
      ],
    };

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenu(),
        '/page1': (context) => Page(
            map1: map[0] as List<List<int>>,
            map2: map[1] as List<List<int>>,
            nextPage: "/page2"),
        '/page2': (context) => Page(
            map1: map[1] as List<List<int>>,
            map2: map[0] as List<List<int>>,
            nextPage: "/page1"),
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
            Navigator.pushNamed(context, '/page1');
          },
          child: const Text("Next page"),
        ))
      ]),
    );
  }
}

class Snake extends StatefulWidget {
  final List<List<int>> map;
  final int curField;
  final List<List<int>> idToFild = [
    [0, 0],
    [0, 1],
    [0, 2],
    [0, 3],
    [0, 4],
    [1, 4],
    [2, 4],
    [2, 3],
    [2, 2],
    [2, 1],
    [2, 0],
    [3, 0],
    [4, 0],
    [4, 1],
    [4, 2],
    [4, 3],
    [4, 4],
    [5, 4],
    [6, 4],
    [6, 3],
    [6, 2],
    [6, 1],
    [6, 0],
    [7, 0],
    [8, 0],
    [8, 1],
    [8, 2],
    [8, 3],
    [8, 4],
  ];
  Snake({super.key, this.map = const [], this.curField = 0});

  @override
  State<Snake> createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> colorMap = {1: Colors.white, 2: Colors.black};

    List<Widget> result = [];
    for (var i = 0; i < widget.map.length; i++) {
      List<Widget> tmp = [];
      for (var j = 0; j < widget.map[i].length; j++) {
        if (widget.map[i][j] != 0) {
          tmp.add(Expanded(
              child: Stack(alignment: Alignment.center, children: [
            Container(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            )),
            Text(
              "$i $j",
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 5, color: colorMap[widget.map[i][j]] as Color))),
          ])));
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
  final List<List<int>> map1;
  final List<List<int>> map2;
  final String nextPage;

  const Page(
      {super.key,
      this.map1 = const [],
      this.map2 = const [],
      this.nextPage = "/"});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  int curField1 = 0;
  int curField2 = 0;
  @override
  Widget build(BuildContext context) {
    var snake1 = Snake(
      map: widget.map1,
      curField: curField1,
    );
    var snake2 = Snake(
      map: widget.map2,
      curField: curField2,
    );
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Center(
          child: Row(
        children: [
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                const Text(
                  "Защита окружающей среды, рекреация, сохранение ландшафтов, экологически чистая энергетика, биотехнология, гуманизация производства",
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, widget.nextPage);
                    },
                    child: const Text("Xyu"))
              ])),
          const SizedBox(width: 20),
          Expanded(child: snake1),
          const SizedBox(width: 20),
          Expanded(child: snake2),
        ],
      )),
      /*
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          if (curField1 + 1 < snake1.idToFild.length) {
            widget.map1[snake1.idToFild[curField1][0]]
                [snake1.idToFild[curField1][1]] = 1;
            curField1 += 1;
            widget.map1[snake1.idToFild[curField1][0]]
                [snake1.idToFild[curField1][1]] = 2;
          }
        });
      }),
      */
    );
  }
}





/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late int _counter = 0;
  final TextEditingController _controllerT = TextEditingController();
  final TextEditingController _controllerF = TextEditingController();

  String accessToken =
      "sl.BUQ92N2EpfUjsN-yAtSJuuvVslq5qXnyyMRUOzHT16ZZUPfTAS60BjIP2pyI6S_Qa8qmvuqO57U-EEBAP6Tc-7JHWNDI2Ltes2U8ESH3rFAR_CBeR0hmwFzJEXxK1hHnPQ7ZWHk";
  bool showInstruction = false;

  @override
  void initState() {
    super.initState();
    initCounter();
    initDropbox();
  }

  Future initDropbox() async {
    await Dropbox.init(dropboxClientId, dropboxKey, dropboxSecret);
    await Dropbox.authorizeWithAccessToken(accessToken);
    setState(() {});
  }

  Future initCounter() async {
    final SharedPreferences prefs = await _prefs;
    _counter = (prefs.getInt('counter') ?? 0);
  }

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      prefs.setInt('counter', counter);
      _counter = counter;
    });
  }

  Future<void> _upload() async {
    var tempDir = await getTemporaryDirectory();
    var filepath = '${tempDir.path}/${_controllerF.text}.txt';
    File(filepath).writeAsStringSync(_controllerT.text);
    await Dropbox.upload(filepath, '/${_controllerF.text}.txt');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      body: Center(
          child: Row(
        children: const [
          Expanded(
            child: Text(
              "Xyu1",
              textAlign: TextAlign.center,
              textScaleFactor: 2,
            ),
          ),
          Expanded(
              child: Text(
            "Xyu3",
            textAlign: TextAlign.center,
            textScaleFactor: 2,
          )),
          Expanded(
            child: Text(
              "Xyu3",
              textAlign: TextAlign.center,
              textScaleFactor: 2,
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            Expanded(
                child: ElevatedButton.icon(
                    onPressed: _upload,
                    label: const Text(""),
                    icon: const Icon(Icons.save))),
            Expanded(
                child: ElevatedButton.icon(
                    onPressed: _incrementCounter,
                    label: const Text(""),
                    icon: const Icon(Icons.add))),
            Expanded(
                child: ElevatedButton.icon(
                    onPressed: () {
                      _controllerT.text = "";
                      _controllerF.text = "";
                    },
                    label: const Text(""),
                    icon: const Icon(Icons.clear))),
          ],
        ),
      ),
    );
  }
}
*/
