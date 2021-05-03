![Walf Db Logo](https://github.com/zekkontro/walf-database/blob/main/logo.png?raw=true)

<a href="https://pub.dev/packages/walf"><img src="https://img.shields.io/pub/v/walf?label=pub.dev&amp;labelColor=333940&amp;logo=dart" alt="Pub Version"></a> <a href="https://github.com/hivedb/hive/blob/master/LICENSE" rel="ugc"><img src="https://img.shields.io/github/license/zekkontro/walf-database?color=%23007A88&amp;labelColor=333940&amp;logo=mit" alt="GitHub"></a>

# Walf - Secure Database
  
Walf is a secure and fast key-value based database based on JSON. It uses AES-256 CBC encryption algorithm for Walf security. Keeps all data in a customized JSON file with ".wfdb" extension in the device.

### Features
-   🚀 Cross platform: Android, IOS
-   ❤️ Simple, powerful, & intuitive API
-   🔒 Strong encryption built in
-   🎈  **NO**  native dependencies

## Setup
The [permission_handler](https://pub.dev/packages/permission_handler) package required.

/pubspec.yaml file:

Add dependencies permission_handler because Walf create locale database on device.

    dependencies:
    flutter:
		sdk:  flutter
    permission_handler:  ^7.1.0
	walf:  ^1.0.0


### Usage
You must initialize your database:

    void  main() async {
	WidgetsFlutterBinding.ensureInitialized();
	if (await  Permission.storage.isDenied) {
	Permission.storage.request();
	}
	initWalfDatabase();
	runApp(MyApp());
	}

	String databaseName =  "beratdatabase";
	late  WalfDatabase database;

	initWalfDatabase() async {
	database =  WalfDatabase(databaseName);
	if (!(await database.existDatabase(databaseName))) {
	database.createDatabase(databaseName);
	} else {
	database.initDatabase();
	}}
	
Walf Database Plugin example usage code:

    return  MaterialApp(
    home:  Scaffold(
    appBar:  AppBar(
    title:  const  Text('Walf Example App'),
    ),
    
    body:  Center(
    child:  Column(
    children: [
    StreamBuilder<WalfString>(
    stream: database.getString("key").asStream(),
    builder: (context, snapshot) {
    return  Column(
    children: [
    Text(snapshot.data!.value.toString()),
    TextButton(
    onPressed: () {
    database.setString("key",  "Mustafa Berat Kurt");
    setState(() {});
    },
    
    child:  Text("INCREASE")),
    
    TextButton(
    onPressed: () {
    database.removeData("key");
    setState(() {});
    },
    child:  Text("REMOVE")),
    ],
    );
    }),
    ],
    ),),
    ),);

### Plugin Author

<table>
  <tr>
    <td align="center"><a href="https://www.linkedin.com/in/berat-kurt-958b6a202/"><img src="https://avatars.githubusercontent.com/u/56454493?v=4?v=4" width="100px;" alt=""/><br /><sub><b>Berat Kurt</b></sub></a><br /><a href="https://github.com/zekkontro/walf-database/commits?author=zekkontro" title="Code">💻</a> <a href="#design-mukireus" title="Design">🎨</a> 
  </tr>
</table>

### LICENCE
    
    MIT License

    Copyright (c) 2021 Berat Kurt

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
