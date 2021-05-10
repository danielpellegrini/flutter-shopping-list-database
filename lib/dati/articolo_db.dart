import 'dart:async'; // per utilizzare i metodi asincroni con le istruzioni async e await
import 'package:path_provider/path_provider.dart'; // per trovare il percorso del database
import 'package:path/path.dart'; // mi permetterà di fare un concatenamento con il percorso
import 'package:sembast/sembast.dart'; // il mio database
import 'package:sembast/sembast_io.dart'; // contiene alcuni oggetti di sembast e mi permette di effettuare lettura e scrittura database
import 'articolo.dart'; //

class ArticoloDb {
  DatabaseFactory dbfactory = databaseFactoryIo;
  Database _db;
  final store = intMapStoreFactory.store('articoli');

  Future _openDb() async {
    final percorsoDocumenti = await getApplicationDocumentsDirectory();
    final percorsoDb = join(percorsoDocumenti.path, 'articoli.db');
    final db = await dbfactory.openDatabase(percorsoDb);
    return db;
  }

  Future inserisciArticolo(Articolo articolo) async {
    Database db = await _openDb();
    int id = await store.add(db, articolo.trasformaInMap());
    return id;
  }
}
