import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

void main() {
  Client client = Client();

  client
      .setEndpoint('https://192.168.0.105:1668/v1')
      .setProject('5fb1b4cf422f1')
      .setSelfSigned();
  Account account = Account(client);
  runApp(MyApp(account: account));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.account}) : super(key: key);
  final Account account;
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
        account: account,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.account}) : super(key: key);

  final String title;
  final Account account;
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
        onPressed: () => createUser(widget.account),
        child: Icon(Icons.add),
      ),
    );
  }

  createUser(account) async {
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
