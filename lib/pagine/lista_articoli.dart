import 'package:flutter/material.dart';
import 'package:shopping_list/pagine/articolo.dart';
import '../dati/articolo_db.dart';
import '../dati/articolo.dart';

class ListaArticoli extends StatefulWidget {
  @override
  _ListaArticoliState createState() => _ListaArticoliState();
}

class _ListaArticoliState extends State<ListaArticoli> {
  ArticoloDb db;
  @override
  void initState() {
    db = ArticoloDb();
    db.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: cancellaTutto,
          )
        ],
      ),
      body: FutureBuilder(
          future: leggiArticoli(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Articolo> lista = snapshot.data;
            return ListView.builder(
                itemCount: (lista == null) ? 0 : lista.length,
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: Key(lista[index].id.toString()),
                    onDismissed: (_) {
                      db.eliminaArticolo(lista[index]);
                    },
                    child: ListTile(
                      title: Text(lista[index].nome ?? ''),
                      subtitle: Text('Quantity: ' + lista[index].quantita ??
                          '' + ' - Notes: ' + lista[index].note ??
                          ''),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaginaArticolo(lista[index], false)),
                        );
                      },
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PaginaArticolo(new Articolo('', '', '', 0), true)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future leggiArticoli() async {
    await db.init();
    List<Articolo> articoli = await db.leggiArticoli();
    return articoli;
  }

  void cancellaTutto() {
    AlertDialog alert = AlertDialog(
      title: Text('Do you want to delete all items?'),
      content: Text('This action cannot be undone!'),
      actions: [
        TextButton(
          onPressed: () {
            db.eliminaDatiDb().then((value) {
              setState(() {
                db = ArticoloDb();
              });
              Navigator.pop(context);
            });
          },
          child: Text('YES'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('NO'),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
