// Import the test package and Counter class
import 'package:championsapp/models/hobby.dart';
import 'package:test/test.dart';
import 'package:championsapp/models/champion.dart';

void main() {
  group('champions testen', () {
    test('Champion value should have a correct number of hobbies', () {
      final champion = Champion(id: 12, naam: 'Ronaldo', klas: '1c', hobbies: []);
      champion.hobbies!.add(Hobby(id: 1, naam: 'Voetbal'));
      expect(champion.hobbies!.length, 2);
    });
  });
}
