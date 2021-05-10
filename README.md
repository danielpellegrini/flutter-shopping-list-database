# SECTION SUMMARY

Crea un databaseFactoryIo, che permette di aprire i database di Sembast

    DatabaseFactory dbfactory = databaseFactoryIo;

Apre il database con il metodo openDatabase passando il percorso del DB

    final db = await dbFactory.openDatabase(percorsoDb);

Uno Store è un percorso all'interno di un database Sembast

    final store = intMapStoreFactory.store('articoli');

Il metodo add, sullo Store, aggiunge un nuovo elemento all'interno del databse passato come primo parametro

    await store.add(_db, articolo.transformaInMap());

Crea un oggeto Finder, che permette di ricercare e ordinare dati all'interno di uno Store

    final finder = Finder(sortOrders: [
      SortOrder('id'),
    ]);

Chiama il metodo find sullo store, passando il database e il Finder, per ottenre uno Snapshot dei dati

    final articoliSnapshot = await store.find(
      _db, finder: finder);
  
Chiama il metodo map sullo Snapshot per creare oggetti di tipo Articolo dall'insieme di Map restituire dal metodo find()

    return articoliSnapshot.map((snapshot) {
      final articolo = Articolo.daMap(
          snapshot.value);
        articolo.id = snapshot.key;
        return articolo;
    }).toList();