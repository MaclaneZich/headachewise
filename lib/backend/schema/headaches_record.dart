import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HeadachesRecord extends FirestoreRecord {
  HeadachesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "startTime" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  // "painLocation" field.
  String? _painLocation;
  String get painLocation => _painLocation ?? '';
  bool hasPainLocation() => _painLocation != null;

  // "triggers" field.
  List<String>? _triggers;
  List<String> get triggers => _triggers ?? const [];
  bool hasTriggers() => _triggers != null;

  // "symptoms" field.
  List<String>? _symptoms;
  List<String> get symptoms => _symptoms ?? const [];
  bool hasSymptoms() => _symptoms != null;

  // "medications" field.
  List<MedicationEntryStruct>? _medications;
  List<MedicationEntryStruct> get medications => _medications ?? const [];
  bool hasMedications() => _medications != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "ongoing" field.
  bool? _ongoing;
  bool get ongoing => _ongoing ?? false;
  bool hasOngoing() => _ongoing != null;

  // "greatestSeverity" field.
  double? _greatestSeverity;
  double get greatestSeverity => _greatestSeverity ?? 0.0;
  bool hasGreatestSeverity() => _greatestSeverity != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _startTime = snapshotData['startTime'] as DateTime?;
    _endTime = snapshotData['endTime'] as DateTime?;
    _painLocation = snapshotData['painLocation'] as String?;
    _triggers = getDataList(snapshotData['triggers']);
    _symptoms = getDataList(snapshotData['symptoms']);
    _medications = getStructList(
      snapshotData['medications'],
      MedicationEntryStruct.fromMap,
    );
    _notes = snapshotData['notes'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _ongoing = snapshotData['ongoing'] as bool?;
    _greatestSeverity = castToType<double>(snapshotData['greatestSeverity']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('Headaches')
          : FirebaseFirestore.instance.collectionGroup('Headaches');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('Headaches').doc(id);

  static Stream<HeadachesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => HeadachesRecord.fromSnapshot(s));

  static Future<HeadachesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => HeadachesRecord.fromSnapshot(s));

  static HeadachesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      HeadachesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static HeadachesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      HeadachesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'HeadachesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is HeadachesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createHeadachesRecordData({
  DateTime? startTime,
  DateTime? endTime,
  String? painLocation,
  String? notes,
  DateTime? createdAt,
  bool? ongoing,
  double? greatestSeverity,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'startTime': startTime,
      'endTime': endTime,
      'painLocation': painLocation,
      'notes': notes,
      'createdAt': createdAt,
      'ongoing': ongoing,
      'greatestSeverity': greatestSeverity,
    }.withoutNulls,
  );

  return firestoreData;
}

class HeadachesRecordDocumentEquality implements Equality<HeadachesRecord> {
  const HeadachesRecordDocumentEquality();

  @override
  bool equals(HeadachesRecord? e1, HeadachesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime &&
        e1?.painLocation == e2?.painLocation &&
        listEquality.equals(e1?.triggers, e2?.triggers) &&
        listEquality.equals(e1?.symptoms, e2?.symptoms) &&
        listEquality.equals(e1?.medications, e2?.medications) &&
        e1?.notes == e2?.notes &&
        e1?.createdAt == e2?.createdAt &&
        e1?.ongoing == e2?.ongoing &&
        e1?.greatestSeverity == e2?.greatestSeverity;
  }

  @override
  int hash(HeadachesRecord? e) => const ListEquality().hash([
        e?.startTime,
        e?.endTime,
        e?.painLocation,
        e?.triggers,
        e?.symptoms,
        e?.medications,
        e?.notes,
        e?.createdAt,
        e?.ongoing,
        e?.greatestSeverity
      ]);

  @override
  bool isValidKey(Object? o) => o is HeadachesRecord;
}
