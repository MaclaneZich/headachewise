import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'status_badge_model.dart';
export 'status_badge_model.dart';

class StatusBadgeWidget extends StatefulWidget {
  const StatusBadgeWidget({
    super.key,
    this.bg,
    this.label,
    this.color,
    required this.headacheDoc,
  });

  final Color? bg;
  final String? label;
  final Color? color;
  final HeadachesRecord? headacheDoc;

  @override
  State<StatusBadgeWidget> createState() => _StatusBadgeWidgetState();
}

class _StatusBadgeWidgetState extends State<StatusBadgeWidget> {
  late StatusBadgeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StatusBadgeModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: valueOrDefault<Color>(
          widget!.bg,
          Color(0x00000000),
        ),
        borderRadius: BorderRadius.circular(9999.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 4.0),
        child: Text(
          valueOrDefault<String>(
            functions.severityLabel(widget!.headacheDoc!.greatestSeverity),
            'Moderate Severity',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: valueOrDefault<Color>(
                  widget!.color,
                  Color(0x00000000),
                ),
                letterSpacing: 0.0,
                fontWeight: FontWeight.bold,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
              ),
        ),
      ),
    );
  }
}
