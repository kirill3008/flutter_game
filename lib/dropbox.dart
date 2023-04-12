//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:dropbox_client/dropbox_client.dart';
//import 'package:path_provider/path_provider.dart';
//import 'dart:async';
//import 'dart:io';

const String dropboxClientId = 'boo';
const String dropboxKey = 's4but2m7b5dt9zf';
const String dropboxSecret = 'qcuogyb0l451z72';





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

