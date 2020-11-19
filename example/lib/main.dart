import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';


void main() {
  Client client = Client();

  client
      .setEndpoint('https://192.168.0.105:1668/v1')
      .setProject('5fb1b4cf422f1')
      .setSelfSigned();
  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.client}) : super(key: key);
  final Client client;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appwrite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        client: client,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.client}) : super(key: key);
  final Client client;
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appwrite Test"),
        centerTitle: true,
      ),
      body: viewData(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.add),
      ),
    );
  }

  createUser() async {
    Account account = Account(widget.client);
    try {
      Response user = await account.create(
          email: 'me4@appwrite.io', password: 'password', name: 'My Name');

      Response session = await account.createSession(
          email: 'me4@appwrite.io', password: 'password');

      print("User Data:" + user.data['name'].toString());
      print("Session Data" + session.data.id.toString());
    } catch (e) {
      print("Error:" + e.toString());
    }
  }

  uploadFile() async {
    Storage storage = Storage(widget.client);
    Future result = storage.createFile(
      file: await MultipartFile.fromFile('./path-to-files/image.jpg',
          filename: 'image.jpg'),
      read: [],
      write: [],
    );

    result.then((response) {
      print(response);
    }).catchError((error) {
      print(error.response);
    });
  }

  Widget viewData() {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Name',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Age',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Role',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Associate Professor')),
          ],
        ),
      ],
    );
  }
}
