import 'package:local_link/features/crowd/domain/entities/crowd_report.dart';
import 'package:local_link/features/timetable/domain/entities/station.dart';
import 'package:local_link/features/timetable/domain/entities/train_trip.dart';

/// Confidence grade for crowd predictions.
enum PredictionConfidence { high, moderate, low, insufficientData }

/// Result of a crowd level prediction.
class CrowdPredictionResult {
  final CrowdDensity predictedDensity;
  final PredictionConfidence confidence;
  final double confidenceScore; // 0.0 to 1.0
  final bool isRushHour;
  final String rationale;
  final bool hasSufficientData;

  const CrowdPredictionResult({
    required this.predictedDensity,
    required this.confidence,
    required this.confidenceScore,
    required this.isRushHour,
    required this.rationale,
    required this.hasSufficientData,
  });

  /// Factory for when insufficient data exists to make an honest estimate.
  factory CrowdPredictionResult.insufficientData([String? reason]) {
    return CrowdPredictionResult(
      predictedDensity: CrowdDensity.low,
      confidence: PredictionConfidence.insufficientData,
      confidenceScore: 0.1,
      isRushHour: false,
      rationale:
          reason ??
          'Insufficient historical passenger flow data for this corridor at the requested time.',
      hasSufficientData: false,
    );
  }
}

/// Baseline historical heuristic crowd prediction engine for the Mumbai Suburban Rail network.
/// Models authentic peak-direction rush hour flows (Southbound AM, Northbound PM) with Sunday adjustments.
class CrowdPredictionService {
  const CrowdPredictionService();

  /// Predicts crowding level based on time of day, day of week, line, direction, and service type.
  CrowdPredictionResult predictCrowdLevel({
    required Station station,
    required RailwayLineId lineId,
    required TrainDirection direction,
    required ServiceType serviceType,
    required DateTime queryTime,
  }) {
    final hour = queryTime.hour;
    final minute = queryTime.minute;
    final minutesFromMidnight = hour * 60 + minute;
    final weekday = queryTime.weekday; // 1 = Mon, 7 = Sun

    // Sunday pattern: Significantly reduced commuter loads across all suburban lines
    if (weekday == DateTime.sunday) {
      if (minutesFromMidnight >= 720 && minutesFromMidnight <= 1260) {
        return const CrowdPredictionResult(
          predictedDensity: CrowdDensity.medium,
          confidence: PredictionConfidence.moderate,
          confidenceScore: 0.72,
          isRushHour: false,
          rationale:
              'Sunday leisure / shopping hours with moderate passenger volume.',
          hasSufficientData: true,
        );
      }
      return const CrowdPredictionResult(
        predictedDensity: CrowdDensity.low,
        confidence: PredictionConfidence.high,
        confidenceScore: 0.85,
        isRushHour: false,
        rationale: 'Sunday non-peak operating schedule with seats available.',
        hasSufficientData: true,
      );
    }

    // Weekday Rush Hour Boundaries:
    // Morning Peak: 08:00 - 11:30 (480 to 690 mins) -> Predominantly UP direction (towards Churchgate / CSMT)
    final isMorningPeak =
        minutesFromMidnight >= 480 && minutesFromMidnight <= 690;

    // Evening Peak: 17:30 - 21:00 (1050 to 1260 mins) -> Predominantly DOWN direction (towards Borivali, Virar, Kalyan)
    final isEveningPeak =
        minutesFromMidnight >= 1050 && minutesFromMidnight <= 1260;

    // Late Night / Early Morning Low Data threshold (01:00 to 04:00)
    if (minutesFromMidnight >= 60 && minutesFromMidnight <= 240) {
      return CrowdPredictionResult.insufficientData(
        'Suburban railway services are largely suspended between 01:30 and 04:00.',
      );
    }

    // Fast train crowding premium: Fast services carry higher crowding density
    final isFast =
        serviceType == ServiceType.fast || serviceType == ServiceType.acFast;

    if (isMorningPeak) {
      if (direction == TrainDirection.up) {
        // Commuters heading to South Mumbai business districts
        return CrowdPredictionResult(
          predictedDensity: isFast
              ? CrowdDensity.superDense
              : CrowdDensity.heavy,
          confidence: PredictionConfidence.high,
          confidenceScore: 0.92,
          isRushHour: true,
          rationale:
              'Morning Peak: Heavy Southbound commuter flow towards business districts (Churchgate / CSMT / BKC).',
          hasSufficientData: true,
        );
      } else {
        // Reverse direction in morning
        return const CrowdPredictionResult(
          predictedDensity: CrowdDensity.medium,
          confidence: PredictionConfidence.high,
          confidenceScore: 0.84,
          isRushHour: true,
          rationale:
              'Morning counter-peak flow: Moderate passenger volume heading North.',
          hasSufficientData: true,
        );
      }
    }

    if (isEveningPeak) {
      if (direction == TrainDirection.down) {
        // Commuters heading home towards Northern suburbs
        return CrowdPredictionResult(
          predictedDensity: isFast
              ? CrowdDensity.superDense
              : CrowdDensity.heavy,
          confidence: PredictionConfidence.high,
          confidenceScore: 0.94,
          isRushHour: true,
          rationale:
              'Evening Peak: Maximum Northbound commuter rush heading home towards suburbs.',
          hasSufficientData: true,
        );
      } else {
        // Reverse direction in evening
        return const CrowdPredictionResult(
          predictedDensity: CrowdDensity.medium,
          confidence: PredictionConfidence.high,
          confidenceScore: 0.82,
          isRushHour: true,
          rationale:
              'Evening counter-peak flow: Moderate Southbound passenger volume.',
          hasSufficientData: true,
        );
      }
    }

    // Midday Off-Peak (11:30 to 16:30)
    if (minutesFromMidnight > 690 && minutesFromMidnight < 990) {
      return const CrowdPredictionResult(
        predictedDensity: CrowdDensity.medium,
        confidence: PredictionConfidence.high,
        confidenceScore: 0.80,
        isRushHour: false,
        rationale:
            'Midday non-peak hours with standing room and frequent available seats.',
        hasSufficientData: true,
      );
    }

    // Default regular off-peak
    return const CrowdPredictionResult(
      predictedDensity: CrowdDensity.low,
      confidence: PredictionConfidence.moderate,
      confidenceScore: 0.75,
      isRushHour: false,
      rationale: 'Regular off-peak hours with comfortable boarding conditions.',
      hasSufficientData: true,
    );
  }
}
