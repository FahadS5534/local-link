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

class $SavedJourneysTableTable extends SavedJourneysTable
    with TableInfo<$SavedJourneysTableTable, SavedJourneysTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedJourneysTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originStationIdMeta = const VerificationMeta(
    'originStationId',
  );
  @override
  late final GeneratedColumn<String> originStationId = GeneratedColumn<String>(
    'origin_station_id',
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
  static const VerificationMeta _isPinnedMeta = const VerificationMeta(
    'isPinned',
  );
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
    'is_pinned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pinned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    label,
    originStationId,
    destinationStationId,
    isPinned,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_journeys';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedJourneysTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('origin_station_id')) {
      context.handle(
        _originStationIdMeta,
        originStationId.isAcceptableOrUnknown(
          data['origin_station_id']!,
          _originStationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originStationIdMeta);
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
    if (data.containsKey('is_pinned')) {
      context.handle(
        _isPinnedMeta,
        isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedJourneysTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedJourneysTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      originStationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_station_id'],
      )!,
      destinationStationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_station_id'],
      )!,
      isPinned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pinned'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SavedJourneysTableTable createAlias(String alias) {
    return $SavedJourneysTableTable(attachedDatabase, alias);
  }
}

class SavedJourneysTableData extends DataClass
    implements Insertable<SavedJourneysTableData> {
  final String id;
  final String label;
  final String originStationId;
  final String destinationStationId;
  final bool isPinned;
  final DateTime createdAt;
  const SavedJourneysTableData({
    required this.id,
    required this.label,
    required this.originStationId,
    required this.destinationStationId,
    required this.isPinned,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    map['origin_station_id'] = Variable<String>(originStationId);
    map['destination_station_id'] = Variable<String>(destinationStationId);
    map['is_pinned'] = Variable<bool>(isPinned);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SavedJourneysTableCompanion toCompanion(bool nullToAbsent) {
    return SavedJourneysTableCompanion(
      id: Value(id),
      label: Value(label),
      originStationId: Value(originStationId),
      destinationStationId: Value(destinationStationId),
      isPinned: Value(isPinned),
      createdAt: Value(createdAt),
    );
  }

  factory SavedJourneysTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedJourneysTableData(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      originStationId: serializer.fromJson<String>(json['originStationId']),
      destinationStationId: serializer.fromJson<String>(
        json['destinationStationId'],
      ),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'originStationId': serializer.toJson<String>(originStationId),
      'destinationStationId': serializer.toJson<String>(destinationStationId),
      'isPinned': serializer.toJson<bool>(isPinned),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SavedJourneysTableData copyWith({
    String? id,
    String? label,
    String? originStationId,
    String? destinationStationId,
    bool? isPinned,
    DateTime? createdAt,
  }) => SavedJourneysTableData(
    id: id ?? this.id,
    label: label ?? this.label,
    originStationId: originStationId ?? this.originStationId,
    destinationStationId: destinationStationId ?? this.destinationStationId,
    isPinned: isPinned ?? this.isPinned,
    createdAt: createdAt ?? this.createdAt,
  );
  SavedJourneysTableData copyWithCompanion(SavedJourneysTableCompanion data) {
    return SavedJourneysTableData(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      originStationId: data.originStationId.present
          ? data.originStationId.value
          : this.originStationId,
      destinationStationId: data.destinationStationId.present
          ? data.destinationStationId.value
          : this.destinationStationId,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedJourneysTableData(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('originStationId: $originStationId, ')
          ..write('destinationStationId: $destinationStationId, ')
          ..write('isPinned: $isPinned, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    label,
    originStationId,
    destinationStationId,
    isPinned,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedJourneysTableData &&
          other.id == this.id &&
          other.label == this.label &&
          other.originStationId == this.originStationId &&
          other.destinationStationId == this.destinationStationId &&
          other.isPinned == this.isPinned &&
          other.createdAt == this.createdAt);
}

class SavedJourneysTableCompanion
    extends UpdateCompanion<SavedJourneysTableData> {
  final Value<String> id;
  final Value<String> label;
  final Value<String> originStationId;
  final Value<String> destinationStationId;
  final Value<bool> isPinned;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SavedJourneysTableCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.originStationId = const Value.absent(),
    this.destinationStationId = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedJourneysTableCompanion.insert({
    required String id,
    required String label,
    required String originStationId,
    required String destinationStationId,
    this.isPinned = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       label = Value(label),
       originStationId = Value(originStationId),
       destinationStationId = Value(destinationStationId),
       createdAt = Value(createdAt);
  static Insertable<SavedJourneysTableData> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<String>? originStationId,
    Expression<String>? destinationStationId,
    Expression<bool>? isPinned,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (originStationId != null) 'origin_station_id': originStationId,
      if (destinationStationId != null)
        'destination_station_id': destinationStationId,
      if (isPinned != null) 'is_pinned': isPinned,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedJourneysTableCompanion copyWith({
    Value<String>? id,
    Value<String>? label,
    Value<String>? originStationId,
    Value<String>? destinationStationId,
    Value<bool>? isPinned,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SavedJourneysTableCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      originStationId: originStationId ?? this.originStationId,
      destinationStationId: destinationStationId ?? this.destinationStationId,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (originStationId.present) {
      map['origin_station_id'] = Variable<String>(originStationId.value);
    }
    if (destinationStationId.present) {
      map['destination_station_id'] = Variable<String>(
        destinationStationId.value,
      );
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedJourneysTableCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('originStationId: $originStationId, ')
          ..write('destinationStationId: $destinationStationId, ')
          ..write('isPinned: $isPinned, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JourneyHistoryTableTable extends JourneyHistoryTable
    with TableInfo<$JourneyHistoryTableTable, JourneyHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JourneyHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originStationIdMeta = const VerificationMeta(
    'originStationId',
  );
  @override
  late final GeneratedColumn<String> originStationId = GeneratedColumn<String>(
    'origin_station_id',
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
  static const VerificationMeta _estimatedDurationMinutesMeta =
      const VerificationMeta('estimatedDurationMinutes');
  @override
  late final GeneratedColumn<int> estimatedDurationMinutes =
      GeneratedColumn<int>(
        'estimated_duration_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _queriedAtMeta = const VerificationMeta(
    'queriedAt',
  );
  @override
  late final GeneratedColumn<DateTime> queriedAt = GeneratedColumn<DateTime>(
    'queried_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    originStationId,
    destinationStationId,
    estimatedDurationMinutes,
    queriedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journey_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<JourneyHistoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('origin_station_id')) {
      context.handle(
        _originStationIdMeta,
        originStationId.isAcceptableOrUnknown(
          data['origin_station_id']!,
          _originStationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originStationIdMeta);
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
    if (data.containsKey('estimated_duration_minutes')) {
      context.handle(
        _estimatedDurationMinutesMeta,
        estimatedDurationMinutes.isAcceptableOrUnknown(
          data['estimated_duration_minutes']!,
          _estimatedDurationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedDurationMinutesMeta);
    }
    if (data.containsKey('queried_at')) {
      context.handle(
        _queriedAtMeta,
        queriedAt.isAcceptableOrUnknown(data['queried_at']!, _queriedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_queriedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JourneyHistoryTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JourneyHistoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      originStationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_station_id'],
      )!,
      destinationStationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_station_id'],
      )!,
      estimatedDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_duration_minutes'],
      )!,
      queriedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}queried_at'],
      )!,
    );
  }

  @override
  $JourneyHistoryTableTable createAlias(String alias) {
    return $JourneyHistoryTableTable(attachedDatabase, alias);
  }
}

class JourneyHistoryTableData extends DataClass
    implements Insertable<JourneyHistoryTableData> {
  final String id;
  final String originStationId;
  final String destinationStationId;
  final int estimatedDurationMinutes;
  final DateTime queriedAt;
  const JourneyHistoryTableData({
    required this.id,
    required this.originStationId,
    required this.destinationStationId,
    required this.estimatedDurationMinutes,
    required this.queriedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['origin_station_id'] = Variable<String>(originStationId);
    map['destination_station_id'] = Variable<String>(destinationStationId);
    map['estimated_duration_minutes'] = Variable<int>(estimatedDurationMinutes);
    map['queried_at'] = Variable<DateTime>(queriedAt);
    return map;
  }

  JourneyHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return JourneyHistoryTableCompanion(
      id: Value(id),
      originStationId: Value(originStationId),
      destinationStationId: Value(destinationStationId),
      estimatedDurationMinutes: Value(estimatedDurationMinutes),
      queriedAt: Value(queriedAt),
    );
  }

  factory JourneyHistoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JourneyHistoryTableData(
      id: serializer.fromJson<String>(json['id']),
      originStationId: serializer.fromJson<String>(json['originStationId']),
      destinationStationId: serializer.fromJson<String>(
        json['destinationStationId'],
      ),
      estimatedDurationMinutes: serializer.fromJson<int>(
        json['estimatedDurationMinutes'],
      ),
      queriedAt: serializer.fromJson<DateTime>(json['queriedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'originStationId': serializer.toJson<String>(originStationId),
      'destinationStationId': serializer.toJson<String>(destinationStationId),
      'estimatedDurationMinutes': serializer.toJson<int>(
        estimatedDurationMinutes,
      ),
      'queriedAt': serializer.toJson<DateTime>(queriedAt),
    };
  }

  JourneyHistoryTableData copyWith({
    String? id,
    String? originStationId,
    String? destinationStationId,
    int? estimatedDurationMinutes,
    DateTime? queriedAt,
  }) => JourneyHistoryTableData(
    id: id ?? this.id,
    originStationId: originStationId ?? this.originStationId,
    destinationStationId: destinationStationId ?? this.destinationStationId,
    estimatedDurationMinutes:
        estimatedDurationMinutes ?? this.estimatedDurationMinutes,
    queriedAt: queriedAt ?? this.queriedAt,
  );
  JourneyHistoryTableData copyWithCompanion(JourneyHistoryTableCompanion data) {
    return JourneyHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      originStationId: data.originStationId.present
          ? data.originStationId.value
          : this.originStationId,
      destinationStationId: data.destinationStationId.present
          ? data.destinationStationId.value
          : this.destinationStationId,
      estimatedDurationMinutes: data.estimatedDurationMinutes.present
          ? data.estimatedDurationMinutes.value
          : this.estimatedDurationMinutes,
      queriedAt: data.queriedAt.present ? data.queriedAt.value : this.queriedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JourneyHistoryTableData(')
          ..write('id: $id, ')
          ..write('originStationId: $originStationId, ')
          ..write('destinationStationId: $destinationStationId, ')
          ..write('estimatedDurationMinutes: $estimatedDurationMinutes, ')
          ..write('queriedAt: $queriedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    originStationId,
    destinationStationId,
    estimatedDurationMinutes,
    queriedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JourneyHistoryTableData &&
          other.id == this.id &&
          other.originStationId == this.originStationId &&
          other.destinationStationId == this.destinationStationId &&
          other.estimatedDurationMinutes == this.estimatedDurationMinutes &&
          other.queriedAt == this.queriedAt);
}

class JourneyHistoryTableCompanion
    extends UpdateCompanion<JourneyHistoryTableData> {
  final Value<String> id;
  final Value<String> originStationId;
  final Value<String> destinationStationId;
  final Value<int> estimatedDurationMinutes;
  final Value<DateTime> queriedAt;
  final Value<int> rowid;
  const JourneyHistoryTableCompanion({
    this.id = const Value.absent(),
    this.originStationId = const Value.absent(),
    this.destinationStationId = const Value.absent(),
    this.estimatedDurationMinutes = const Value.absent(),
    this.queriedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JourneyHistoryTableCompanion.insert({
    required String id,
    required String originStationId,
    required String destinationStationId,
    required int estimatedDurationMinutes,
    required DateTime queriedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       originStationId = Value(originStationId),
       destinationStationId = Value(destinationStationId),
       estimatedDurationMinutes = Value(estimatedDurationMinutes),
       queriedAt = Value(queriedAt);
  static Insertable<JourneyHistoryTableData> custom({
    Expression<String>? id,
    Expression<String>? originStationId,
    Expression<String>? destinationStationId,
    Expression<int>? estimatedDurationMinutes,
    Expression<DateTime>? queriedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (originStationId != null) 'origin_station_id': originStationId,
      if (destinationStationId != null)
        'destination_station_id': destinationStationId,
      if (estimatedDurationMinutes != null)
        'estimated_duration_minutes': estimatedDurationMinutes,
      if (queriedAt != null) 'queried_at': queriedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JourneyHistoryTableCompanion copyWith({
    Value<String>? id,
    Value<String>? originStationId,
    Value<String>? destinationStationId,
    Value<int>? estimatedDurationMinutes,
    Value<DateTime>? queriedAt,
    Value<int>? rowid,
  }) {
    return JourneyHistoryTableCompanion(
      id: id ?? this.id,
      originStationId: originStationId ?? this.originStationId,
      destinationStationId: destinationStationId ?? this.destinationStationId,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      queriedAt: queriedAt ?? this.queriedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (originStationId.present) {
      map['origin_station_id'] = Variable<String>(originStationId.value);
    }
    if (destinationStationId.present) {
      map['destination_station_id'] = Variable<String>(
        destinationStationId.value,
      );
    }
    if (estimatedDurationMinutes.present) {
      map['estimated_duration_minutes'] = Variable<int>(
        estimatedDurationMinutes.value,
      );
    }
    if (queriedAt.present) {
      map['queried_at'] = Variable<DateTime>(queriedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JourneyHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('originStationId: $originStationId, ')
          ..write('destinationStationId: $destinationStationId, ')
          ..write('estimatedDurationMinutes: $estimatedDurationMinutes, ')
          ..write('queriedAt: $queriedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServiceAdvisoriesTableTable extends ServiceAdvisoriesTable
    with TableInfo<$ServiceAdvisoriesTableTable, ServiceAdvisoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceAdvisoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _titleEnMeta = const VerificationMeta(
    'titleEn',
  );
  @override
  late final GeneratedColumn<String> titleEn = GeneratedColumn<String>(
    'title_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMrMeta = const VerificationMeta(
    'titleMr',
  );
  @override
  late final GeneratedColumn<String> titleMr = GeneratedColumn<String>(
    'title_mr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleHiMeta = const VerificationMeta(
    'titleHi',
  );
  @override
  late final GeneratedColumn<String> titleHi = GeneratedColumn<String>(
    'title_hi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionEnMeta = const VerificationMeta(
    'descriptionEn',
  );
  @override
  late final GeneratedColumn<String> descriptionEn = GeneratedColumn<String>(
    'description_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMrMeta = const VerificationMeta(
    'descriptionMr',
  );
  @override
  late final GeneratedColumn<String> descriptionMr = GeneratedColumn<String>(
    'description_mr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionHiMeta = const VerificationMeta(
    'descriptionHi',
  );
  @override
  late final GeneratedColumn<String> descriptionHi = GeneratedColumn<String>(
    'description_hi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effectiveFromMeta = const VerificationMeta(
    'effectiveFrom',
  );
  @override
  late final GeneratedColumn<DateTime> effectiveFrom =
      GeneratedColumn<DateTime>(
        'effective_from',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _effectiveUntilMeta = const VerificationMeta(
    'effectiveUntil',
  );
  @override
  late final GeneratedColumn<DateTime> effectiveUntil =
      GeneratedColumn<DateTime>(
        'effective_until',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta(
    'isVerified',
  );
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lineId,
    titleEn,
    titleMr,
    titleHi,
    descriptionEn,
    descriptionMr,
    descriptionHi,
    severity,
    effectiveFrom,
    effectiveUntil,
    isVerified,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_advisories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceAdvisoriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('line_id')) {
      context.handle(
        _lineIdMeta,
        lineId.isAcceptableOrUnknown(data['line_id']!, _lineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lineIdMeta);
    }
    if (data.containsKey('title_en')) {
      context.handle(
        _titleEnMeta,
        titleEn.isAcceptableOrUnknown(data['title_en']!, _titleEnMeta),
      );
    } else if (isInserting) {
      context.missing(_titleEnMeta);
    }
    if (data.containsKey('title_mr')) {
      context.handle(
        _titleMrMeta,
        titleMr.isAcceptableOrUnknown(data['title_mr']!, _titleMrMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMrMeta);
    }
    if (data.containsKey('title_hi')) {
      context.handle(
        _titleHiMeta,
        titleHi.isAcceptableOrUnknown(data['title_hi']!, _titleHiMeta),
      );
    } else if (isInserting) {
      context.missing(_titleHiMeta);
    }
    if (data.containsKey('description_en')) {
      context.handle(
        _descriptionEnMeta,
        descriptionEn.isAcceptableOrUnknown(
          data['description_en']!,
          _descriptionEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionEnMeta);
    }
    if (data.containsKey('description_mr')) {
      context.handle(
        _descriptionMrMeta,
        descriptionMr.isAcceptableOrUnknown(
          data['description_mr']!,
          _descriptionMrMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMrMeta);
    }
    if (data.containsKey('description_hi')) {
      context.handle(
        _descriptionHiMeta,
        descriptionHi.isAcceptableOrUnknown(
          data['description_hi']!,
          _descriptionHiMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionHiMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('effective_from')) {
      context.handle(
        _effectiveFromMeta,
        effectiveFrom.isAcceptableOrUnknown(
          data['effective_from']!,
          _effectiveFromMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveFromMeta);
    }
    if (data.containsKey('effective_until')) {
      context.handle(
        _effectiveUntilMeta,
        effectiveUntil.isAcceptableOrUnknown(
          data['effective_until']!,
          _effectiveUntilMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveUntilMeta);
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceAdvisoriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceAdvisoriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      lineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}line_id'],
      )!,
      titleEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_en'],
      )!,
      titleMr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_mr'],
      )!,
      titleHi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_hi'],
      )!,
      descriptionEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_en'],
      )!,
      descriptionMr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_mr'],
      )!,
      descriptionHi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_hi'],
      )!,
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}severity'],
      )!,
      effectiveFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}effective_from'],
      )!,
      effectiveUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}effective_until'],
      )!,
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
      )!,
    );
  }

  @override
  $ServiceAdvisoriesTableTable createAlias(String alias) {
    return $ServiceAdvisoriesTableTable(attachedDatabase, alias);
  }
}

class ServiceAdvisoriesTableData extends DataClass
    implements Insertable<ServiceAdvisoriesTableData> {
  final String id;
  final String lineId;
  final String titleEn;
  final String titleMr;
  final String titleHi;
  final String descriptionEn;
  final String descriptionMr;
  final String descriptionHi;
  final String severity;
  final DateTime effectiveFrom;
  final DateTime effectiveUntil;
  final bool isVerified;
  const ServiceAdvisoriesTableData({
    required this.id,
    required this.lineId,
    required this.titleEn,
    required this.titleMr,
    required this.titleHi,
    required this.descriptionEn,
    required this.descriptionMr,
    required this.descriptionHi,
    required this.severity,
    required this.effectiveFrom,
    required this.effectiveUntil,
    required this.isVerified,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['line_id'] = Variable<String>(lineId);
    map['title_en'] = Variable<String>(titleEn);
    map['title_mr'] = Variable<String>(titleMr);
    map['title_hi'] = Variable<String>(titleHi);
    map['description_en'] = Variable<String>(descriptionEn);
    map['description_mr'] = Variable<String>(descriptionMr);
    map['description_hi'] = Variable<String>(descriptionHi);
    map['severity'] = Variable<String>(severity);
    map['effective_from'] = Variable<DateTime>(effectiveFrom);
    map['effective_until'] = Variable<DateTime>(effectiveUntil);
    map['is_verified'] = Variable<bool>(isVerified);
    return map;
  }

  ServiceAdvisoriesTableCompanion toCompanion(bool nullToAbsent) {
    return ServiceAdvisoriesTableCompanion(
      id: Value(id),
      lineId: Value(lineId),
      titleEn: Value(titleEn),
      titleMr: Value(titleMr),
      titleHi: Value(titleHi),
      descriptionEn: Value(descriptionEn),
      descriptionMr: Value(descriptionMr),
      descriptionHi: Value(descriptionHi),
      severity: Value(severity),
      effectiveFrom: Value(effectiveFrom),
      effectiveUntil: Value(effectiveUntil),
      isVerified: Value(isVerified),
    );
  }

  factory ServiceAdvisoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceAdvisoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      lineId: serializer.fromJson<String>(json['lineId']),
      titleEn: serializer.fromJson<String>(json['titleEn']),
      titleMr: serializer.fromJson<String>(json['titleMr']),
      titleHi: serializer.fromJson<String>(json['titleHi']),
      descriptionEn: serializer.fromJson<String>(json['descriptionEn']),
      descriptionMr: serializer.fromJson<String>(json['descriptionMr']),
      descriptionHi: serializer.fromJson<String>(json['descriptionHi']),
      severity: serializer.fromJson<String>(json['severity']),
      effectiveFrom: serializer.fromJson<DateTime>(json['effectiveFrom']),
      effectiveUntil: serializer.fromJson<DateTime>(json['effectiveUntil']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lineId': serializer.toJson<String>(lineId),
      'titleEn': serializer.toJson<String>(titleEn),
      'titleMr': serializer.toJson<String>(titleMr),
      'titleHi': serializer.toJson<String>(titleHi),
      'descriptionEn': serializer.toJson<String>(descriptionEn),
      'descriptionMr': serializer.toJson<String>(descriptionMr),
      'descriptionHi': serializer.toJson<String>(descriptionHi),
      'severity': serializer.toJson<String>(severity),
      'effectiveFrom': serializer.toJson<DateTime>(effectiveFrom),
      'effectiveUntil': serializer.toJson<DateTime>(effectiveUntil),
      'isVerified': serializer.toJson<bool>(isVerified),
    };
  }

  ServiceAdvisoriesTableData copyWith({
    String? id,
    String? lineId,
    String? titleEn,
    String? titleMr,
    String? titleHi,
    String? descriptionEn,
    String? descriptionMr,
    String? descriptionHi,
    String? severity,
    DateTime? effectiveFrom,
    DateTime? effectiveUntil,
    bool? isVerified,
  }) => ServiceAdvisoriesTableData(
    id: id ?? this.id,
    lineId: lineId ?? this.lineId,
    titleEn: titleEn ?? this.titleEn,
    titleMr: titleMr ?? this.titleMr,
    titleHi: titleHi ?? this.titleHi,
    descriptionEn: descriptionEn ?? this.descriptionEn,
    descriptionMr: descriptionMr ?? this.descriptionMr,
    descriptionHi: descriptionHi ?? this.descriptionHi,
    severity: severity ?? this.severity,
    effectiveFrom: effectiveFrom ?? this.effectiveFrom,
    effectiveUntil: effectiveUntil ?? this.effectiveUntil,
    isVerified: isVerified ?? this.isVerified,
  );
  ServiceAdvisoriesTableData copyWithCompanion(
    ServiceAdvisoriesTableCompanion data,
  ) {
    return ServiceAdvisoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      lineId: data.lineId.present ? data.lineId.value : this.lineId,
      titleEn: data.titleEn.present ? data.titleEn.value : this.titleEn,
      titleMr: data.titleMr.present ? data.titleMr.value : this.titleMr,
      titleHi: data.titleHi.present ? data.titleHi.value : this.titleHi,
      descriptionEn: data.descriptionEn.present
          ? data.descriptionEn.value
          : this.descriptionEn,
      descriptionMr: data.descriptionMr.present
          ? data.descriptionMr.value
          : this.descriptionMr,
      descriptionHi: data.descriptionHi.present
          ? data.descriptionHi.value
          : this.descriptionHi,
      severity: data.severity.present ? data.severity.value : this.severity,
      effectiveFrom: data.effectiveFrom.present
          ? data.effectiveFrom.value
          : this.effectiveFrom,
      effectiveUntil: data.effectiveUntil.present
          ? data.effectiveUntil.value
          : this.effectiveUntil,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceAdvisoriesTableData(')
          ..write('id: $id, ')
          ..write('lineId: $lineId, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleMr: $titleMr, ')
          ..write('titleHi: $titleHi, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('descriptionMr: $descriptionMr, ')
          ..write('descriptionHi: $descriptionHi, ')
          ..write('severity: $severity, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('effectiveUntil: $effectiveUntil, ')
          ..write('isVerified: $isVerified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lineId,
    titleEn,
    titleMr,
    titleHi,
    descriptionEn,
    descriptionMr,
    descriptionHi,
    severity,
    effectiveFrom,
    effectiveUntil,
    isVerified,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceAdvisoriesTableData &&
          other.id == this.id &&
          other.lineId == this.lineId &&
          other.titleEn == this.titleEn &&
          other.titleMr == this.titleMr &&
          other.titleHi == this.titleHi &&
          other.descriptionEn == this.descriptionEn &&
          other.descriptionMr == this.descriptionMr &&
          other.descriptionHi == this.descriptionHi &&
          other.severity == this.severity &&
          other.effectiveFrom == this.effectiveFrom &&
          other.effectiveUntil == this.effectiveUntil &&
          other.isVerified == this.isVerified);
}

class ServiceAdvisoriesTableCompanion
    extends UpdateCompanion<ServiceAdvisoriesTableData> {
  final Value<String> id;
  final Value<String> lineId;
  final Value<String> titleEn;
  final Value<String> titleMr;
  final Value<String> titleHi;
  final Value<String> descriptionEn;
  final Value<String> descriptionMr;
  final Value<String> descriptionHi;
  final Value<String> severity;
  final Value<DateTime> effectiveFrom;
  final Value<DateTime> effectiveUntil;
  final Value<bool> isVerified;
  final Value<int> rowid;
  const ServiceAdvisoriesTableCompanion({
    this.id = const Value.absent(),
    this.lineId = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.titleMr = const Value.absent(),
    this.titleHi = const Value.absent(),
    this.descriptionEn = const Value.absent(),
    this.descriptionMr = const Value.absent(),
    this.descriptionHi = const Value.absent(),
    this.severity = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
    this.effectiveUntil = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServiceAdvisoriesTableCompanion.insert({
    required String id,
    required String lineId,
    required String titleEn,
    required String titleMr,
    required String titleHi,
    required String descriptionEn,
    required String descriptionMr,
    required String descriptionHi,
    required String severity,
    required DateTime effectiveFrom,
    required DateTime effectiveUntil,
    this.isVerified = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       lineId = Value(lineId),
       titleEn = Value(titleEn),
       titleMr = Value(titleMr),
       titleHi = Value(titleHi),
       descriptionEn = Value(descriptionEn),
       descriptionMr = Value(descriptionMr),
       descriptionHi = Value(descriptionHi),
       severity = Value(severity),
       effectiveFrom = Value(effectiveFrom),
       effectiveUntil = Value(effectiveUntil);
  static Insertable<ServiceAdvisoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? lineId,
    Expression<String>? titleEn,
    Expression<String>? titleMr,
    Expression<String>? titleHi,
    Expression<String>? descriptionEn,
    Expression<String>? descriptionMr,
    Expression<String>? descriptionHi,
    Expression<String>? severity,
    Expression<DateTime>? effectiveFrom,
    Expression<DateTime>? effectiveUntil,
    Expression<bool>? isVerified,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lineId != null) 'line_id': lineId,
      if (titleEn != null) 'title_en': titleEn,
      if (titleMr != null) 'title_mr': titleMr,
      if (titleHi != null) 'title_hi': titleHi,
      if (descriptionEn != null) 'description_en': descriptionEn,
      if (descriptionMr != null) 'description_mr': descriptionMr,
      if (descriptionHi != null) 'description_hi': descriptionHi,
      if (severity != null) 'severity': severity,
      if (effectiveFrom != null) 'effective_from': effectiveFrom,
      if (effectiveUntil != null) 'effective_until': effectiveUntil,
      if (isVerified != null) 'is_verified': isVerified,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServiceAdvisoriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? lineId,
    Value<String>? titleEn,
    Value<String>? titleMr,
    Value<String>? titleHi,
    Value<String>? descriptionEn,
    Value<String>? descriptionMr,
    Value<String>? descriptionHi,
    Value<String>? severity,
    Value<DateTime>? effectiveFrom,
    Value<DateTime>? effectiveUntil,
    Value<bool>? isVerified,
    Value<int>? rowid,
  }) {
    return ServiceAdvisoriesTableCompanion(
      id: id ?? this.id,
      lineId: lineId ?? this.lineId,
      titleEn: titleEn ?? this.titleEn,
      titleMr: titleMr ?? this.titleMr,
      titleHi: titleHi ?? this.titleHi,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionMr: descriptionMr ?? this.descriptionMr,
      descriptionHi: descriptionHi ?? this.descriptionHi,
      severity: severity ?? this.severity,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      effectiveUntil: effectiveUntil ?? this.effectiveUntil,
      isVerified: isVerified ?? this.isVerified,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lineId.present) {
      map['line_id'] = Variable<String>(lineId.value);
    }
    if (titleEn.present) {
      map['title_en'] = Variable<String>(titleEn.value);
    }
    if (titleMr.present) {
      map['title_mr'] = Variable<String>(titleMr.value);
    }
    if (titleHi.present) {
      map['title_hi'] = Variable<String>(titleHi.value);
    }
    if (descriptionEn.present) {
      map['description_en'] = Variable<String>(descriptionEn.value);
    }
    if (descriptionMr.present) {
      map['description_mr'] = Variable<String>(descriptionMr.value);
    }
    if (descriptionHi.present) {
      map['description_hi'] = Variable<String>(descriptionHi.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (effectiveFrom.present) {
      map['effective_from'] = Variable<DateTime>(effectiveFrom.value);
    }
    if (effectiveUntil.present) {
      map['effective_until'] = Variable<DateTime>(effectiveUntil.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceAdvisoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('lineId: $lineId, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleMr: $titleMr, ')
          ..write('titleHi: $titleHi, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('descriptionMr: $descriptionMr, ')
          ..write('descriptionHi: $descriptionHi, ')
          ..write('severity: $severity, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('effectiveUntil: $effectiveUntil, ')
          ..write('isVerified: $isVerified, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncHistoryTableTable extends SyncHistoryTable
    with TableInfo<$SyncHistoryTableTable, SyncHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncHistoryTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _datasetVersionMeta = const VerificationMeta(
    'datasetVersion',
  );
  @override
  late final GeneratedColumn<String> datasetVersion = GeneratedColumn<String>(
    'dataset_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checksumMeta = const VerificationMeta(
    'checksum',
  );
  @override
  late final GeneratedColumn<String> checksum = GeneratedColumn<String>(
    'checksum',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    datasetVersion,
    checksum,
    status,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncHistoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('dataset_version')) {
      context.handle(
        _datasetVersionMeta,
        datasetVersion.isAcceptableOrUnknown(
          data['dataset_version']!,
          _datasetVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_datasetVersionMeta);
    }
    if (data.containsKey('checksum')) {
      context.handle(
        _checksumMeta,
        checksum.isAcceptableOrUnknown(data['checksum']!, _checksumMeta),
      );
    } else if (isInserting) {
      context.missing(_checksumMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncHistoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncHistoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      datasetVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dataset_version'],
      )!,
      checksum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checksum'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
    );
  }

  @override
  $SyncHistoryTableTable createAlias(String alias) {
    return $SyncHistoryTableTable(attachedDatabase, alias);
  }
}

class SyncHistoryTableData extends DataClass
    implements Insertable<SyncHistoryTableData> {
  final int id;
  final String datasetVersion;
  final String checksum;
  final String status;
  final DateTime syncedAt;
  const SyncHistoryTableData({
    required this.id,
    required this.datasetVersion,
    required this.checksum,
    required this.status,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dataset_version'] = Variable<String>(datasetVersion);
    map['checksum'] = Variable<String>(checksum);
    map['status'] = Variable<String>(status);
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  SyncHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return SyncHistoryTableCompanion(
      id: Value(id),
      datasetVersion: Value(datasetVersion),
      checksum: Value(checksum),
      status: Value(status),
      syncedAt: Value(syncedAt),
    );
  }

  factory SyncHistoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncHistoryTableData(
      id: serializer.fromJson<int>(json['id']),
      datasetVersion: serializer.fromJson<String>(json['datasetVersion']),
      checksum: serializer.fromJson<String>(json['checksum']),
      status: serializer.fromJson<String>(json['status']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'datasetVersion': serializer.toJson<String>(datasetVersion),
      'checksum': serializer.toJson<String>(checksum),
      'status': serializer.toJson<String>(status),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  SyncHistoryTableData copyWith({
    int? id,
    String? datasetVersion,
    String? checksum,
    String? status,
    DateTime? syncedAt,
  }) => SyncHistoryTableData(
    id: id ?? this.id,
    datasetVersion: datasetVersion ?? this.datasetVersion,
    checksum: checksum ?? this.checksum,
    status: status ?? this.status,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  SyncHistoryTableData copyWithCompanion(SyncHistoryTableCompanion data) {
    return SyncHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      datasetVersion: data.datasetVersion.present
          ? data.datasetVersion.value
          : this.datasetVersion,
      checksum: data.checksum.present ? data.checksum.value : this.checksum,
      status: data.status.present ? data.status.value : this.status,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncHistoryTableData(')
          ..write('id: $id, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('checksum: $checksum, ')
          ..write('status: $status, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, datasetVersion, checksum, status, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncHistoryTableData &&
          other.id == this.id &&
          other.datasetVersion == this.datasetVersion &&
          other.checksum == this.checksum &&
          other.status == this.status &&
          other.syncedAt == this.syncedAt);
}

class SyncHistoryTableCompanion extends UpdateCompanion<SyncHistoryTableData> {
  final Value<int> id;
  final Value<String> datasetVersion;
  final Value<String> checksum;
  final Value<String> status;
  final Value<DateTime> syncedAt;
  const SyncHistoryTableCompanion({
    this.id = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.checksum = const Value.absent(),
    this.status = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  SyncHistoryTableCompanion.insert({
    this.id = const Value.absent(),
    required String datasetVersion,
    required String checksum,
    required String status,
    required DateTime syncedAt,
  }) : datasetVersion = Value(datasetVersion),
       checksum = Value(checksum),
       status = Value(status),
       syncedAt = Value(syncedAt);
  static Insertable<SyncHistoryTableData> custom({
    Expression<int>? id,
    Expression<String>? datasetVersion,
    Expression<String>? checksum,
    Expression<String>? status,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (datasetVersion != null) 'dataset_version': datasetVersion,
      if (checksum != null) 'checksum': checksum,
      if (status != null) 'status': status,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  SyncHistoryTableCompanion copyWith({
    Value<int>? id,
    Value<String>? datasetVersion,
    Value<String>? checksum,
    Value<String>? status,
    Value<DateTime>? syncedAt,
  }) {
    return SyncHistoryTableCompanion(
      id: id ?? this.id,
      datasetVersion: datasetVersion ?? this.datasetVersion,
      checksum: checksum ?? this.checksum,
      status: status ?? this.status,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (datasetVersion.present) {
      map['dataset_version'] = Variable<String>(datasetVersion.value);
    }
    if (checksum.present) {
      map['checksum'] = Variable<String>(checksum.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('checksum: $checksum, ')
          ..write('status: $status, ')
          ..write('syncedAt: $syncedAt')
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
  late final $SavedJourneysTableTable savedJourneysTable =
      $SavedJourneysTableTable(this);
  late final $JourneyHistoryTableTable journeyHistoryTable =
      $JourneyHistoryTableTable(this);
  late final $ServiceAdvisoriesTableTable serviceAdvisoriesTable =
      $ServiceAdvisoriesTableTable(this);
  late final $SyncHistoryTableTable syncHistoryTable = $SyncHistoryTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    stationsTable,
    tripsTable,
    stopSchedulesTable,
    datasetMetadataTable,
    savedJourneysTable,
    journeyHistoryTable,
    serviceAdvisoriesTable,
    syncHistoryTable,
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
typedef $$SavedJourneysTableTableCreateCompanionBuilder =
    SavedJourneysTableCompanion Function({
      required String id,
      required String label,
      required String originStationId,
      required String destinationStationId,
      Value<bool> isPinned,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SavedJourneysTableTableUpdateCompanionBuilder =
    SavedJourneysTableCompanion Function({
      Value<String> id,
      Value<String> label,
      Value<String> originStationId,
      Value<String> destinationStationId,
      Value<bool> isPinned,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SavedJourneysTableTableFilterComposer
    extends Composer<_$AppDatabase, $SavedJourneysTableTable> {
  $$SavedJourneysTableTableFilterComposer({
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

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originStationId => $composableBuilder(
    column: $table.originStationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destinationStationId => $composableBuilder(
    column: $table.destinationStationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPinned => $composableBuilder(
    column: $table.isPinned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedJourneysTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedJourneysTableTable> {
  $$SavedJourneysTableTableOrderingComposer({
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

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originStationId => $composableBuilder(
    column: $table.originStationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinationStationId => $composableBuilder(
    column: $table.destinationStationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPinned => $composableBuilder(
    column: $table.isPinned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedJourneysTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedJourneysTableTable> {
  $$SavedJourneysTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get originStationId => $composableBuilder(
    column: $table.originStationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get destinationStationId => $composableBuilder(
    column: $table.destinationStationId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SavedJourneysTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedJourneysTableTable,
          SavedJourneysTableData,
          $$SavedJourneysTableTableFilterComposer,
          $$SavedJourneysTableTableOrderingComposer,
          $$SavedJourneysTableTableAnnotationComposer,
          $$SavedJourneysTableTableCreateCompanionBuilder,
          $$SavedJourneysTableTableUpdateCompanionBuilder,
          (
            SavedJourneysTableData,
            BaseReferences<
              _$AppDatabase,
              $SavedJourneysTableTable,
              SavedJourneysTableData
            >,
          ),
          SavedJourneysTableData,
          PrefetchHooks Function()
        > {
  $$SavedJourneysTableTableTableManager(
    _$AppDatabase db,
    $SavedJourneysTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedJourneysTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedJourneysTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedJourneysTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> originStationId = const Value.absent(),
                Value<String> destinationStationId = const Value.absent(),
                Value<bool> isPinned = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavedJourneysTableCompanion(
                id: id,
                label: label,
                originStationId: originStationId,
                destinationStationId: destinationStationId,
                isPinned: isPinned,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String label,
                required String originStationId,
                required String destinationStationId,
                Value<bool> isPinned = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SavedJourneysTableCompanion.insert(
                id: id,
                label: label,
                originStationId: originStationId,
                destinationStationId: destinationStationId,
                isPinned: isPinned,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedJourneysTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedJourneysTableTable,
      SavedJourneysTableData,
      $$SavedJourneysTableTableFilterComposer,
      $$SavedJourneysTableTableOrderingComposer,
      $$SavedJourneysTableTableAnnotationComposer,
      $$SavedJourneysTableTableCreateCompanionBuilder,
      $$SavedJourneysTableTableUpdateCompanionBuilder,
      (
        SavedJourneysTableData,
        BaseReferences<
          _$AppDatabase,
          $SavedJourneysTableTable,
          SavedJourneysTableData
        >,
      ),
      SavedJourneysTableData,
      PrefetchHooks Function()
    >;
typedef $$JourneyHistoryTableTableCreateCompanionBuilder =
    JourneyHistoryTableCompanion Function({
      required String id,
      required String originStationId,
      required String destinationStationId,
      required int estimatedDurationMinutes,
      required DateTime queriedAt,
      Value<int> rowid,
    });
typedef $$JourneyHistoryTableTableUpdateCompanionBuilder =
    JourneyHistoryTableCompanion Function({
      Value<String> id,
      Value<String> originStationId,
      Value<String> destinationStationId,
      Value<int> estimatedDurationMinutes,
      Value<DateTime> queriedAt,
      Value<int> rowid,
    });

class $$JourneyHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $JourneyHistoryTableTable> {
  $$JourneyHistoryTableTableFilterComposer({
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

  ColumnFilters<String> get originStationId => $composableBuilder(
    column: $table.originStationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destinationStationId => $composableBuilder(
    column: $table.destinationStationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get queriedAt => $composableBuilder(
    column: $table.queriedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JourneyHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $JourneyHistoryTableTable> {
  $$JourneyHistoryTableTableOrderingComposer({
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

  ColumnOrderings<String> get originStationId => $composableBuilder(
    column: $table.originStationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinationStationId => $composableBuilder(
    column: $table.destinationStationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get queriedAt => $composableBuilder(
    column: $table.queriedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JourneyHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $JourneyHistoryTableTable> {
  $$JourneyHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get originStationId => $composableBuilder(
    column: $table.originStationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get destinationStationId => $composableBuilder(
    column: $table.destinationStationId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get queriedAt =>
      $composableBuilder(column: $table.queriedAt, builder: (column) => column);
}

class $$JourneyHistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JourneyHistoryTableTable,
          JourneyHistoryTableData,
          $$JourneyHistoryTableTableFilterComposer,
          $$JourneyHistoryTableTableOrderingComposer,
          $$JourneyHistoryTableTableAnnotationComposer,
          $$JourneyHistoryTableTableCreateCompanionBuilder,
          $$JourneyHistoryTableTableUpdateCompanionBuilder,
          (
            JourneyHistoryTableData,
            BaseReferences<
              _$AppDatabase,
              $JourneyHistoryTableTable,
              JourneyHistoryTableData
            >,
          ),
          JourneyHistoryTableData,
          PrefetchHooks Function()
        > {
  $$JourneyHistoryTableTableTableManager(
    _$AppDatabase db,
    $JourneyHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JourneyHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JourneyHistoryTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$JourneyHistoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> originStationId = const Value.absent(),
                Value<String> destinationStationId = const Value.absent(),
                Value<int> estimatedDurationMinutes = const Value.absent(),
                Value<DateTime> queriedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JourneyHistoryTableCompanion(
                id: id,
                originStationId: originStationId,
                destinationStationId: destinationStationId,
                estimatedDurationMinutes: estimatedDurationMinutes,
                queriedAt: queriedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String originStationId,
                required String destinationStationId,
                required int estimatedDurationMinutes,
                required DateTime queriedAt,
                Value<int> rowid = const Value.absent(),
              }) => JourneyHistoryTableCompanion.insert(
                id: id,
                originStationId: originStationId,
                destinationStationId: destinationStationId,
                estimatedDurationMinutes: estimatedDurationMinutes,
                queriedAt: queriedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JourneyHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JourneyHistoryTableTable,
      JourneyHistoryTableData,
      $$JourneyHistoryTableTableFilterComposer,
      $$JourneyHistoryTableTableOrderingComposer,
      $$JourneyHistoryTableTableAnnotationComposer,
      $$JourneyHistoryTableTableCreateCompanionBuilder,
      $$JourneyHistoryTableTableUpdateCompanionBuilder,
      (
        JourneyHistoryTableData,
        BaseReferences<
          _$AppDatabase,
          $JourneyHistoryTableTable,
          JourneyHistoryTableData
        >,
      ),
      JourneyHistoryTableData,
      PrefetchHooks Function()
    >;
typedef $$ServiceAdvisoriesTableTableCreateCompanionBuilder =
    ServiceAdvisoriesTableCompanion Function({
      required String id,
      required String lineId,
      required String titleEn,
      required String titleMr,
      required String titleHi,
      required String descriptionEn,
      required String descriptionMr,
      required String descriptionHi,
      required String severity,
      required DateTime effectiveFrom,
      required DateTime effectiveUntil,
      Value<bool> isVerified,
      Value<int> rowid,
    });
typedef $$ServiceAdvisoriesTableTableUpdateCompanionBuilder =
    ServiceAdvisoriesTableCompanion Function({
      Value<String> id,
      Value<String> lineId,
      Value<String> titleEn,
      Value<String> titleMr,
      Value<String> titleHi,
      Value<String> descriptionEn,
      Value<String> descriptionMr,
      Value<String> descriptionHi,
      Value<String> severity,
      Value<DateTime> effectiveFrom,
      Value<DateTime> effectiveUntil,
      Value<bool> isVerified,
      Value<int> rowid,
    });

class $$ServiceAdvisoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceAdvisoriesTableTable> {
  $$ServiceAdvisoriesTableTableFilterComposer({
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

  ColumnFilters<String> get lineId => $composableBuilder(
    column: $table.lineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleMr => $composableBuilder(
    column: $table.titleMr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleHi => $composableBuilder(
    column: $table.titleHi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionMr => $composableBuilder(
    column: $table.descriptionMr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHi => $composableBuilder(
    column: $table.descriptionHi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get effectiveUntil => $composableBuilder(
    column: $table.effectiveUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ServiceAdvisoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceAdvisoriesTableTable> {
  $$ServiceAdvisoriesTableTableOrderingComposer({
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

  ColumnOrderings<String> get lineId => $composableBuilder(
    column: $table.lineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleMr => $composableBuilder(
    column: $table.titleMr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleHi => $composableBuilder(
    column: $table.titleHi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionMr => $composableBuilder(
    column: $table.descriptionMr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHi => $composableBuilder(
    column: $table.descriptionHi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get effectiveUntil => $composableBuilder(
    column: $table.effectiveUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServiceAdvisoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceAdvisoriesTableTable> {
  $$ServiceAdvisoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lineId =>
      $composableBuilder(column: $table.lineId, builder: (column) => column);

  GeneratedColumn<String> get titleEn =>
      $composableBuilder(column: $table.titleEn, builder: (column) => column);

  GeneratedColumn<String> get titleMr =>
      $composableBuilder(column: $table.titleMr, builder: (column) => column);

  GeneratedColumn<String> get titleHi =>
      $composableBuilder(column: $table.titleHi, builder: (column) => column);

  GeneratedColumn<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionMr => $composableBuilder(
    column: $table.descriptionMr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionHi => $composableBuilder(
    column: $table.descriptionHi,
    builder: (column) => column,
  );

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get effectiveUntil => $composableBuilder(
    column: $table.effectiveUntil,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );
}

class $$ServiceAdvisoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServiceAdvisoriesTableTable,
          ServiceAdvisoriesTableData,
          $$ServiceAdvisoriesTableTableFilterComposer,
          $$ServiceAdvisoriesTableTableOrderingComposer,
          $$ServiceAdvisoriesTableTableAnnotationComposer,
          $$ServiceAdvisoriesTableTableCreateCompanionBuilder,
          $$ServiceAdvisoriesTableTableUpdateCompanionBuilder,
          (
            ServiceAdvisoriesTableData,
            BaseReferences<
              _$AppDatabase,
              $ServiceAdvisoriesTableTable,
              ServiceAdvisoriesTableData
            >,
          ),
          ServiceAdvisoriesTableData,
          PrefetchHooks Function()
        > {
  $$ServiceAdvisoriesTableTableTableManager(
    _$AppDatabase db,
    $ServiceAdvisoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceAdvisoriesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ServiceAdvisoriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ServiceAdvisoriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> lineId = const Value.absent(),
                Value<String> titleEn = const Value.absent(),
                Value<String> titleMr = const Value.absent(),
                Value<String> titleHi = const Value.absent(),
                Value<String> descriptionEn = const Value.absent(),
                Value<String> descriptionMr = const Value.absent(),
                Value<String> descriptionHi = const Value.absent(),
                Value<String> severity = const Value.absent(),
                Value<DateTime> effectiveFrom = const Value.absent(),
                Value<DateTime> effectiveUntil = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServiceAdvisoriesTableCompanion(
                id: id,
                lineId: lineId,
                titleEn: titleEn,
                titleMr: titleMr,
                titleHi: titleHi,
                descriptionEn: descriptionEn,
                descriptionMr: descriptionMr,
                descriptionHi: descriptionHi,
                severity: severity,
                effectiveFrom: effectiveFrom,
                effectiveUntil: effectiveUntil,
                isVerified: isVerified,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String lineId,
                required String titleEn,
                required String titleMr,
                required String titleHi,
                required String descriptionEn,
                required String descriptionMr,
                required String descriptionHi,
                required String severity,
                required DateTime effectiveFrom,
                required DateTime effectiveUntil,
                Value<bool> isVerified = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServiceAdvisoriesTableCompanion.insert(
                id: id,
                lineId: lineId,
                titleEn: titleEn,
                titleMr: titleMr,
                titleHi: titleHi,
                descriptionEn: descriptionEn,
                descriptionMr: descriptionMr,
                descriptionHi: descriptionHi,
                severity: severity,
                effectiveFrom: effectiveFrom,
                effectiveUntil: effectiveUntil,
                isVerified: isVerified,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ServiceAdvisoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServiceAdvisoriesTableTable,
      ServiceAdvisoriesTableData,
      $$ServiceAdvisoriesTableTableFilterComposer,
      $$ServiceAdvisoriesTableTableOrderingComposer,
      $$ServiceAdvisoriesTableTableAnnotationComposer,
      $$ServiceAdvisoriesTableTableCreateCompanionBuilder,
      $$ServiceAdvisoriesTableTableUpdateCompanionBuilder,
      (
        ServiceAdvisoriesTableData,
        BaseReferences<
          _$AppDatabase,
          $ServiceAdvisoriesTableTable,
          ServiceAdvisoriesTableData
        >,
      ),
      ServiceAdvisoriesTableData,
      PrefetchHooks Function()
    >;
typedef $$SyncHistoryTableTableCreateCompanionBuilder =
    SyncHistoryTableCompanion Function({
      Value<int> id,
      required String datasetVersion,
      required String checksum,
      required String status,
      required DateTime syncedAt,
    });
typedef $$SyncHistoryTableTableUpdateCompanionBuilder =
    SyncHistoryTableCompanion Function({
      Value<int> id,
      Value<String> datasetVersion,
      Value<String> checksum,
      Value<String> status,
      Value<DateTime> syncedAt,
    });

class $$SyncHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncHistoryTableTable> {
  $$SyncHistoryTableTableFilterComposer({
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

  ColumnFilters<String> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncHistoryTableTable> {
  $$SyncHistoryTableTableOrderingComposer({
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

  ColumnOrderings<String> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncHistoryTableTable> {
  $$SyncHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get checksum =>
      $composableBuilder(column: $table.checksum, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$SyncHistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncHistoryTableTable,
          SyncHistoryTableData,
          $$SyncHistoryTableTableFilterComposer,
          $$SyncHistoryTableTableOrderingComposer,
          $$SyncHistoryTableTableAnnotationComposer,
          $$SyncHistoryTableTableCreateCompanionBuilder,
          $$SyncHistoryTableTableUpdateCompanionBuilder,
          (
            SyncHistoryTableData,
            BaseReferences<
              _$AppDatabase,
              $SyncHistoryTableTable,
              SyncHistoryTableData
            >,
          ),
          SyncHistoryTableData,
          PrefetchHooks Function()
        > {
  $$SyncHistoryTableTableTableManager(
    _$AppDatabase db,
    $SyncHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncHistoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncHistoryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> datasetVersion = const Value.absent(),
                Value<String> checksum = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
              }) => SyncHistoryTableCompanion(
                id: id,
                datasetVersion: datasetVersion,
                checksum: checksum,
                status: status,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String datasetVersion,
                required String checksum,
                required String status,
                required DateTime syncedAt,
              }) => SyncHistoryTableCompanion.insert(
                id: id,
                datasetVersion: datasetVersion,
                checksum: checksum,
                status: status,
                syncedAt: syncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncHistoryTableTable,
      SyncHistoryTableData,
      $$SyncHistoryTableTableFilterComposer,
      $$SyncHistoryTableTableOrderingComposer,
      $$SyncHistoryTableTableAnnotationComposer,
      $$SyncHistoryTableTableCreateCompanionBuilder,
      $$SyncHistoryTableTableUpdateCompanionBuilder,
      (
        SyncHistoryTableData,
        BaseReferences<
          _$AppDatabase,
          $SyncHistoryTableTable,
          SyncHistoryTableData
        >,
      ),
      SyncHistoryTableData,
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
  $$SavedJourneysTableTableTableManager get savedJourneysTable =>
      $$SavedJourneysTableTableTableManager(_db, _db.savedJourneysTable);
  $$JourneyHistoryTableTableTableManager get journeyHistoryTable =>
      $$JourneyHistoryTableTableTableManager(_db, _db.journeyHistoryTable);
  $$ServiceAdvisoriesTableTableTableManager get serviceAdvisoriesTable =>
      $$ServiceAdvisoriesTableTableTableManager(
        _db,
        _db.serviceAdvisoriesTable,
      );
  $$SyncHistoryTableTableTableManager get syncHistoryTable =>
      $$SyncHistoryTableTableTableManager(_db, _db.syncHistoryTable);
}
