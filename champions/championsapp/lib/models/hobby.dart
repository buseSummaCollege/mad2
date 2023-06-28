import 'champion.dart';

class Hobby  {
  final int id;
  final String naam;
  final List<Champion>? champions;

  Hobby({
    required this.id,
    required this.naam,
    this.champions,
  });

  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(
      id: json['id'],
      naam: json['naam'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (other is Hobby) {
      return other.id == id;
    } else {
      return false;
    }
  }

  @override
  // TODO: implement hashCode
  int get hashCode => '$naam$id'.hashCode;
}