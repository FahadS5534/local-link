import 'package:flutter_test/flutter_test.dart';
import 'package:local_link/features/crowd/domain/entities/crowd_report.dart';
import 'package:local_link/features/prediction/domain/services/crowd_prediction_service.dart';
import 'package:local_link/features/timetable/domain/entities/station.dart';
import 'package:local_link/features/timetable/domain/entities/train_trip.dart';

void main() {
  const service = CrowdPredictionService();

  const dadar = Station(
    id: 'ST_DDR',
    code: 'DDR',
    nameEn: 'Dadar',
    nameHi: 'दादर',
    nameMr: 'दादर',
    latitude: 19.0178,
    longitude: 72.8478,
    lines: [RailwayLineId.western, RailwayLineId.centralMain],
    isInterchange: true,
  );

  group('CrowdPredictionService Tests', () {
    test(
      'predicts superDense / heavy crowd during morning peak UP direction (09:00 AM)',
      () {
        final morningPeak = DateTime(2026, 10, 26, 9, 0); // Monday 9:00 AM

        final resultFast = service.predictCrowdLevel(
          station: dadar,
          lineId: RailwayLineId.western,
          direction: TrainDirection.up,
          serviceType: ServiceType.fast,
          queryTime: morningPeak,
        );

        expect(resultFast.hasSufficientData, isTrue);
        expect(resultFast.isRushHour, isTrue);
        expect(resultFast.predictedDensity, equals(CrowdDensity.superDense));
        expect(resultFast.confidence, equals(PredictionConfidence.high));
        expect(resultFast.confidenceScore, greaterThanOrEqualTo(0.9));
        expect(resultFast.rationale, contains('Morning Peak'));
      },
    );

    test(
      'predicts superDense crowd during evening peak DOWN direction (18:30 PM)',
      () {
        final eveningPeak = DateTime(2026, 10, 26, 18, 30); // Monday 6:30 PM

        final result = service.predictCrowdLevel(
          station: dadar,
          lineId: RailwayLineId.western,
          direction: TrainDirection.down,
          serviceType: ServiceType.fast,
          queryTime: eveningPeak,
        );

        expect(result.hasSufficientData, isTrue);
        expect(result.isRushHour, isTrue);
        expect(result.predictedDensity, equals(CrowdDensity.superDense));
        expect(result.rationale, contains('Evening Peak'));
      },
    );

    test(
      'predicts comfortable low/medium density on Sunday non-rush schedules',
      () {
        final sundayMorning = DateTime(2026, 10, 25, 9, 30); // Sunday 9:30 AM

        final result = service.predictCrowdLevel(
          station: dadar,
          lineId: RailwayLineId.western,
          direction: TrainDirection.up,
          serviceType: ServiceType.slow,
          queryTime: sundayMorning,
        );

        expect(result.isRushHour, isFalse);
        expect(result.predictedDensity, equals(CrowdDensity.low));
        expect(result.rationale, contains('Sunday'));
      },
    );

    test(
      'returns InsufficientData during late night railway suspension (02:30 AM)',
      () {
        final lateNight = DateTime(2026, 10, 26, 2, 30); // 2:30 AM

        final result = service.predictCrowdLevel(
          station: dadar,
          lineId: RailwayLineId.western,
          direction: TrainDirection.up,
          serviceType: ServiceType.slow,
          queryTime: lateNight,
        );

        expect(result.hasSufficientData, isFalse);
        expect(
          result.confidence,
          equals(PredictionConfidence.insufficientData),
        );
        expect(result.rationale, contains('suspended'));
      },
    );
  });
}
