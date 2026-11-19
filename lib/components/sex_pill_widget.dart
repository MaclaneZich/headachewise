import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sex_pill_model.dart';
export 'sex_pill_model.dart';

class SexPillWidget extends StatefulWidget {
  const SexPillWidget({
    super.key,
    this.label,
    this.sex,
  });

  final String? label;
  final bool? sex;

  @override
  State<SexPillWidget> createState() => _SexPillWidgetState();
}

class _SexPillWidgetState extends State<SexPillWidget> {
  late SexPillModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SexPillModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: BoxDecoration(
        color: !FFAppState().sexFirstClicked
            ? Color(0xFF1E2440)
            : (widget!.label == 'Male'
                ? (widget!.sex!
                    ? FlutterFlowTheme.of(context).accent1
                    : FlutterFlowTheme.of(context).secondaryBackground)
                : (!widget!.sex!
                    ? FlutterFlowTheme.of(context).accent1
                    : FlutterFlowTheme.of(context).secondaryBackground)),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).divider,
          width: 1.0,
        ),
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          valueOrDefault<String>(
            widget!.label,
            'Male',
          ),
          style: FlutterFlowTheme.of(context).labelLarge.override(
                font: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                ),
                color: !FFAppState().sexFirstClicked
                    ? FlutterFlowTheme.of(context).hint
                    : (widget!.label == 'Male'
                        ? (widget!.sex!
                            ? FlutterFlowTheme.of(context).primaryText
                            : FlutterFlowTheme.of(context).hint)
                        : (!widget!.sex!
                            ? FlutterFlowTheme.of(context).primaryText
                            : FlutterFlowTheme.of(context).hint)),
                fontSize: 14.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                lineHeight: 1.2,
              ),
        ),
      ),
    );
  }
}
