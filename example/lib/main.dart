import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:walf/walf.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await Permission.storage.isDenied) {
    Permission.storage.request();
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String databaseName = "beratdatabase";
  static const String databasePass =
      "rX59jDdeAtBd9Oi24NupVhW1eatUgPC9"; // Must be 32 characters long
  WalfDatabase database = WalfDatabase("beratdatabase", password: databasePass);
  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  initWalfDatabase() async {
    if (!(await database.existDatabase())) {
      await database.createDatabase();
    }
  }

  @override
  void initState() {
    initWalfDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Walf Example App'),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: keyController,
                  decoration: InputDecoration(hintText: "Enter key"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: valueController,
                  decoration: InputDecoration(hintText: "Enter value"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    database.setBool(keyController.text,
                        valueController.text.toLowerCase() == "true");
                    setState(() {});
                    // setState(() {});
                  },
                  child: Text("ENTER DATA")),
              StreamBuilder<WalfBool>(
                  stream: database.getBool(keyController.text).asStream(),
                  builder: (context, snapshot) {
                    return Text(snapshot.data!.value.toString());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
