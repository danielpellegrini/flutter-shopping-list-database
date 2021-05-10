import 'package:flutter/material.dart';
import 'package:shopping_list/dati/articolo.dart';
import './dati/articolo_db.dart';
import './dati/articolo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ProvaDb(),
    );
  }
}

class ProvaDb extends StatefulWidget {
  @override
  _ProvaDbState createState() => _ProvaDbState();
}

class _ProvaDbState extends State<ProvaDb> {
  int id;
  @override
  void initState() {
    provaDb();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpesApp'),
      ),
      body: Center(
        child: Container(
          child: Text(id.toString()),
        ),
      ),
    );
  }

  Future provaDb() async {
    ArticoloDb articoloDb = ArticoloDb();
    Articolo articolo = Articolo('Arance', '2kg', 'Da spremuta');
    id = await articoloDb.inserisciArticolo(articolo);
    setState(() {
      id = id;
    });
  }
}
