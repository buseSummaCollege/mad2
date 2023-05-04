class Werknemer {
  final int id;
  final String naam;
  final int functieId;
  final String? telefoon;
  final String email;
  final String? sinds;

  Werknemer({
    required this.id,
    required this.naam,
    required this.functieId,
    this.telefoon,
    required this.email,
    this.sinds,
  });

}

// {
// "id": 1,
// "naam": "Jan",
// "functie_id": 1,
// "telefoon": "0631874312",
// "email": "jan@summa.nl",
// "sinds": "2002-11-01"
// }
