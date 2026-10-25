// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StationsTableTable extends StationsTable
    with TableInfo<$StationsTableTable, StationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameHiMeta = const VerificationMeta('nameHi');
  @override
  late final GeneratedColumn<String> nameHi = GeneratedColumn<String>(
    'name_hi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMrMeta = const VerificationMeta('nameMr');
  @override
  late final GeneratedColumn<String> nameMr = GeneratedColumn<String>(
    'name_mr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _linesJsonMeta = const VerificationMeta(
    'linesJson',
  );
  @override
  late final GeneratedColumn<String> linesJson = GeneratedColumn<String>(
    'lines_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isInterchangeMeta = const VerificationMeta(
    'isInterchange',
  );
  @override
  late final GeneratedColumn<bool> isInterchange = GeneratedColumn<bool>(
    'is_interchange',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_interchange" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    nameEn,
    nameHi,
    nameMr,
    latitude,
    longitude,
    linesJson,
    isInterchange,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stations';
  @override
  VerificationContext validateIntegrity(
    Insertable<StationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_hi')) {
      context.handle(
        _nameHiMeta,
        nameHi.isAcceptableOrUnknown(data['name_hi']!, _nameHiMeta),
      );
    } else if (isInserting) {
      context.missing(_nameHiMeta);
    }
    if (data.containsKey('name_mr')) {
      context.handle(
        _nameMrMeta,
        nameMr.isAcceptableOrUnknown(data['name_mr']!, _nameMrMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMrMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('lines_json')) {
      context.handle(
        _linesJsonMeta,
        linesJson.isAcceptableOrUnknown(data['lines_json']!, _linesJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_linesJsonMeta);
    }
    if (data.containsKey('is_interchange')) {
      context.handle(
        _isInterchangeMeta,
        isInterchange.isAcceptableOrUnknown(
          data['is_interchange']!,
          _isInterchangeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameHi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_hi'],
      )!,
      nameMr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_mr'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      linesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lines_json'],
      )!,
      isInterchange: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_interchange'],
      )!,
    );
  }

  @override
  $StationsTableTable createAlias(String alias) {
    return $StationsTableTable(attachedDatabase, alias);
  }
}

class StationsTableData extends DataClass
    implements Insertable<StationsTableData> {
  final String id;
  final String code;
  final String nameEn;
  final String nameHi;
  final String nameMr;
  final double latitude;
  final double longitude;
  final String linesJson;
  final bool isInterchange;
  const StationsTableData({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameHi,
    required this.nameMr,
    required this.latitude,
    required this.longitude,
    required this.linesJson,
    required this.isInterchange,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['name_en'] = Variable<String>(nameEn);
    map['name_hi'] = Variable<String>(nameHi);
    map['name_mr'] = Variable<String>(nameMr);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['lines_json'] = Variable<String>(linesJson);
    map['is_interchange'] = Variable<bool>(isInterchange);
    return map;
  }

  StationsTableCompanion toCompanion(bool nullToAbsent) {
    return StationsTableCompanion(
      id: Value(id),
      code: Value(code),
      nameEn: Value(nameEn),
      nameHi: Value(nameHi),
      nameMr: Value(nameMr),
      latitude: Value(latitude),
      longitude: Value(longitude),
      linesJson: Value(linesJson),
      isInterchange: Value(isInterchange),
    );
  }

  factory StationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StationsTableData(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameHi: serializer.fromJson<String>(json['nameHi']),
      nameMr: serializer.fromJson<String>(json['nameMr']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      linesJson: serializer.fromJson<String>(json['linesJson']),
      isInterchange: serializer.fromJson<bool>(json['isInterchange']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameHi': serializer.toJson<String>(nameHi),
      'nameMr': serializer.toJson<String>(nameMr),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'linesJson': serializer.toJson<String>(linesJson),
      'isInterchange': serializer.toJson<bool>(isInterchange),
    };
  }

  StationsTableData copyWith({
    String? id,
    String? code,
    String? nameEn,
    String? nameHi,
    String? nameMr,
    double? latitude,
    double? longitude,
    String? linesJson,
    bool? isInterchange,
  }) => StationsTableData(
    id: id ?? this.id,
    code: code ?? this.code,
    nameEn: nameEn ?? this.nameEn,
    nameHi: nameHi ?? this.nameHi,
    nameMr: nameMr ?? this.nameMr,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    linesJson: linesJson ?? this.linesJson,
    isInterchange: isInterchange ?? this.isInterchange,
  );
  StationsTableData copyWithCompanion(StationsTableCompanion data) {
    return StationsTableData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameHi: data.nameHi.present ? data.nameHi.value : this.nameHi,
      nameMr: data.nameMr.present ? data.nameMr.value : this.nameMr,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      linesJson: data.linesJson.present ? data.linesJson.value : this.linesJson,
      isInterchange: data.isInterchange.present
          ? data.isInterchange.value
          : this.isInterchange,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StationsTableData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameHi: $nameHi, ')
          ..write('nameMr: $nameMr, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('linesJson: $linesJson, ')
          ..write('isInterchange: $isInterchange')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    nameEn,
    nameHi,
    nameMr,
    latitude,
    longitude,
    linesJson,
    isInterchange,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StationsTableData &&
          other.id == this.id &&
          other.code == this.code &&
          other.nameEn == this.nameEn &&
          other.nameHi == this.nameHi &&
          other.nameMr == this.nameMr &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.linesJson == this.linesJson &&
          other.isInterchange == this.isInterchange);
}

class StationsTableCompanion extends UpdateCompanion<StationsTableData> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> nameEn;
  final Value<String> nameHi;
  final Value<String> nameMr;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> linesJson;
  final Value<bool> isInterchange;
  final Value<int> rowid;
  const StationsTableCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameHi = const Value.absent(),
    this.nameMr = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.linesJson = const Value.absent(),
    this.isInterchange = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StationsTableCompanion.insert({
    required String id,
    required String code,
    required String nameEn,
    required String nameHi,
    required String nameMr,
    required double latitude,
    required double longitude,
    required String linesJson,
    this.isInterchange = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       nameEn = Value(nameEn),
       nameHi = Value(nameHi),
       nameMr = Value(nameMr),
       latitude = Value(latitude),
       longitude = Value(longitude),
       linesJson = Value(linesJson);
  static Insertable<StationsTableData> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? nameEn,
    Expression<String>? nameHi,
    Expression<String>? nameMr,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? linesJson,
    Expression<bool>? isInterchange,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (nameEn != null) 'name_en': nameEn,
      if (nameHi != null) 'name_hi': nameHi,
      if (nameMr != null) 'name_mr': nameMr,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (linesJson != null) 'lines_json': linesJson,
      if (isInterchange != null) 'is_interchange': isInterchange,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StationsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? nameEn,
    Value<String>? nameHi,
    Value<String>? nameMr,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String>? linesJson,
    Value<bool>? isInterchange,
    Value<int>? rowid,
  }) {
    return StationsTableCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      nameEn: nameEn ?? this.nameEn,
      nameHi: nameHi ?? this.nameHi,
      nameMr: nameMr ?? this.nameMr,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      linesJson: linesJson ?? this.linesJson,
      isInterchange: isInterchange ?? this.isInterchange,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameHi.present) {
      map['name_hi'] = Variable<String>(nameHi.value);
    }
    if (nameMr.present) {
      map['name_mr'] = Variable<String>(nameMr.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (linesJson.present) {
      map['lines_json'] = Variable<String>(linesJson.value);
    }
    if (isInterchange.present) {
      map['is_interchange'] = Variable<bool>(isInterchange.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StationsTableCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameHi: $nameHi, ')
          ..write('nameMr: $nameMr, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('linesJson: $linesJson, ')
          ..write('isInterchange: $isInterchange, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TripsTableTable extends TripsTable
    with TableInfo<$TripsTableTable, TripsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trainNumberMeta = const VerificationMeta(
    'trainNumber',
  );
  @override
  late final GeneratedColumn<String> trainNumber = GeneratedColumn<String>(
    'train_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineIdMeta = const VerificationMeta('lineId');
  @override
  late final GeneratedColumn<String> lineId = GeneratedColumn<String>(
    'line_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceTypeMeta = const VerificationMeta(
    'serviceType',
  );
  @override
  late final GeneratedColumn<String> serviceType = GeneratedColumn<String>(
    'service_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceStationIdMeta = const VerificationMeta(
    'sourceStationId',
  );
  @override
  late final GeneratedColumn<String> sourceStationId = GeneratedColumn<String>(
    'source_station_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _destinationStationIdMeta =
      const VerificationMeta('destinationStationId');
  @override
  late final GeneratedColumn<String> destinationStationId =
      GeneratedColumn<String>(
        'destination_station_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _operatingDaysMaskMeta = const VerificationMeta(
    'operatingDaysMask',
  );
  @override
  late final GeneratedColumn<int> operatingDaysMask = GeneratedColumn<int>(
    'operating_days_mask',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(127),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trainNumber,
    lineId,
    direction,
    serviceType,
    sourceStationId,
    destinationStationId,
    operatingDaysMask,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trips';
  @override
  VerificationContext validateIntegrity(
    Insertable<TripsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('train_number')) {
      context.handle(
        _trainNumberMeta,
        trainNumber.isAcceptableOrUnknown(
          data['train_number']!,
          _trainNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_trainNumberMeta);
    }
    if (data.containsKey('line_id')) {
      context.handle(
        _lineIdMeta,
        lineId.isAcceptableOrUnknown(data['line_id']!, _lineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lineIdMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('service_type')) {
      context.handle(
        _serviceTypeMeta,
        serviceType.isAcceptableOrUnknown(
          data['service_type']!,
          _serviceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceTypeMeta);
    }
    if (data.containsKey('source_station_id')) {
      context.handle(
        _sourceStationIdMeta,
        sourceStationId.isAcceptableOrUnknown(
          data['source_station_id']!,
          _sourceStationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceStationIdMeta);
    }
    if (data.containsKey('destination_station_id')) {
      context.handle(
        _destinationStationIdMeta,
        destinationStationId.isAcceptableOrUnknown(
          data['destination_station_id']!,
          _destinationStationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationStationIdMeta);
    }
    if (data.containsKey('operating_days_mask')) {
      context.handle(
        _operatingDaysMaskMeta,
        operatingDaysMask.isAcceptableOrUnknown(
          data['operating_days_mask']!,
          _operatingDaysMaskMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TripsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TripsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      trainNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}train_number'],
      )!,
      lineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}line_id'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      serviceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_type'],
      )!,
      sourceStationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_station_id'],
      )!,
      destinationStationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_station_id'],
      )!,
      operatingDaysMask: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}operating_days_mask'],
      )!,
    );
  }

  @override
  $TripsTableTable createAlias(String alias) {
    return $TripsTableTable(attachedDatabase, alias);
  }
}

class TripsTableData extends DataClass implements Insertable<TripsTableData> {
  final String id;
  final String trainNumber;
  final String lineId;
  final String direction;
  final String serviceType;
  final String sourceStationId;
  final String destinationStationId;
  final int operatingDaysMask;
  const TripsTableData({
    required this.id,
    required this.trainNumber,
    required this.lineId,
    required this.direction,
    required this.serviceType,
    required this.sourceStationId,
    required this.destinationStationId,
    required this.operatingDaysMask,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['train_number'] = Variable<String>(trainNumber);
    map['line_id'] = Variable<String>(lineId);
    map['direction'] = Variable<String>(direction);
    map['service_type'] = Variable<String>(serviceType);
    map['source_station_id'] = Variable<String>(sourceStationId);
    map['destination_station_id'] = Variable<String>(destinationStationId);
    map['operating_days_mask'] = Variable<int>(operatingDaysMask);
    return map;
  }

  TripsTableCompanion toCompanion(bool nullToAbsent) {
    return TripsTableCompanion(
      id: Value(id),
      trainNumber: Value(trainNumber),
      lineId: Value(lineId),
      direction: Value(direction),
      serviceType: Value(serviceType),
      sourceStationId: Value(sourceStationId),
      destinationStationId: Value(destinationStationId),
      operatingDaysMask: Value(operatingDaysMask),
    );
  }

  factory TripsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TripsTableData(
      id: serializer.fromJson<String>(json['id']),
      trainNumber: serializer.fromJson<String>(json['trainNumber']),
      lineId: serializer.fromJson<String>(json['lineId']),
      direction: serializer.fromJson<String>(json['direction']),
      serviceType: serializer.fromJson<String>(json['serviceType']),
      sourceStationId: serializer.fromJson<String>(json['sourceStationId']),
      destinationStationId: serializer.fromJson<String>(
        json['destinationStationId'],
      ),
      operatingDaysMask: serializer.fromJson<int>(json['operatingDaysMask']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'trainNumber': serializer.toJson<String>(trainNumber),
      'lineId': serializer.toJson<String>(lineId),
      'direction': serializer.toJson<String>(direction),
      'serviceType': serializer.toJson<String>(serviceType),
      'sourceStationId': serializer.toJson<String>(sourceStationId),
      'destinationStationId': serializer.toJson<String>(destinationStationId),
      'operatingDaysMask': serializer.toJson<int>(operatingDaysMask),
    };
  }

  TripsTableData copyWith({
    String? id,
    String? trainNumber,
    String? lineId,
    String? direction,
    String? serviceType,
    String? sourceStationId,
    String? destinationStationId,
    int? operatingDaysMask,
  }) => TripsTableData(
    id: id ?? this.id,
    trainNumber: trainNumber ?? this.trainNumber,
    lineId: lineId ?? this.lineId,
    direction: direction ?? this.direction,
    serviceType: serviceType ?? this.serviceType,
    sourceStationId: sourceStationId ?? this.sourceStationId,
    destinationStationId: destinationStationId ?? this.destinationStationId,
    operatingDaysMask: operatingDaysMask ?? this.operatingDaysMask,
  );
  TripsTableData copyWithCompanion(TripsTableCompanion data) {
    return TripsTableData(
      id: data.id.present ? data.id.value : this.id,
      trainNumber: data.trainNumber.present
          ? data.trainNumber.value
          : this.trainNumber,
      lineId: data.lineId.present ? data.lineId.value : this.lineId,
      direction: data.direction.present ? data.direction.value : this.direction,
      serviceType: data.serviceType.present
          ? data.serviceType.value
          : this.serviceType,
      sourceStationId: data.sourceStationId.present
          ? data.sourceStationId.value
          : this.sourceStationId,
      destinationStationId: data.destinationStationId.present
          ? data.destinationStationId.value
          : this.destinationStationId,
      operatingDaysMask: data.operatingDaysMask.present
          ? data.operatingDaysMask.value
          : this.operatingDaysMask,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TripsTableData(')
          ..write('id: $id, ')
          ..write('trainNumber: $trainNumber, ')
          ..write('lineId: $lineId, ')
          ..write('direction: $direction, ')
          ..write('serviceType: $serviceType, ')
          ..write('sourceStationId: $sourceStationId, ')
          ..write('destinationStationId: $destinationStationId, ')
          ..write('operatingDaysMask: $operatingDaysMask')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    trainNumber,
    lineId,
    direction,
    serviceType,
    sourceStationId,
    destinationStationId,
    operatingDaysMask,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TripsTableData &&
          other.id == this.id &&
          other.trainNumber == this.trainNumber &&
          other.lineId == this.lineId &&
          other.direction == this.direction &&
          other.serviceType == this.serviceType &&
          other.sourceStationId == this.sourceStationId &&
          other.destinationStationId == this.destinationStationId &&
          other.operatingDaysMask == this.operatingDaysMask);
}

class TripsTableCompanion extends UpdateCompanion<TripsTableData> {
  final Value<String> id;
  final Value<String> trainNumber;
  final Value<String> lineId;
  final Value<String> direction;
  final Value<String> serviceType;
  final Value<String> sourceStationId;
  final Value<String> destinationStationId;
  final Value<int> operatingDaysMask;
  final Value<int> rowid;
  const TripsTableCompanion({
    this.id = const Value.absent(),
    this.trainNumber = const Value.absent(),
    this.lineId = const Value.absent(),
    this.direction = const Value.absent(),
    this.serviceType = const Value.absent(),
    this.sourceStationId = const Value.absent(),
    this.destinationStationId = const Value.absent(),
    this.operatingDaysMask = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TripsTableCompanion.insert({
    required String id,
    required String trainNumber,
    required String lineId,
    required String direction,
    required String serviceType,
    required String sourceStationId,
    required String destinationStationId,
    this.operatingDaysMask = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       trainNumber = Value(trainNumber),
       lineId = Value(lineId),
       direction = Value(direction),
       serviceType = Value(serviceType),
       sourceStationId = Value(sourceStationId),
       destinationStationId = Value(destinationStationId);
  static Insertable<TripsTableData> custom({
    Expression<String>? id,
    Expression<String>? trainNumber,
    Expression<String>? lineId,
    Expression<String>? direction,
    Expression<String>? serviceType,
    Expression<String>? sourceStationId,
    Expression<String>? destinationStationId,
    Expression<int>? operatingDaysMask,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trainNumber != null) 'train_number': trainNumber,
      if (lineId != null) 'line_id': lineId,
      if (direction != null) 'direction': direction,
      if (serviceType != null) 'service_type': serviceType,
      if (sourceStationId != null) 'source_station_id': sourceStationId,
      if (destinationStationId != null)
        'destination_station_id': destinationStationId,
      if (operatingDaysMask != null) 'operating_days_mask': operatingDaysMask,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TripsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? trainNumber,
    Value<String>? lineId,
    Value<String>? direction,
    Value<String>? serviceType,
    Value<String>? sourceStationId,
    Value<String>? destinationStationId,
    Value<int>? operatingDaysMask,
    Value<int>? rowid,
  }) {
    return TripsTableCompanion(
      id: id ?? this.id,
      trainNumber: trainNumber ?? this.trainNumber,
      lineId: lineId ?? this.lineId,
      direction: direction ?? this.direction,
      serviceType: serviceType ?? this.serviceType,
      sourceStationId: sourceStationId ?? this.sourceStationId,
      destinationStationId: destinationStationId ?? this.destinationStationId,
      operatingDaysMask: operatingDaysMask ?? this.operatingDaysMask,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (trainNumber.present) {
      map['train_number'] = Variable<String>(trainNumber.value);
    }
    if (lineId.present) {
      map['line_id'] = Variable<String>(lineId.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (serviceType.present) {
      map['service_type'] = Variable<String>(serviceType.value);
    }
    if (sourceStationId.present) {
      map['source_station_id'] = Variable<String>(sourceStationId.value);
    }
    if (destinationStationId.present) {
      map['destination_station_id'] = Variable<String>(
        destinationStationId.value,
      );
    }
    if (operatingDaysMask.present) {
      map['operating_days_mask'] = Variable<int>(operatingDaysMask.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripsTableCompanion(')
          ..write('id: $id, ')
          ..write('trainNumber: $trainNumber, ')
          ..write('lineId: $lineId, ')
          ..write('direction: $direction, ')
          ..write('serviceType: $serviceType, ')
          ..write('sourceStationId: $sourceStationId, ')
          ..write('destinationStationId: $destinationStationId, ')
          ..write('operatingDaysMask: $operatingDaysMask, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StopSchedulesTableTable extends StopSchedulesTable
    with TableInfo<$StopSchedulesTableTable, StopSchedulesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StopSchedulesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<String> tripId = GeneratedColumn<String>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stationIdMeta = const VerificationMeta(
    'stationId',
  );
  @override
  late final GeneratedColumn<String> stationId = GeneratedColumn<String>(
    'station_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stopSequenceMeta = const VerificationMeta(
    'stopSequence',
  );
  @override
  late final GeneratedColumn<int> stopSequence = GeneratedColumn<int>(
    'stop_sequence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arrivalMinutesMeta = const VerificationMeta(
    'arrivalMinutes',
  );
  @override
  late final GeneratedColumn<int> arrivalMinutes = GeneratedColumn<int>(
    'arrival_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _departureMinutesMeta = const VerificationMeta(
    'departureMinutes',
  );
  @override
  late final GeneratedColumn<int> departureMinutes = GeneratedColumn<int>(
    'departure_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tripId,
    stationId,
    stopSequence,
    arrivalMinutes,
    departureMinutes,
    platform,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stop_schedules';
  @override
  VerificationContext validateIntegrity(
    Insertable<StopSchedulesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('station_id')) {
      context.handle(
        _stationIdMeta,
        stationId.isAcceptableOrUnknown(data['station_id']!, _stationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_stationIdMeta);
    }
    if (data.containsKey('stop_sequence')) {
      context.handle(
        _stopSequenceMeta,
        stopSequence.isAcceptableOrUnknown(
          data['stop_sequence']!,
          _stopSequenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stopSequenceMeta);
    }
    if (data.containsKey('arrival_minutes')) {
      context.handle(
        _arrivalMinutesMeta,
        arrivalMinutes.isAcceptableOrUnknown(
          data['arrival_minutes']!,
          _arrivalMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arrivalMinutesMeta);
    }
    if (data.containsKey('departure_minutes')) {
      context.handle(
        _departureMinutesMeta,
        departureMinutes.isAcceptableOrUnknown(
          data['departure_minutes']!,
          _departureMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_departureMinutesMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StopSchedulesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StopSchedulesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trip_id'],
      )!,
      stationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}station_id'],
      )!,
      stopSequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stop_sequence'],
      )!,
      arrivalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}arrival_minutes'],
      )!,
      departureMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}departure_minutes'],
      )!,
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      ),
    );
  }

  @override
  $StopSchedulesTableTable createAlias(String alias) {
    return $StopSchedulesTableTable(attachedDatabase, alias);
  }
}

class StopSchedulesTableData extends DataClass
    implements Insertable<StopSchedulesTableData> {
  final int id;
  final String tripId;
  final String stationId;
  final int stopSequence;
  final int arrivalMinutes;
  final int departureMinutes;
  final String? platform;
  const StopSchedulesTableData({
    required this.id,
    required this.tripId,
    required this.stationId,
    required this.stopSequence,
    required this.arrivalMinutes,
    required this.departureMinutes,
    this.platform,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trip_id'] = Variable<String>(tripId);
    map['station_id'] = Variable<String>(stationId);
    map['stop_sequence'] = Variable<int>(stopSequence);
    map['arrival_minutes'] = Variable<int>(arrivalMinutes);
    map['departure_minutes'] = Variable<int>(departureMinutes);
    if (!nullToAbsent || platform != null) {
      map['platform'] = Variable<String>(platform);
    }
    return map;
  }

  StopSchedulesTableCompanion toCompanion(bool nullToAbsent) {
    return StopSchedulesTableCompanion(
      id: Value(id),
      tripId: Value(tripId),
      stationId: Value(stationId),
      stopSequence: Value(stopSequence),
      arrivalMinutes: Value(arrivalMinutes),
      departureMinutes: Value(departureMinutes),
      platform: platform == null && nullToAbsent
          ? const Value.absent()
          : Value(platform),
    );
  }

  factory StopSchedulesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StopSchedulesTableData(
      id: serializer.fromJson<int>(json['id']),
      tripId: serializer.fromJson<String>(json['tripId']),
      stationId: serializer.fromJson<String>(json['stationId']),
      stopSequence: serializer.fromJson<int>(json['stopSequence']),
      arrivalMinutes: serializer.fromJson<int>(json['arrivalMinutes']),
      departureMinutes: serializer.fromJson<int>(json['departureMinutes']),
      platform: serializer.fromJson<String?>(json['platform']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tripId': serializer.toJson<String>(tripId),
      'stationId': serializer.toJson<String>(stationId),
      'stopSequence': serializer.toJson<int>(stopSequence),
      'arrivalMinutes': serializer.toJson<int>(arrivalMinutes),
      'departureMinutes': serializer.toJson<int>(departureMinutes),
      'platform': serializer.toJson<String?>(platform),
    };
  }

  StopSchedulesTableData copyWith({
    int? id,
    String? tripId,
    String? stationId,
    int? stopSequence,
    int? arrivalMinutes,
    int? departureMinutes,
    Value<String?> platform = const Value.absent(),
  }) => StopSchedulesTableData(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    stationId: stationId ?? this.stationId,
    stopSequence: stopSequence ?? this.stopSequence,
    arrivalMinutes: arrivalMinutes ?? this.arrivalMinutes,
    departureMinutes: departureMinutes ?? this.departureMinutes,
    platform: platform.present ? platform.value : this.platform,
  );
  StopSchedulesTableData copyWithCompanion(StopSchedulesTableCompanion data) {
    return StopSchedulesTableData(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      stationId: data.stationId.present ? data.stationId.value : this.stationId,
      stopSequence: data.stopSequence.present
          ? data.stopSequence.value
          : this.stopSequence,
      arrivalMinutes: data.arrivalMinutes.present
          ? data.arrivalMinutes.value
          : this.arrivalMinutes,
      departureMinutes: data.departureMinutes.present
          ? data.departureMinutes.value
          : this.departureMinutes,
      platform: data.platform.present ? data.platform.value : this.platform,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StopSchedulesTableData(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('stationId: $stationId, ')
          ..write('stopSequence: $stopSequence, ')
          ..write('arrivalMinutes: $arrivalMinutes, ')
          ..write('departureMinutes: $departureMinutes, ')
          ..write('platform: $platform')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tripId,
    stationId,
    stopSequence,
    arrivalMinutes,
    departureMinutes,
    platform,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StopSchedulesTableData &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.stationId == this.stationId &&
          other.stopSequence == this.stopSequence &&
          other.arrivalMinutes == this.arrivalMinutes &&
          other.departureMinutes == this.departureMinutes &&
          other.platform == this.platform);
}

class StopSchedulesTableCompanion
    extends UpdateCompanion<StopSchedulesTableData> {
  final Value<int> id;
  final Value<String> tripId;
  final Value<String> stationId;
  final Value<int> stopSequence;
  final Value<int> arrivalMinutes;
  final Value<int> departureMinutes;
  final Value<String?> platform;
  const StopSchedulesTableCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.stationId = const Value.absent(),
    this.stopSequence = const Value.absent(),
    this.arrivalMinutes = const Value.absent(),
    this.departureMinutes = const Value.absent(),
    this.platform = const Value.absent(),
  });
  StopSchedulesTableCompanion.insert({
    this.id = const Value.absent(),
    required String tripId,
    required String stationId,
    required int stopSequence,
    required int arrivalMinutes,
    required int departureMinutes,
    this.platform = const Value.absent(),
  }) : tripId = Value(tripId),
       stationId = Value(stationId),
       stopSequence = Value(stopSequence),
       arrivalMinutes = Value(arrivalMinutes),
       departureMinutes = Value(departureMinutes);
  static Insertable<StopSchedulesTableData> custom({
    Expression<int>? id,
    Expression<String>? tripId,
    Expression<String>? stationId,
    Expression<int>? stopSequence,
    Expression<int>? arrivalMinutes,
    Expression<int>? departureMinutes,
    Expression<String>? platform,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (stationId != null) 'station_id': stationId,
      if (stopSequence != null) 'stop_sequence': stopSequence,
      if (arrivalMinutes != null) 'arrival_minutes': arrivalMinutes,
      if (departureMinutes != null) 'departure_minutes': departureMinutes,
      if (platform != null) 'platform': platform,
    });
  }

  StopSchedulesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? tripId,
    Value<String>? stationId,
    Value<int>? stopSequence,
    Value<int>? arrivalMinutes,
    Value<int>? departureMinutes,
    Value<String?>? platform,
  }) {
    return StopSchedulesTableCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      stationId: stationId ?? this.stationId,
      stopSequence: stopSequence ?? this.stopSequence,
      arrivalMinutes: arrivalMinutes ?? this.arrivalMinutes,
      departureMinutes: departureMinutes ?? this.departureMinutes,
      platform: platform ?? this.platform,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<String>(tripId.value);
    }
    if (stationId.present) {
      map['station_id'] = Variable<String>(stationId.value);
    }
    if (stopSequence.present) {
      map['stop_sequence'] = Variable<int>(stopSequence.value);
    }
    if (arrivalMinutes.present) {
      map['arrival_minutes'] = Variable<int>(arrivalMinutes.value);
    }
    if (departureMinutes.present) {
      map['departure_minutes'] = Variable<int>(departureMinutes.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StopSchedulesTableCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('stationId: $stationId, ')
          ..write('stopSequence: $stopSequence, ')
          ..write('arrivalMinutes: $arrivalMinutes, ')
          ..write('departureMinutes: $departureMinutes, ')
          ..write('platform: $platform')
          ..write(')'))
        .toString();
  }
}

class $DatasetMetadataTableTable extends DatasetMetadataTable
    with TableInfo<$DatasetMetadataTableTable, DatasetMetadataTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DatasetMetadataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dataset_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<DatasetMetadataTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  DatasetMetadataTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DatasetMetadataTableData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $DatasetMetadataTableTable createAlias(String alias) {
    return $DatasetMetadataTableTable(attachedDatabase, alias);
  }
}

class DatasetMetadataTableData extends DataClass
    implements Insertable<DatasetMetadataTableData> {
  final String key;
  final String value;
  const DatasetMetadataTableData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  DatasetMetadataTableCompanion toCompanion(bool nullToAbsent) {
    return DatasetMetadataTableCompanion(key: Value(key), value: Value(value));
  }

  factory DatasetMetadataTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DatasetMetadataTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  DatasetMetadataTableData copyWith({String? key, String? value}) =>
      DatasetMetadataTableData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  DatasetMetadataTableData copyWithCompanion(
    DatasetMetadataTableCompanion data,
  ) {
    return DatasetMetadataTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DatasetMetadataTableData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DatasetMetadataTableData &&
          other.key == this.key &&
          other.value == this.value);
}

class DatasetMetadataTableCompanion
    extends UpdateCompanion<DatasetMetadataTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const DatasetMetadataTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DatasetMetadataTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<DatasetMetadataTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DatasetMetadataTableCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return DatasetMetadataTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DatasetMetadataTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StationsTableTable stationsTable = $StationsTableTable(this);
  late final $TripsTableTable tripsTable = $TripsTableTable(this);
  late final $StopSchedulesTableTable stopSchedulesTable =
      $StopSchedulesTableTable(this);
  late final $DatasetMetadataTableTable datasetMetadataTable =
      $DatasetMetadataTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    stationsTable,
    tripsTable,
    stopSchedulesTable,
    datasetMetadataTable,
  ];
}

typedef $$StationsTableTableCreateCompanionBuilder =
    StationsTableCompanion Function({
      required String id,
      required String code,
      required String nameEn,
      required String nameHi,
      required String nameMr,
      required double latitude,
      required double longitude,
      required String linesJson,
      Value<bool> isInterchange,
      Value<int> rowid,
    });
typedef $$StationsTableTableUpdateCompanionBuilder =
    StationsTableCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> nameEn,
      Value<String> nameHi,
      Value<String> nameMr,
      Value<double> latitude,
      Value<double> longitude,
      Value<String> linesJson,
      Value<bool> isInterchange,
      Value<int> rowid,
    });

class $$StationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $StationsTableTable> {
  $$StationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameHi => $composableBuilder(
    column: $table.nameHi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameMr => $composableBuilder(
    column: $table.nameMr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linesJson => $composableBuilder(
    column: $table.linesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isInterchange => $composableBuilder(
    column: $table.isInterchange,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $StationsTableTable> {
  $$StationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameHi => $composableBuilder(
    column: $table.nameHi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameMr => $composableBuilder(
    column: $table.nameMr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linesJson => $composableBuilder(
    column: $table.linesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isInterchange => $composableBuilder(
    column: $table.isInterchange,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $StationsTableTable> {
  $$StationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameHi =>
      $composableBuilder(column: $table.nameHi, builder: (column) => column);

  GeneratedColumn<String> get nameMr =>
      $composableBuilder(column: $table.nameMr, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get linesJson =>
      $composableBuilder(column: $table.linesJson, builder: (column) => column);

  GeneratedColumn<bool> get isInterchange => $composableBuilder(
    column: $table.isInterchange,
    builder: (column) => column,
  );
}

class $$StationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StationsTableTable,
          StationsTableData,
          $$StationsTableTableFilterComposer,
          $$StationsTableTableOrderingComposer,
          $$StationsTableTableAnnotationComposer,
          $$StationsTableTableCreateCompanionBuilder,
          $$StationsTableTableUpdateCompanionBuilder,
          (
            StationsTableData,
            BaseReferences<
              _$AppDatabase,
              $StationsTableTable,
              StationsTableData
            >,
          ),
          StationsTableData,
          PrefetchHooks Function()
        > {
  $$StationsTableTableTableManager(_$AppDatabase db, $StationsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StationsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameHi = const Value.absent(),
                Value<String> nameMr = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String> linesJson = const Value.absent(),
                Value<bool> isInterchange = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StationsTableCompanion(
                id: id,
                code: code,
                nameEn: nameEn,
                nameHi: nameHi,
                nameMr: nameMr,
                latitude: latitude,
                longitude: longitude,
                linesJson: linesJson,
                isInterchange: isInterchange,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String nameEn,
                required String nameHi,
                required String nameMr,
                required double latitude,
                required double longitude,
                required String linesJson,
                Value<bool> isInterchange = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StationsTableCompanion.insert(
                id: id,
                code: code,
                nameEn: nameEn,
                nameHi: nameHi,
                nameMr: nameMr,
                latitude: latitude,
                longitude: longitude,
                linesJson: linesJson,
                isInterchange: isInterchange,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StationsTableTable,
      StationsTableData,
      $$StationsTableTableFilterComposer,
      $$StationsTableTableOrderingComposer,
      $$StationsTableTableAnnotationComposer,
      $$StationsTableTableCreateCompanionBuilder,
      $$StationsTableTableUpdateCompanionBuilder,
      (
        StationsTableData,
        BaseReferences<_$AppDatabase, $StationsTableTable, StationsTableData>,
      ),
      StationsTableData,
      PrefetchHooks Function()
    >;
typedef $$TripsTableTableCreateCompanionBuilder =
    TripsTableCompanion Function({
      required String id,
      required String trainNumber,
      required String lineId,
      required String direction,
      required String serviceType,
      required String sourceStationId,
      required String destinationStationId,
      Value<int> operatingDaysMask,
      Value<int> rowid,
    });
typedef $$TripsTableTableUpdateCompanionBuilder =
    TripsTableCompanion Function({
      Value<String> id,
      Value<String> trainNumber,
      Value<String> lineId,
      Value<String> direction,
      Value<String> serviceType,
      Value<String> sourceStationId,
      Value<String> destinationStationId,
      Value<int> operatingDaysMask,
      Value<int> rowid,
    });

class $$TripsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TripsTableTable> {
  $$TripsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trainNumber => $composableBuilder(
    column: $table.trainNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lineId => $composableBuilder(
    column: $table.lineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceStationId => $composableBuilder(
    column: $table.sourceStationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destinationStationId => $composableBuilder(
    column: $table.destinationStationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get operatingDaysMask => $composableBuilder(
    column: $table.operatingDaysMask,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TripsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TripsTableTable> {
  $$TripsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trainNumber => $composableBuilder(
    column: $table.trainNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lineId => $composableBuilder(
    column: $table.lineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceStationId => $composableBuilder(
    column: $table.sourceStationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinationStationId => $composableBuilder(
    column: $table.destinationStationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get operatingDaysMask => $composableBuilder(
    column: $table.operatingDaysMask,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TripsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripsTableTable> {
  $$TripsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get trainNumber => $composableBuilder(
    column: $table.trainNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lineId =>
      $composableBuilder(column: $table.lineId, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceStationId => $composableBuilder(
    column: $table.sourceStationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get destinationStationId => $composableBuilder(
    column: $table.destinationStationId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get operatingDaysMask => $composableBuilder(
    column: $table.operatingDaysMask,
    builder: (column) => column,
  );
}

class $$TripsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TripsTableTable,
          TripsTableData,
          $$TripsTableTableFilterComposer,
          $$TripsTableTableOrderingComposer,
          $$TripsTableTableAnnotationComposer,
          $$TripsTableTableCreateCompanionBuilder,
          $$TripsTableTableUpdateCompanionBuilder,
          (
            TripsTableData,
            BaseReferences<_$AppDatabase, $TripsTableTable, TripsTableData>,
          ),
          TripsTableData,
          PrefetchHooks Function()
        > {
  $$TripsTableTableTableManager(_$AppDatabase db, $TripsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> trainNumber = const Value.absent(),
                Value<String> lineId = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<String> serviceType = const Value.absent(),
                Value<String> sourceStationId = const Value.absent(),
                Value<String> destinationStationId = const Value.absent(),
                Value<int> operatingDaysMask = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TripsTableCompanion(
                id: id,
                trainNumber: trainNumber,
                lineId: lineId,
                direction: direction,
                serviceType: serviceType,
                sourceStationId: sourceStationId,
                destinationStationId: destinationStationId,
                operatingDaysMask: operatingDaysMask,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String trainNumber,
                required String lineId,
                required String direction,
                required String serviceType,
                required String sourceStationId,
                required String destinationStationId,
                Value<int> operatingDaysMask = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TripsTableCompanion.insert(
                id: id,
                trainNumber: trainNumber,
                lineId: lineId,
                direction: direction,
                serviceType: serviceType,
                sourceStationId: sourceStationId,
                destinationStationId: destinationStationId,
                operatingDaysMask: operatingDaysMask,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TripsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TripsTableTable,
      TripsTableData,
      $$TripsTableTableFilterComposer,
      $$TripsTableTableOrderingComposer,
      $$TripsTableTableAnnotationComposer,
      $$TripsTableTableCreateCompanionBuilder,
      $$TripsTableTableUpdateCompanionBuilder,
      (
        TripsTableData,
        BaseReferences<_$AppDatabase, $TripsTableTable, TripsTableData>,
      ),
      TripsTableData,
      PrefetchHooks Function()
    >;
typedef $$StopSchedulesTableTableCreateCompanionBuilder =
    StopSchedulesTableCompanion Function({
      Value<int> id,
      required String tripId,
      required String stationId,
      required int stopSequence,
      required int arrivalMinutes,
      required int departureMinutes,
      Value<String?> platform,
    });
typedef $$StopSchedulesTableTableUpdateCompanionBuilder =
    StopSchedulesTableCompanion Function({
      Value<int> id,
      Value<String> tripId,
      Value<String> stationId,
      Value<int> stopSequence,
      Value<int> arrivalMinutes,
      Value<int> departureMinutes,
      Value<String?> platform,
    });

class $$StopSchedulesTableTableFilterComposer
    extends Composer<_$AppDatabase, $StopSchedulesTableTable> {
  $$StopSchedulesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stationId => $composableBuilder(
    column: $table.stationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stopSequence => $composableBuilder(
    column: $table.stopSequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get arrivalMinutes => $composableBuilder(
    column: $table.arrivalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get departureMinutes => $composableBuilder(
    column: $table.departureMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StopSchedulesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $StopSchedulesTableTable> {
  $$StopSchedulesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tripId => $composableBuilder(
    column: $table.tripId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stationId => $composableBuilder(
    column: $table.stationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stopSequence => $composableBuilder(
    column: $table.stopSequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get arrivalMinutes => $composableBuilder(
    column: $table.arrivalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get departureMinutes => $composableBuilder(
    column: $table.departureMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StopSchedulesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $StopSchedulesTableTable> {
  $$StopSchedulesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tripId =>
      $composableBuilder(column: $table.tripId, builder: (column) => column);

  GeneratedColumn<String> get stationId =>
      $composableBuilder(column: $table.stationId, builder: (column) => column);

  GeneratedColumn<int> get stopSequence => $composableBuilder(
    column: $table.stopSequence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get arrivalMinutes => $composableBuilder(
    column: $table.arrivalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get departureMinutes => $composableBuilder(
    column: $table.departureMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);
}

class $$StopSchedulesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StopSchedulesTableTable,
          StopSchedulesTableData,
          $$StopSchedulesTableTableFilterComposer,
          $$StopSchedulesTableTableOrderingComposer,
          $$StopSchedulesTableTableAnnotationComposer,
          $$StopSchedulesTableTableCreateCompanionBuilder,
          $$StopSchedulesTableTableUpdateCompanionBuilder,
          (
            StopSchedulesTableData,
            BaseReferences<
              _$AppDatabase,
              $StopSchedulesTableTable,
              StopSchedulesTableData
            >,
          ),
          StopSchedulesTableData,
          PrefetchHooks Function()
        > {
  $$StopSchedulesTableTableTableManager(
    _$AppDatabase db,
    $StopSchedulesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StopSchedulesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StopSchedulesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StopSchedulesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tripId = const Value.absent(),
                Value<String> stationId = const Value.absent(),
                Value<int> stopSequence = const Value.absent(),
                Value<int> arrivalMinutes = const Value.absent(),
                Value<int> departureMinutes = const Value.absent(),
                Value<String?> platform = const Value.absent(),
              }) => StopSchedulesTableCompanion(
                id: id,
                tripId: tripId,
                stationId: stationId,
                stopSequence: stopSequence,
                arrivalMinutes: arrivalMinutes,
                departureMinutes: departureMinutes,
                platform: platform,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tripId,
                required String stationId,
                required int stopSequence,
                required int arrivalMinutes,
                required int departureMinutes,
                Value<String?> platform = const Value.absent(),
              }) => StopSchedulesTableCompanion.insert(
                id: id,
                tripId: tripId,
                stationId: stationId,
                stopSequence: stopSequence,
                arrivalMinutes: arrivalMinutes,
                departureMinutes: departureMinutes,
                platform: platform,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StopSchedulesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StopSchedulesTableTable,
      StopSchedulesTableData,
      $$StopSchedulesTableTableFilterComposer,
      $$StopSchedulesTableTableOrderingComposer,
      $$StopSchedulesTableTableAnnotationComposer,
      $$StopSchedulesTableTableCreateCompanionBuilder,
      $$StopSchedulesTableTableUpdateCompanionBuilder,
      (
        StopSchedulesTableData,
        BaseReferences<
          _$AppDatabase,
          $StopSchedulesTableTable,
          StopSchedulesTableData
        >,
      ),
      StopSchedulesTableData,
      PrefetchHooks Function()
    >;
typedef $$DatasetMetadataTableTableCreateCompanionBuilder =
    DatasetMetadataTableCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$DatasetMetadataTableTableUpdateCompanionBuilder =
    DatasetMetadataTableCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$DatasetMetadataTableTableFilterComposer
    extends Composer<_$AppDatabase, $DatasetMetadataTableTable> {
  $$DatasetMetadataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DatasetMetadataTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DatasetMetadataTableTable> {
  $$DatasetMetadataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DatasetMetadataTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DatasetMetadataTableTable> {
  $$DatasetMetadataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$DatasetMetadataTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DatasetMetadataTableTable,
          DatasetMetadataTableData,
          $$DatasetMetadataTableTableFilterComposer,
          $$DatasetMetadataTableTableOrderingComposer,
          $$DatasetMetadataTableTableAnnotationComposer,
          $$DatasetMetadataTableTableCreateCompanionBuilder,
          $$DatasetMetadataTableTableUpdateCompanionBuilder,
          (
            DatasetMetadataTableData,
            BaseReferences<
              _$AppDatabase,
              $DatasetMetadataTableTable,
              DatasetMetadataTableData
            >,
          ),
          DatasetMetadataTableData,
          PrefetchHooks Function()
        > {
  $$DatasetMetadataTableTableTableManager(
    _$AppDatabase db,
    $DatasetMetadataTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DatasetMetadataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DatasetMetadataTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DatasetMetadataTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DatasetMetadataTableCompanion(
                key: key,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => DatasetMetadataTableCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DatasetMetadataTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DatasetMetadataTableTable,
      DatasetMetadataTableData,
      $$DatasetMetadataTableTableFilterComposer,
      $$DatasetMetadataTableTableOrderingComposer,
      $$DatasetMetadataTableTableAnnotationComposer,
      $$DatasetMetadataTableTableCreateCompanionBuilder,
      $$DatasetMetadataTableTableUpdateCompanionBuilder,
      (
        DatasetMetadataTableData,
        BaseReferences<
          _$AppDatabase,
          $DatasetMetadataTableTable,
          DatasetMetadataTableData
        >,
      ),
      DatasetMetadataTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StationsTableTableTableManager get stationsTable =>
      $$StationsTableTableTableManager(_db, _db.stationsTable);
  $$TripsTableTableTableManager get tripsTable =>
      $$TripsTableTableTableManager(_db, _db.tripsTable);
  $$StopSchedulesTableTableTableManager get stopSchedulesTable =>
      $$StopSchedulesTableTableTableManager(_db, _db.stopSchedulesTable);
  $$DatasetMetadataTableTableTableManager get datasetMetadataTable =>
      $$DatasetMetadataTableTableTableManager(_db, _db.datasetMetadataTable);
}
