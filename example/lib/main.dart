import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appwrite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Client client = Client();

    client
        .setEndpoint('https://http://192.168.0.105:1668/v1')
        .setProject('5fb1b4cf422f1')
        .setSelfSigned();
    return Scaffold(
      appBar: AppBar(
        title: Text("Appwrite Test"),
        centerTitle: true,
      ),
      body: viewData(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createUser(client),
        child: Icon(Icons.add),
      ),
    );
  }

  createUser(Client client) async {
    try {
      Account account = Account(client);

      Response user = await account.create(
          email: 'me@appwrite.io', password: 'password', name: 'My Name');

      Response session = await account.createSession(
          email: 'me@appwrite.io', password: 'password');

      print("User Data:" + user.data);
      print("Session Data" + session.data);
    } catch (e) {
      print("Error:" + e.toString());
    }
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
