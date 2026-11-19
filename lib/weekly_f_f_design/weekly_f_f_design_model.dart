import '/auth/firebase_auth/auth_util.dart';
import '/backend/ai_agents/ai_agent.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'weekly_f_f_design_widget.dart' show WeeklyFFDesignWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class WeeklyFFDesignModel extends FlutterFlowModel<WeeklyFFDesignWidget> {
  ///  Local state fields for this page.

  DateTime? currentDate;

  DateTime? weekStart;

  DateTime? weekEnd;

  String aiPrompt = 'Analysis Error';

  bool previous = false;

  List<HeadachesRecord> headacheList = [];
  void addToHeadacheList(HeadachesRecord item) => headacheList.add(item);
  void removeFromHeadacheList(HeadachesRecord item) =>
      headacheList.remove(item);
  void removeAtIndexFromHeadacheList(int index) => headacheList.removeAt(index);
  void insertAtIndexInHeadacheList(int index, HeadachesRecord item) =>
      headacheList.insert(index, item);
  void updateHeadacheListAtIndex(
          int index, Function(HeadachesRecord) updateFn) =>
      headacheList[index] = updateFn(headacheList[index]);

  bool updatedAI = false;

  List<String> symptomsList = [];
  void addToSymptomsList(String item) => symptomsList.add(item);
  void removeFromSymptomsList(String item) => symptomsList.remove(item);
  void removeAtIndexFromSymptomsList(int index) => symptomsList.removeAt(index);
  void insertAtIndexInSymptomsList(int index, String item) =>
      symptomsList.insert(index, item);
  void updateSymptomsListAtIndex(int index, Function(String) updateFn) =>
      symptomsList[index] = updateFn(symptomsList[index]);

  List<String> triggersList = [];
  void addToTriggersList(String item) => triggersList.add(item);
  void removeFromTriggersList(String item) => triggersList.remove(item);
  void removeAtIndexFromTriggersList(int index) => triggersList.removeAt(index);
  void insertAtIndexInTriggersList(int index, String item) =>
      triggersList.insert(index, item);
  void updateTriggersListAtIndex(int index, Function(String) updateFn) =>
      triggersList[index] = updateFn(triggersList[index]);

  bool changed = false;

  bool loading = false;

  bool generated = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [AI Agent - Send Message to HeadacheAnalysis] action in Container widget.
  String? aiInsights;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
