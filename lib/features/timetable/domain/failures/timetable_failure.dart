/// Strongly typed domain failures for timetable and railway operations.
sealed class TimetableFailure {
  final String message;
  const TimetableFailure(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

/// Thrown when a station code or identifier does not match any known station.
final class StationNotFoundFailure extends TimetableFailure {
  final String identifier;
  const StationNotFoundFailure(this.identifier)
    : super('Station not found for identifier: $identifier');
}

/// Thrown when no valid journey path exists between origin and destination.
final class RouteNotFoundFailure extends TimetableFailure {
  final String originCode;
  final String destinationCode;
  const RouteNotFoundFailure({
    required this.originCode,
    required this.destinationCode,
  }) : super(
         'No connecting route found between $originCode and $destinationCode',
       );
}

/// Thrown when timetable seed data is invalid, incomplete, or corrupted.
final class CorruptedDatasetFailure extends TimetableFailure {
  final String details;
  const CorruptedDatasetFailure(this.details)
    : super('Timetable dataset is corrupt or invalid: $details');
}

/// Thrown when a schedule contains chronological violations (e.g., departure < arrival).
final class InvalidScheduleFailure extends TimetableFailure {
  final String tripId;
  const InvalidScheduleFailure(this.tripId, String details)
    : super('Invalid schedule for trip $tripId: $details');
}

/// Thrown when a local database query or transaction encounters a failure.
final class DatabaseFailure extends TimetableFailure {
  final Object? cause;
  const DatabaseFailure(super.message, [this.cause]);
}
