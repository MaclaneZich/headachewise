import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/sex_pill_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'profile_edit_widget.dart' show ProfileEditWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileEditModel extends FlutterFlowModel<ProfileEditWidget> {
  ///  Local state fields for this page.

  bool sex = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for NameButton widget.
  FocusNode? nameButtonFocusNode;
  TextEditingController? nameButtonTextController;
  String? Function(BuildContext, String?)? nameButtonTextControllerValidator;
  DateTime? datePicked;
  // Model for sex_pill component.
  late SexPillModel sexPillModel1;
  // Model for sex_pill component.
  late SexPillModel sexPillModel2;

  @override
  void initState(BuildContext context) {
    sexPillModel1 = createModel(context, () => SexPillModel());
    sexPillModel2 = createModel(context, () => SexPillModel());
  }

  @override
  void dispose() {
    nameButtonFocusNode?.dispose();
    nameButtonTextController?.dispose();

    sexPillModel1.dispose();
    sexPillModel2.dispose();
  }
}
