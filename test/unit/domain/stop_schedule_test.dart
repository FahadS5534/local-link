import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/timetable/domain/entities/stop_schedule.dart';

void main() {
  group('StopSchedule Entity Tests', () {
    const stop = StopSchedule(
      tripId: 'WR_90001',
      stationId: 'ST_DDR',
      stopSequence: 3,
      arrivalMinutes: 516, // 08:36
      departureMinutes: 517, // 08:37
      platform: '5',
    );

    test('formatMinutes converts minutes from midnight to HH:mm string', () {
      expect(StopSchedule.formatMinutes(0), '00:00');
      expect(StopSchedule.formatMinutes(65), '01:05');
      expect(StopSchedule.formatMinutes(516), '08:36');
      expect(StopSchedule.formatMinutes(1439), '23:59');
    });

    test(
      'departureTimeFormatted and arrivalTimeFormatted return correct strings',
      () {
        expect(stop.arrivalTimeFormatted, '08:36');
        expect(stop.departureTimeFormatted, '08:37');
        expect(stop.dwellTimeMinutes, 1);
      },
    );
  });
}
