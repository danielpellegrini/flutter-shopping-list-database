class Articolo {
  int id;
  String nome;
  String quantita;
  String note;

  Articolo(this.nome, this.quantita, this.note);

  Map<String, dynamic> trasformaInMap() {
    return {
      'id': id ?? null,
      'nome': nome,
      'quantita': quantita,
      'note': note,
    };
  }

  Articolo.daMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    quantita = map['quantita'];
    note = map['note'];
  }
}
