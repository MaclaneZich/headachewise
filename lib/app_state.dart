import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _ongoing = prefs.getBool('ff_ongoing') ?? _ongoing;
    });
    _safeInit(() {
      _IntroSlidesDone =
          prefs.getBool('ff_IntroSlidesDone') ?? _IntroSlidesDone;
    });
    _safeInit(() {
      _appleSignup = prefs.getBool('ff_appleSignup') ?? _appleSignup;
    });
    _safeInit(() {
      _notes = prefs.getString('ff_notes') ?? _notes;
    });
    _safeInit(() {
      _sexFirstClicked =
          prefs.getBool('ff_sexFirstClicked') ?? _sexFirstClicked;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _maleClick = false;
  bool get maleClick => _maleClick;
  set maleClick(bool value) {
    _maleClick = value;
  }

  bool _femaleClick = false;
  bool get femaleClick => _femaleClick;
  set femaleClick(bool value) {
    _femaleClick = value;
  }

  bool _clicked = false;
  bool get clicked => _clicked;
  set clicked(bool value) {
    _clicked = value;
  }

  DateTime? _selectedTime = DateTime.fromMillisecondsSinceEpoch(1718556000000);
  DateTime? get selectedTime => _selectedTime;
  set selectedTime(DateTime? value) {
    _selectedTime = value;
  }

  double _sliderValue = 0.0;
  double get sliderValue => _sliderValue;
  set sliderValue(double value) {
    _sliderValue = value;
  }

  bool _yes = false;
  bool get yes => _yes;
  set yes(bool value) {
    _yes = value;
  }

  bool _no = false;
  bool get no => _no;
  set no(bool value) {
    _no = value;
  }

  bool _clicked2 = false;
  bool get clicked2 => _clicked2;
  set clicked2(bool value) {
    _clicked2 = value;
  }

  bool _ongoing = false;
  bool get ongoing => _ongoing;
  set ongoing(bool value) {
    _ongoing = value;
    prefs.setBool('ff_ongoing', value);
  }

  bool _ended = false;
  bool get ended => _ended;
  set ended(bool value) {
    _ended = value;
  }

  bool _summaryEdit = false;
  bool get summaryEdit => _summaryEdit;
  set summaryEdit(bool value) {
    _summaryEdit = value;
  }

  bool _research = true;
  bool get research => _research;
  set research(bool value) {
    _research = value;
  }

  bool _navFromCalender = false;
  bool get navFromCalender => _navFromCalender;
  set navFromCalender(bool value) {
    _navFromCalender = value;
  }

  String _tempPainLocation = '';
  String get tempPainLocation => _tempPainLocation;
  set tempPainLocation(String value) {
    _tempPainLocation = value;
  }

  List<String> _selectedTriggers = [];
  List<String> get selectedTriggers => _selectedTriggers;
  set selectedTriggers(List<String> value) {
    _selectedTriggers = value;
  }

  void addToSelectedTriggers(String value) {
    selectedTriggers.add(value);
  }

  void removeFromSelectedTriggers(String value) {
    selectedTriggers.remove(value);
  }

  void removeAtIndexFromSelectedTriggers(int index) {
    selectedTriggers.removeAt(index);
  }

  void updateSelectedTriggersAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    selectedTriggers[index] = updateFn(_selectedTriggers[index]);
  }

  void insertAtIndexInSelectedTriggers(int index, String value) {
    selectedTriggers.insert(index, value);
  }

  List<String> _selectedSymptoms = [];
  List<String> get selectedSymptoms => _selectedSymptoms;
  set selectedSymptoms(List<String> value) {
    _selectedSymptoms = value;
  }

  void addToSelectedSymptoms(String value) {
    selectedSymptoms.add(value);
  }

  void removeFromSelectedSymptoms(String value) {
    selectedSymptoms.remove(value);
  }

  void removeAtIndexFromSelectedSymptoms(int index) {
    selectedSymptoms.removeAt(index);
  }

  void updateSelectedSymptomsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    selectedSymptoms[index] = updateFn(_selectedSymptoms[index]);
  }

  void insertAtIndexInSelectedSymptoms(int index, String value) {
    selectedSymptoms.insert(index, value);
  }

  String _selectedMedication = '';
  String get selectedMedication => _selectedMedication;
  set selectedMedication(String value) {
    _selectedMedication = value;
  }

  String _customMedication = '';
  String get customMedication => _customMedication;
  set customMedication(String value) {
    _customMedication = value;
  }

  String _dosage = '';
  String get dosage => _dosage;
  set dosage(String value) {
    _dosage = value;
  }

  List<MedicationEntryStruct> _medicationsList = [];
  List<MedicationEntryStruct> get medicationsList => _medicationsList;
  set medicationsList(List<MedicationEntryStruct> value) {
    _medicationsList = value;
  }

  void addToMedicationsList(MedicationEntryStruct value) {
    medicationsList.add(value);
  }

  void removeFromMedicationsList(MedicationEntryStruct value) {
    medicationsList.remove(value);
  }

  void removeAtIndexFromMedicationsList(int index) {
    medicationsList.removeAt(index);
  }

  void updateMedicationsListAtIndex(
    int index,
    MedicationEntryStruct Function(MedicationEntryStruct) updateFn,
  ) {
    medicationsList[index] = updateFn(_medicationsList[index]);
  }

  void insertAtIndexInMedicationsList(int index, MedicationEntryStruct value) {
    medicationsList.insert(index, value);
  }

  bool _custom = false;
  bool get custom => _custom;
  set custom(bool value) {
    _custom = value;
  }

  DateTime? _selectedDate = DateTime.fromMillisecondsSinceEpoch(1750632420000);
  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? value) {
    _selectedDate = value;
  }

  bool _edit = false;
  bool get edit => _edit;
  set edit(bool value) {
    _edit = value;
  }

  bool _IntroSlidesDone = false;
  bool get IntroSlidesDone => _IntroSlidesDone;
  set IntroSlidesDone(bool value) {
    _IntroSlidesDone = value;
    prefs.setBool('ff_IntroSlidesDone', value);
  }

  bool _appleSignup = false;
  bool get appleSignup => _appleSignup;
  set appleSignup(bool value) {
    _appleSignup = value;
    prefs.setBool('ff_appleSignup', value);
  }

  double _greatestSeverity = 5.0;
  double get greatestSeverity => _greatestSeverity;
  set greatestSeverity(double value) {
    _greatestSeverity = value;
  }

  String _notes = '';
  String get notes => _notes;
  set notes(String value) {
    _notes = value;
    prefs.setString('ff_notes', value);
  }

  bool _sexFirstClicked = false;
  bool get sexFirstClicked => _sexFirstClicked;
  set sexFirstClicked(bool value) {
    _sexFirstClicked = value;
    prefs.setBool('ff_sexFirstClicked', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
