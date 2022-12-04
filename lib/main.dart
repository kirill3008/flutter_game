import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenu(),
        '/firstpage': (context) => const Page(),
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
            Navigator.pushNamed(context, '/firstpage');
          },
          child: const Text("Next page"),
        ))
      ]),
    );
  }
}

class Snake extends StatefulWidget {
  List<List<int>> map = [
    [2, 1, 1, 1, 1],
    [0, 0, 0, 0, 1],
    [1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0],
    [1, 1, 1, 1, 1],
    [0, 0, 0, 0, 1],
    [1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0],
    [1, 1, 1, 1, 1],
  ];
  int curField;
  List<List<int>> idToFild = [
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
              "${i} ${j}",
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
  const Page({Key? key}) : super(key: key);

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  int curField = 0;
  var map = [
    [2, 1, 1, 1, 1],
    [0, 0, 0, 0, 1],
    [1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0],
    [1, 1, 1, 1, 1],
    [0, 0, 0, 0, 1],
    [1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0],
    [1, 1, 1, 1, 1],
  ];
  @override
  Widget build(BuildContext context) {
    var snake = Snake(
      map: map,
      curField: curField,
    );
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Center(
          child: Row(
        children: [
          const Expanded(
            child: Text(
              "Защита окружающей среды, рекреация, сохранение ландшафтов, экологически чистая энергетика, биотехнология, гуманизация производства",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: snake),
          const Expanded(
            child: Text(
              "X3",
              textAlign: TextAlign.center,
              textScaleFactor: 2,
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          if (curField + 1 < snake.idToFild.length) {
            map[snake.idToFild[curField][0]][snake.idToFild[curField][1]] = 1;
            curField += 1;
            map[snake.idToFild[curField][0]][snake.idToFild[curField][1]] = 2;
          }
        });
      }),
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
