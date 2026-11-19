import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/medications_component_widget.dart';
import '/components/pain_location_widget.dart';
import '/components/symptoms_component_widget.dart';
import '/components/triggers_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'log_headache_page_widget.dart' show LogHeadachePageWidget;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LogHeadachePageModel extends FlutterFlowModel<LogHeadachePageWidget> {
  ///  Local state fields for this page.

  DateTime? startTime;

  DateTime? endTime;

  bool isOngoing = true;

  int? step = 0;

  int? currentIntensity = 5;

  List<IntensityPointStruct> intensityHistory = [];
  void addToIntensityHistory(IntensityPointStruct item) =>
      intensityHistory.add(item);
  void removeFromIntensityHistory(IntensityPointStruct item) =>
      intensityHistory.remove(item);
  void removeAtIndexFromIntensityHistory(int index) =>
      intensityHistory.removeAt(index);
  void insertAtIndexInIntensityHistory(int index, IntensityPointStruct item) =>
      intensityHistory.insert(index, item);
  void updateIntensityHistoryAtIndex(
          int index, Function(IntensityPointStruct) updateFn) =>
      intensityHistory[index] = updateFn(intensityHistory[index]);

  String? painLocation;

  List<String> triggers = [];
  void addToTriggers(String item) => triggers.add(item);
  void removeFromTriggers(String item) => triggers.remove(item);
  void removeAtIndexFromTriggers(int index) => triggers.removeAt(index);
  void insertAtIndexInTriggers(int index, String item) =>
      triggers.insert(index, item);
  void updateTriggersAtIndex(int index, Function(String) updateFn) =>
      triggers[index] = updateFn(triggers[index]);

  List<String> symptoms = [];
  void addToSymptoms(String item) => symptoms.add(item);
  void removeFromSymptoms(String item) => symptoms.remove(item);
  void removeAtIndexFromSymptoms(int index) => symptoms.removeAt(index);
  void insertAtIndexInSymptoms(int index, String item) =>
      symptoms.insert(index, item);
  void updateSymptomsAtIndex(int index, Function(String) updateFn) =>
      symptoms[index] = updateFn(symptoms[index]);

  List<MedicationEntryStruct> medicationsList = [];
  void addToMedicationsList(MedicationEntryStruct item) =>
      medicationsList.add(item);
  void removeFromMedicationsList(MedicationEntryStruct item) =>
      medicationsList.remove(item);
  void removeAtIndexFromMedicationsList(int index) =>
      medicationsList.removeAt(index);
  void insertAtIndexInMedicationsList(int index, MedicationEntryStruct item) =>
      medicationsList.insert(index, item);
  void updateMedicationsListAtIndex(
          int index, Function(MedicationEntryStruct) updateFn) =>
      medicationsList[index] = updateFn(medicationsList[index]);

  String? notes;

  double greatestSeverity = 5.0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for SliderView widget.
  PageController? sliderViewController;

  int get sliderViewCurrentIndex => sliderViewController != null &&
          sliderViewController!.hasClients &&
          sliderViewController!.page != null
      ? sliderViewController!.page!.round()
      : 0;
  DateTime? datePicked1;
  // State field(s) for Switch widget.
  bool? switchValue;
  DateTime? datePicked2;
  // State field(s) for Slider widget.
  double? sliderValue;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
