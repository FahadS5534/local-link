import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/timetable/domain/entities/station.dart';
import 'package:local_link/features/timetable/domain/entities/train_trip.dart';

void main() {
  group('TrainTrip Entity Tests', () {
    const trip = TrainTrip(
      id: 'WR_90001',
      trainNumber: '90001',
      lineId: RailwayLineId.western,
      direction: TrainDirection.down,
      serviceType: ServiceType.fast,
      sourceStationId: 'ST_CCG',
      destinationStationId: 'ST_BVI',
      operatingDaysMask: 63, // Monday through Saturday (bits 0 to 5)
    );

    test('isFast returns true for fast and acFast services', () {
      expect(trip.isFast, isTrue);
      expect(trip.isAc, isFalse);

      const acFast = TrainTrip(
        id: 'WR_90002',
        trainNumber: '90002',
        lineId: RailwayLineId.western,
        direction: TrainDirection.down,
        serviceType: ServiceType.acFast,
        sourceStationId: 'ST_CCG',
        destinationStationId: 'ST_VR',
      );
      expect(acFast.isFast, isTrue);
      expect(acFast.isAc, isTrue);

      const slow = TrainTrip(
        id: 'WR_90003',
        trainNumber: '90003',
        lineId: RailwayLineId.western,
        direction: TrainDirection.down,
        serviceType: ServiceType.slow,
        sourceStationId: 'ST_CCG',
        destinationStationId: 'ST_BVI',
      );
      expect(slow.isFast, isFalse);
    });

    test('runsOnWeekday checks 7-bit bitmask correctly', () {
      // 63 = 1+2+4+8+16+32 = Mon-Sat
      expect(trip.runsOnWeekday(1), isTrue); // Mon
      expect(trip.runsOnWeekday(6), isTrue); // Sat
      expect(trip.runsOnWeekday(7), isFalse); // Sun
      expect(trip.runsOnWeekday(0), isFalse); // invalid
      expect(trip.runsOnWeekday(8), isFalse); // invalid
    });
  });
}
