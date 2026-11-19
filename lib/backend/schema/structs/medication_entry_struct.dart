// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MedicationEntryStruct extends FFFirebaseStruct {
  MedicationEntryStruct({
    String? name,
    String? dosage,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _dosage = dosage,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "dosage" field.
  String? _dosage;
  String get dosage => _dosage ?? '';
  set dosage(String? val) => _dosage = val;

  bool hasDosage() => _dosage != null;

  static MedicationEntryStruct fromMap(Map<String, dynamic> data) =>
      MedicationEntryStruct(
        name: data['name'] as String?,
        dosage: data['dosage'] as String?,
      );

  static MedicationEntryStruct? maybeFromMap(dynamic data) => data is Map
      ? MedicationEntryStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'dosage': _dosage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'dosage': serializeParam(
          _dosage,
          ParamType.String,
        ),
      }.withoutNulls;

  static MedicationEntryStruct fromSerializableMap(Map<String, dynamic> data) =>
      MedicationEntryStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        dosage: deserializeParam(
          data['dosage'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MedicationEntryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MedicationEntryStruct &&
        name == other.name &&
        dosage == other.dosage;
  }

  @override
  int get hashCode => const ListEquality().hash([name, dosage]);
}

MedicationEntryStruct createMedicationEntryStruct({
  String? name,
  String? dosage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MedicationEntryStruct(
      name: name,
      dosage: dosage,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MedicationEntryStruct? updateMedicationEntryStruct(
  MedicationEntryStruct? medicationEntry, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    medicationEntry
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMedicationEntryStructData(
  Map<String, dynamic> firestoreData,
  MedicationEntryStruct? medicationEntry,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (medicationEntry == null) {
    return;
  }
  if (medicationEntry.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && medicationEntry.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final medicationEntryData =
      getMedicationEntryFirestoreData(medicationEntry, forFieldValue);
  final nestedData =
      medicationEntryData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = medicationEntry.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMedicationEntryFirestoreData(
  MedicationEntryStruct? medicationEntry, [
  bool forFieldValue = false,
]) {
  if (medicationEntry == null) {
    return {};
  }
  final firestoreData = mapToFirestore(medicationEntry.toMap());

  // Add any Firestore field values
  mapToFirestore(medicationEntry.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMedicationEntryListFirestoreData(
  List<MedicationEntryStruct>? medicationEntrys,
) =>
    medicationEntrys
        ?.map((e) => getMedicationEntryFirestoreData(e, true))
        .toList() ??
    [];
