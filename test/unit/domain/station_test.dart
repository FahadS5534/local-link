import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/timetable/domain/entities/station.dart';

void main() {
  group('Station Entity Tests', () {
    const dadar = Station(
      id: 'ST_DDR',
      code: 'DDR',
      nameEn: 'Dadar',
      nameHi: 'दादर',
      nameMr: 'दादर',
      latitude: 19.0178,
      longitude: 72.8431,
      lines: [RailwayLineId.western, RailwayLineId.centralMain],
      isInterchange: true,
    );

    test('returns localized station name correctly across all languages', () {
      expect(dadar.localizedName('en'), 'Dadar');
      expect(dadar.localizedName('hi'), 'दादर');
      expect(dadar.localizedName('mr'), 'दादर');
      expect(dadar.localizedName('unknown'), 'Dadar');
    });

    test('equality and hashCode are based on id and code', () {
      const dadarCopy = Station(
        id: 'ST_DDR',
        code: 'DDR',
        nameEn: 'Dadar Junction',
        nameHi: 'दादर',
        nameMr: 'दादर',
        latitude: 19.0178,
        longitude: 72.8431,
        lines: [RailwayLineId.western],
      );

      expect(dadar, equals(dadarCopy));
      expect(dadar.hashCode, equals(dadarCopy.hashCode));
    });

    test('isInterchange flag indicates junction connecting multiple lines', () {
      expect(dadar.isInterchange, isTrue);
      expect(dadar.lines.length, 2);
    });
  });
}
