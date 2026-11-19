// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class IntensityPointStruct extends FFFirebaseStruct {
  IntensityPointStruct({
    int? value,
    DateTime? time,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _value = value,
        _time = time,
        super(firestoreUtilData);

  // "value" field.
  int? _value;
  int get value => _value ?? 0;
  set value(int? val) => _value = val;

  void incrementValue(int amount) => value = value + amount;

  bool hasValue() => _value != null;

  // "time" field.
  DateTime? _time;
  DateTime? get time => _time;
  set time(DateTime? val) => _time = val;

  bool hasTime() => _time != null;

  static IntensityPointStruct fromMap(Map<String, dynamic> data) =>
      IntensityPointStruct(
        value: castToType<int>(data['value']),
        time: data['time'] as DateTime?,
      );

  static IntensityPointStruct? maybeFromMap(dynamic data) => data is Map
      ? IntensityPointStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'value': _value,
        'time': _time,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'value': serializeParam(
          _value,
          ParamType.int,
        ),
        'time': serializeParam(
          _time,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static IntensityPointStruct fromSerializableMap(Map<String, dynamic> data) =>
      IntensityPointStruct(
        value: deserializeParam(
          data['value'],
          ParamType.int,
          false,
        ),
        time: deserializeParam(
          data['time'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'IntensityPointStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is IntensityPointStruct &&
        value == other.value &&
        time == other.time;
  }

  @override
  int get hashCode => const ListEquality().hash([value, time]);
}

IntensityPointStruct createIntensityPointStruct({
  int? value,
  DateTime? time,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    IntensityPointStruct(
      value: value,
      time: time,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

IntensityPointStruct? updateIntensityPointStruct(
  IntensityPointStruct? intensityPoint, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    intensityPoint
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addIntensityPointStructData(
  Map<String, dynamic> firestoreData,
  IntensityPointStruct? intensityPoint,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (intensityPoint == null) {
    return;
  }
  if (intensityPoint.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && intensityPoint.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final intensityPointData =
      getIntensityPointFirestoreData(intensityPoint, forFieldValue);
  final nestedData =
      intensityPointData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = intensityPoint.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getIntensityPointFirestoreData(
  IntensityPointStruct? intensityPoint, [
  bool forFieldValue = false,
]) {
  if (intensityPoint == null) {
    return {};
  }
  final firestoreData = mapToFirestore(intensityPoint.toMap());

  // Add any Firestore field values
  mapToFirestore(intensityPoint.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getIntensityPointListFirestoreData(
  List<IntensityPointStruct>? intensityPoints,
) =>
    intensityPoints
        ?.map((e) => getIntensityPointFirestoreData(e, true))
        .toList() ??
    [];
