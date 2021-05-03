import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:walf/walf.dart';
import 'package:walf/src/models/walf_string.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await Permission.storage.isDenied) {
    Permission.storage.request();
  }
  initWalfDatabase();
  runApp(MyApp());
}

String databaseName = "beratdatabase";
late WalfDatabase database;
initWalfDatabase() async {
  database = WalfDatabase(databaseName);

  if (!(await database.existDatabase(databaseName))) {
    database.createDatabase(databaseName);
  } else {
    database.initDatabase();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
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
              StreamBuilder<WalfString>(
                  stream: database.getString("key").asStream(),
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        Text(snapshot.data!.value.toString()),
                        TextButton(
                            onPressed: () {
                              database.setString("key", "Mustafa Berat Kurt");
                              setState(() {});
                            },
                            child: Text("INCREASE")),
                        TextButton(
                            onPressed: () {
                              database.removeData("key");
                              setState(() {});
                            },
                            child: Text("REMOVE")),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
