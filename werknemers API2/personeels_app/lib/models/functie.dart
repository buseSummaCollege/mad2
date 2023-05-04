class Functie {
  final int id;
  final String naam;

  Functie({
    required this.id,
    required this.naam,
  });

  // Onderstaande is nodig i.v.m. gebruik DropdownButton
  @override
  bool operator ==(Object other) {
    if (other is Functie) {
      return other.id == id;
    }
    else {
      return false;
    }
  }

  @override
  int get hashCode {
    return Object.hash(id, naam);
  }

  // {
  // "id": 6,
  // "naam": "field engineer"
  // }
}
