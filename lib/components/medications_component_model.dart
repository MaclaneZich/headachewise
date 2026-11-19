import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'medications_component_widget.dart' show MedicationsComponentWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MedicationsComponentModel
    extends FlutterFlowModel<MedicationsComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for CustomMed widget.
  FocusNode? customMedFocusNode;
  TextEditingController? customMedTextController;
  String? Function(BuildContext, String?)? customMedTextControllerValidator;
  // State field(s) for MedSelector widget.
  String? medSelectorValue;
  FormFieldController<String>? medSelectorValueController;
  // State field(s) for Dosage widget.
  FocusNode? dosageFocusNode;
  TextEditingController? dosageTextController;
  String? Function(BuildContext, String?)? dosageTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    customMedFocusNode?.dispose();
    customMedTextController?.dispose();

    dosageFocusNode?.dispose();
    dosageTextController?.dispose();
  }
}
