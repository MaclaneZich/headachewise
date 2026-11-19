import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'symptoms_component_model.dart';
export 'symptoms_component_model.dart';

class SymptomsComponentWidget extends StatefulWidget {
  const SymptomsComponentWidget({super.key});

  @override
  State<SymptomsComponentWidget> createState() =>
      _SymptomsComponentWidgetState();
}

class _SymptomsComponentWidgetState extends State<SymptomsComponentWidget> {
  late SymptomsComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SymptomsComponentModel());
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
      width: 393.0,
      height: 852.0,
      decoration: BoxDecoration(
        color: Color(0xFF202341),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 35.0,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Symptoms',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          fontSize: () {
                            if (MediaQuery.sizeOf(context).width > 768.0) {
                              return 50.0;
                            } else if (MediaQuery.sizeOf(context).width >
                                415.0) {
                              return 35.0;
                            } else {
                              return 28.0;
                            }
                          }(),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x71313259),
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(
                      color: Color(0xFF6F61EF),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 20.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFC0C0F4),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.sick,
                                color: Color(0xFF8C46F3),
                                size: 24.0,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Track Your Symptoms',
                                      style: FlutterFlowTheme.of(context)
                                          .displayMedium
                                          .override(
                                            font: GoogleFonts.mukta(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .displayMedium
                                                      .fontStyle,
                                            ),
                                            color: Colors.white,
                                            fontSize: () {
                                              if (MediaQuery.sizeOf(context)
                                                      .width >
                                                  768.0) {
                                                return 25.0;
                                              } else if (MediaQuery.sizeOf(
                                                          context)
                                                      .width >
                                                  415.0) {
                                                return 20.0;
                                              } else {
                                                return 15.0;
                                              }
                                            }(),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .displayMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: Text(
                                        'Select all symptoms you have experienced',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Colors.white,
                                              fontSize: () {
                                                if (MediaQuery.sizeOf(context)
                                                        .width >
                                                    768.0) {
                                                  return 18.0;
                                                } else if (MediaQuery.sizeOf(
                                                            context)
                                                        .width >
                                                    415.0) {
                                                  return 14.0;
                                                } else {
                                                  return 12.0;
                                                }
                                              }(),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Text(
                              'Select All Symptoms That Apply:',
                              style: FlutterFlowTheme.of(context)
                                  .displayMedium
                                  .override(
                                    font: GoogleFonts.mukta(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .displayMedium
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: () {
                                      if (MediaQuery.sizeOf(context).width >
                                          768.0) {
                                        return 25.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width >
                                          415.0) {
                                        return 20.0;
                                      } else {
                                        return 15.0;
                                      }
                                    }(),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .displayMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            35.0, 10.0, 35.0, 60.0),
                        child: Builder(
                          builder: (context) {
                            final symptoms = FFAppConstants.Symptoms.toList();

                            return Wrap(
                              spacing: 25.0,
                              runSpacing: () {
                                if (MediaQuery.sizeOf(context).width > 768.0) {
                                  return 20.0;
                                } else if (MediaQuery.sizeOf(context).width >
                                    415.0) {
                                  return 10.0;
                                } else {
                                  return 10.0;
                                }
                              }(),
                              alignment: WrapAlignment.spaceEvenly,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.horizontal,
                              runAlignment: WrapAlignment.start,
                              verticalDirection: VerticalDirection.down,
                              clipBehavior: Clip.none,
                              children: List.generate(symptoms.length,
                                  (symptomsIndex) {
                                final symptomsItem = symptoms[symptomsIndex];
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (FFAppState()
                                        .selectedSymptoms
                                        .contains(symptomsItem)) {
                                      FFAppState().removeFromSelectedSymptoms(
                                          symptomsItem);
                                      safeSetState(() {});
                                    } else {
                                      FFAppState()
                                          .addToSelectedSymptoms(symptomsItem);
                                      safeSetState(() {});
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.linear,
                                    decoration: BoxDecoration(
                                      color: FFAppState()
                                              .selectedSymptoms
                                              .contains(symptomsItem)
                                          ? Color(0xFF6F61EF)
                                          : Color(0x00000000),
                                      borderRadius: BorderRadius.circular(16.0),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Color(0xFF6F61EF),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0, 10.0, 15.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: FFAppState()
                                                    .selectedSymptoms
                                                    .contains(symptomsItem)
                                                ? () {
                                                    if (MediaQuery.sizeOf(
                                                                context)
                                                            .width >
                                                        768.0) {
                                                      return 25;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width >
                                                        415.0) {
                                                      return 22;
                                                    } else {
                                                      return 18;
                                                    }
                                                  }()
                                                    .toDouble()
                                                : 0.0,
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              symptomsItem,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        fontSize:
                                                            valueOrDefault<
                                                                double>(
                                                          (FFAppState()
                                                                      .selectedSymptoms
                                                                      .contains(
                                                                          symptomsItem)
                                                                  ? () {
                                                                      if (MediaQuery.sizeOf(context)
                                                                              .width >
                                                                          768.0) {
                                                                        return 24;
                                                                      } else if (MediaQuery.sizeOf(context)
                                                                              .width >
                                                                          415.0) {
                                                                        return 17;
                                                                      } else {
                                                                        return 14;
                                                                      }
                                                                    }()
                                                                  : () {
                                                                      if (MediaQuery.sizeOf(context)
                                                                              .width >
                                                                          768.0) {
                                                                        return 22;
                                                                      } else if (MediaQuery.sizeOf(context)
                                                                              .width >
                                                                          415.0) {
                                                                        return 16;
                                                                      } else {
                                                                        return 13;
                                                                      }
                                                                    }())
                                                              .toDouble(),
                                                          17.0,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 2.0)),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 35.0, 0.0, 35.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 350.0,
                    height: 65.0,
                    decoration: BoxDecoration(
                      color: Color(0xD05809EA),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            'Save Symptoms',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
