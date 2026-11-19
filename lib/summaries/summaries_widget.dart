import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'summaries_model.dart';
export 'summaries_model.dart';

class SummariesWidget extends StatefulWidget {
  const SummariesWidget({
    super.key,
    required this.headacheDoc,
  });

  final HeadachesRecord? headacheDoc;

  static String routeName = 'Summaries';
  static String routePath = '/summaries';

  @override
  State<SummariesWidget> createState() => _SummariesWidgetState();
}

class _SummariesWidgetState extends State<SummariesWidget> {
  late SummariesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SummariesModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 30.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.safePop();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 35.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x33000000),
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: Icon(
                            Icons.medical_information,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Headache Details',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: () {
                                      if (MediaQuery.sizeOf(context).width >
                                          768.0) {
                                        return 40.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width >
                                          415.0) {
                                        return 25.0;
                                      } else {
                                        return 20.0;
                                      }
                                    }(),
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  valueOrDefault<String>(
                                    dateTimeFormat("EEEE, MMMM d, y",
                                        widget!.headacheDoc?.startTime),
                                    '1/1/2000',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        font: GoogleFonts.mukta(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineSmall
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
                                            return 17.0;
                                          } else {
                                            return 13.0;
                                          }
                                        }(),
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 20.0, 20.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0x71313259),
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: Color(0xFF6F61EF),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF88C4F3),
                                                  Color(0xFF787AC2)
                                                ],
                                                stops: [0.0, 1.0],
                                                begin: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                end: AlignmentDirectional(
                                                    1.0, 0),
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: Icon(
                                                Icons.timeline,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                size: 24.0,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Pain Timeline',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  font: GoogleFonts.mukta(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: () {
                                                    if (MediaQuery.sizeOf(
                                                                context)
                                                            .width >
                                                        768.0) {
                                                      return 28.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width >
                                                        415.0) {
                                                      return 22.0;
                                                    } else {
                                                      return 16.0;
                                                    }
                                                  }(),
                                                  letterSpacing: 2.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmall
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF202341),
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        7.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 40.0,
                                                      height: 40.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xA0AACEE4),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        Icons.timer,
                                                        color:
                                                            Color(0xFFB2DCE2),
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  7.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          functions.formatDuration(
                                                              widget!
                                                                  .headacheDoc!
                                                                  .startTime!,
                                                              widget!
                                                                  .headacheDoc!
                                                                  .endTime!),
                                                          '1 Hour 1 Minute',
                                                        ),
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .headlineSmall
                                                            .override(
                                                              font: GoogleFonts
                                                                  .mukta(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontStyle,
                                                              ),
                                                              color: Color(
                                                                  0xFFB2DCE2),
                                                              fontSize: 17.0,
                                                              letterSpacing:
                                                                  2.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Duration',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .headlineSmall
                                                          .override(
                                                            font: GoogleFonts
                                                                .mukta(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .fontStyle,
                                                            ),
                                                            color: Color(
                                                                0xFFB4B4B4),
                                                            fontSize: 14.0,
                                                            letterSpacing: 2.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 5.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: valueOrDefault<
                                                            Color>(
                                                          widget!.headacheDoc!
                                                                      .greatestSeverity <
                                                                  3.0
                                                              ? Color(
                                                                  0x5813F7A1)
                                                              : (widget!.headacheDoc!
                                                                          .greatestSeverity <
                                                                      6.0
                                                                  ? Color(
                                                                      0x91FFD700)
                                                                  : (widget!.headacheDoc!
                                                                              .greatestSeverity <
                                                                          9.0
                                                                      ? Color(
                                                                          0x8DFF6D03)
                                                                      : (widget!.headacheDoc!.greatestSeverity <
                                                                              11.0
                                                                          ? Color(
                                                                              0x86FF0000)
                                                                          : Color(
                                                                              0x7DF30606)))),
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: valueOrDefault<
                                                              Color>(
                                                            widget!.headacheDoc!
                                                                        .greatestSeverity <
                                                                    3.0
                                                                ? Color(
                                                                    0xFF13F7A1)
                                                                : (widget!.headacheDoc!
                                                                            .greatestSeverity <
                                                                        6.0
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .accent2
                                                                    : (widget!.headacheDoc!
                                                                                .greatestSeverity <
                                                                            9.0
                                                                        ? Color(
                                                                            0xFFFF6D03)
                                                                        : (widget!.headacheDoc!.greatestSeverity <
                                                                                11.0
                                                                            ? Color(0xFFFF0000)
                                                                            : Color(0xFFF30606)))),
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              Icons.trending_up,
                                                              color:
                                                                  valueOrDefault<
                                                                      Color>(
                                                                widget!.headacheDoc!
                                                                            .greatestSeverity <
                                                                        3.0
                                                                    ? Color(
                                                                        0xFF13F7A1)
                                                                    : (widget!.headacheDoc!
                                                                                .greatestSeverity <
                                                                            6.0
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .accent2
                                                                        : (widget!.headacheDoc!.greatestSeverity <
                                                                                9.0
                                                                            ? Color(
                                                                                0xFFFF6D03)
                                                                            : (widget!.headacheDoc!.greatestSeverity < 11.0
                                                                                ? Color(0xFFFF0000)
                                                                                : Color(0xFFF30606)))),
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                              size: 16.0,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  7.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              widget!
                                                                  .headacheDoc
                                                                  ?.greatestSeverity
                                                                  ?.toString(),
                                                              '10',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmall
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .mukta(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    widget!.headacheDoc!.greatestSeverity <
                                                                            3.0
                                                                        ? Color(
                                                                            0xFF13F7A1)
                                                                        : (widget!.headacheDoc!.greatestSeverity <
                                                                                6.0
                                                                            ? FlutterFlowTheme.of(context)
                                                                                .accent2
                                                                            : (widget!.headacheDoc!.greatestSeverity < 9.0
                                                                                ? Color(0xFFFF6D03)
                                                                                : (widget!.headacheDoc!.greatestSeverity < 11.0 ? Color(0xFFFF0000) : Color(0xFFF30606)))),
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                  fontSize:
                                                                      17.0,
                                                                  letterSpacing:
                                                                      2.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                          Text(
                                                            '/10',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmall
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .mukta(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    widget!.headacheDoc!.greatestSeverity <
                                                                            3.0
                                                                        ? Color(
                                                                            0xFF13F7A1)
                                                                        : (widget!.headacheDoc!.greatestSeverity <
                                                                                6.0
                                                                            ? FlutterFlowTheme.of(context)
                                                                                .accent2
                                                                            : (widget!.headacheDoc!.greatestSeverity < 9.0
                                                                                ? Color(0xFFFF6D03)
                                                                                : (widget!.headacheDoc!.greatestSeverity < 11.0 ? Color(0xFFFF0000) : Color(0xFFF30606)))),
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                  fontSize:
                                                                      17.0,
                                                                  letterSpacing:
                                                                      2.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      'Intensity',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .headlineSmall
                                                          .override(
                                                            font: GoogleFonts
                                                                .mukta(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .fontStyle,
                                                            ),
                                                            color: Color(
                                                                0xFFB4B4B4),
                                                            fontSize: 14.0,
                                                            letterSpacing: 2.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 20.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 7.0, 0.0, 0.0),
                                            child: Text(
                                              'Episode Timeline',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        font: GoogleFonts.mukta(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmall
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        fontSize: 17.0,
                                                        letterSpacing: 2.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmall
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF202341),
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          Icons.play_arrow,
                                                          color:
                                                              Color(0xFFE5E7E7),
                                                          size: 30.0,
                                                        ),
                                                        Text(
                                                          'Start',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineSmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .mukta(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFFBBE4ED),
                                                                fontSize: () {
                                                                  if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width >
                                                                      768.0) {
                                                                    return 22.0;
                                                                  } else if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width >
                                                                      415.0) {
                                                                    return 17.0;
                                                                  } else {
                                                                    return 13.0;
                                                                  }
                                                                }(),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            dateTimeFormat(
                                                                "M/d h:mm a",
                                                                widget!
                                                                    .headacheDoc
                                                                    ?.startTime),
                                                            'Now',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineSmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .mukta(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFFBBE4ED),
                                                                fontSize: () {
                                                                  if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width >
                                                                      768.0) {
                                                                    return 22.0;
                                                                  } else if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width >
                                                                      415.0) {
                                                                    return 17.0;
                                                                  } else {
                                                                    return 13.0;
                                                                  }
                                                                }(),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    Icon(
                                                      Icons.linear_scale,
                                                      color: Colors.white,
                                                      size: () {
                                                        if (MediaQuery.sizeOf(
                                                                    context)
                                                                .width >
                                                            768.0) {
                                                          return 40.0;
                                                        } else if (MediaQuery
                                                                    .sizeOf(
                                                                        context)
                                                                .width >
                                                            415.0) {
                                                          return 30.0;
                                                        } else {
                                                          return 20.0;
                                                        }
                                                      }(),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          Icons.stop,
                                                          color:
                                                              Color(0xFFE5E7E7),
                                                          size: 30.0,
                                                        ),
                                                        Text(
                                                          'End',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineSmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .mukta(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFFBBE4ED),
                                                                fontSize: () {
                                                                  if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width >
                                                                      768.0) {
                                                                    return 22.0;
                                                                  } else if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width >
                                                                      415.0) {
                                                                    return 17.0;
                                                                  } else {
                                                                    return 13.0;
                                                                  }
                                                                }(),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            dateTimeFormat(
                                                                "M/d h:mm a",
                                                                widget!
                                                                    .headacheDoc
                                                                    ?.endTime),
                                                            'Later',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineSmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .mukta(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFFBBE4ED),
                                                                fontSize: () {
                                                                  if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width >
                                                                      768.0) {
                                                                    return 22.0;
                                                                  } else if (MediaQuery.sizeOf(
                                                                              context)
                                                                          .width >
                                                                      415.0) {
                                                                    return 17.0;
                                                                  } else {
                                                                    return 13.0;
                                                                  }
                                                                }(),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 15.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Symptoms, Triggers , Medications',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        font: GoogleFonts.mukta(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineSmall
                                                  .fontStyle,
                                        ),
                                        color: Colors.white,
                                        fontSize: () {
                                          if (MediaQuery.sizeOf(context).width >
                                              768.0) {
                                            return 28.0;
                                          } else if (MediaQuery.sizeOf(context)
                                                  .width >
                                              415.0) {
                                            return 22.0;
                                          } else {
                                            return 16.0;
                                          }
                                        }(),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 10.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 0.0, 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x33000000),
                                            offset: Offset(
                                              0.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 0.0),
                                                    child: Icon(
                                                      Icons.shield,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      size: 30.0,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  5.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        'Symptoms',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: () {
                                                                    if (MediaQuery.sizeOf(context)
                                                                            .width >
                                                                        768.0) {
                                                                      return 22.0;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width >
                                                                        415.0) {
                                                                      return 18.0;
                                                                    } else {
                                                                      return 14.0;
                                                                    }
                                                                  }(),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Opacity(
                                              opacity: 0.4,
                                              child: SizedBox(
                                                width: 150.0,
                                                child: Divider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                ),
                                              ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final symptoms = widget!
                                                        .headacheDoc?.symptoms
                                                        ?.toList() ??
                                                    [];

                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: List.generate(
                                                      symptoms.length,
                                                      (symptomsIndex) {
                                                    final symptomsItem =
                                                        symptoms[symptomsIndex];
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        if (FFAppState()
                                                            .selectedTriggers
                                                            .contains(
                                                                'Alcohol')) {
                                                          FFAppState()
                                                              .removeFromSelectedTriggers(
                                                                  'Alcohol');
                                                          safeSetState(() {});
                                                        } else {
                                                          FFAppState()
                                                              .addToSelectedTriggers(
                                                                  'Alcohol');
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        5.0,
                                                                        10.0,
                                                                        5.0),
                                                                child: Text(
                                                                  symptomsItem,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width >
                                                                              768.0) {
                                                                            return 18.0;
                                                                          } else if (MediaQuery.sizeOf(context).width >
                                                                              415.0) {
                                                                            return 14.0;
                                                                          } else {
                                                                            return 11.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 5.0)),
                                                        ),
                                                      ),
                                                    );
                                                  }).divide(
                                                      SizedBox(height: 5.0)),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Color(0x33000000),
                                          offset: Offset(
                                            0.0,
                                            2.0,
                                          ),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 0.0),
                                                  child: Icon(
                                                    Icons.error_outline_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    size: 30.0,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 5.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Triggers',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: () {
                                                              if (MediaQuery.sizeOf(
                                                                          context)
                                                                      .width >
                                                                  768.0) {
                                                                return 22.0;
                                                              } else if (MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width >
                                                                  415.0) {
                                                                return 18.0;
                                                              } else {
                                                                return 14.0;
                                                              }
                                                            }(),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Opacity(
                                            opacity: 0.4,
                                            child: SizedBox(
                                              width: 150.0,
                                              child: Divider(
                                                thickness: 2.0,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                              ),
                                            ),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final triggers = widget!
                                                      .headacheDoc?.triggers
                                                      ?.toList() ??
                                                  [];

                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                    triggers.length,
                                                    (triggersIndex) {
                                                  final triggersItem =
                                                      triggers[triggersIndex];
                                                  return InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      if (FFAppState()
                                                          .selectedTriggers
                                                          .contains(
                                                              'Alcohol')) {
                                                        FFAppState()
                                                            .removeFromSelectedTriggers(
                                                                'Alcohol');
                                                        safeSetState(() {});
                                                      } else {
                                                        FFAppState()
                                                            .addToSelectedTriggers(
                                                                'Alcohol');
                                                        safeSetState(() {});
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          5.0,
                                                                          10.0,
                                                                          5.0),
                                                              child: Text(
                                                                triggersItem,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          () {
                                                                        if (MediaQuery.sizeOf(context).width >
                                                                            768.0) {
                                                                          return 18.0;
                                                                        } else if (MediaQuery.sizeOf(context).width >
                                                                            415.0) {
                                                                          return 14.0;
                                                                        } else {
                                                                          return 11.0;
                                                                        }
                                                                      }(),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 5.0)),
                                                      ),
                                                    ),
                                                  );
                                                }).divide(
                                                    SizedBox(height: 5.0)),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 20.0, 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x33000000),
                                            offset: Offset(
                                              0.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 0.0),
                                                    child: Icon(
                                                      Icons
                                                          .medical_services_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      size: 30.0,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  5.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        'Medications',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: () {
                                                                    if (MediaQuery.sizeOf(context)
                                                                            .width >
                                                                        768.0) {
                                                                      return 22.0;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width >
                                                                        415.0) {
                                                                      return 18.0;
                                                                    } else {
                                                                      return 14.0;
                                                                    }
                                                                  }(),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Opacity(
                                              opacity: 0.4,
                                              child: SizedBox(
                                                width: 150.0,
                                                child: Divider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                ),
                                              ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final medication = widget!
                                                        .headacheDoc
                                                        ?.medications
                                                        ?.toList() ??
                                                    [];

                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: List.generate(
                                                      medication.length,
                                                      (medicationIndex) {
                                                    final medicationItem =
                                                        medication[
                                                            medicationIndex];
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        if (FFAppState()
                                                            .selectedTriggers
                                                            .contains(
                                                                'Alcohol')) {
                                                          FFAppState()
                                                              .removeFromSelectedTriggers(
                                                                  'Alcohol');
                                                          safeSetState(() {});
                                                        } else {
                                                          FFAppState()
                                                              .addToSelectedTriggers(
                                                                  'Alcohol');
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        5.0,
                                                                        10.0,
                                                                        5.0),
                                                                child: Text(
                                                                  functions
                                                                      .formatMedicationEntry(
                                                                          medicationItem),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width >
                                                                              768.0) {
                                                                            return 18.0;
                                                                          } else if (MediaQuery.sizeOf(context).width >
                                                                              415.0) {
                                                                            return 14.0;
                                                                          } else {
                                                                            return 11.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 5.0)),
                                                        ),
                                                      ),
                                                    );
                                                  }).divide(
                                                      SizedBox(height: 5.0)),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                30.0, 15.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Additional Details',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        font: GoogleFonts.mukta(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineSmall
                                                  .fontStyle,
                                        ),
                                        color: Colors.white,
                                        fontSize: () {
                                          if (MediaQuery.sizeOf(context).width >
                                              768.0) {
                                            return 28.0;
                                          } else if (MediaQuery.sizeOf(context)
                                                  .width >
                                              415.0) {
                                            return 22.0;
                                          } else {
                                            return 16.0;
                                          }
                                        }(),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 20.0, 20.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0x71313259),
                                borderRadius: BorderRadius.circular(6.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Color(0xFF6F61EF),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 0.0, 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      size: 24.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Location:',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              font: GoogleFonts.mukta(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .fontStyle,
                                              ),
                                              color: Colors.white,
                                              fontSize: () {
                                                if (MediaQuery.sizeOf(context)
                                                        .width >
                                                    768.0) {
                                                  return 22.0;
                                                } else if (MediaQuery.sizeOf(
                                                            context)
                                                        .width >
                                                    415.0) {
                                                  return 18.0;
                                                } else {
                                                  return 14.0;
                                                }
                                              }(),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            widget!.headacheDoc?.painLocation,
                                            'Head',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                font: GoogleFonts.mukta(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmall
                                                          .fontStyle,
                                                ),
                                                color: Colors.white,
                                                fontSize: () {
                                                  if (MediaQuery.sizeOf(context)
                                                          .width >
                                                      768.0) {
                                                    return 22.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width >
                                                      415.0) {
                                                    return 18.0;
                                                  } else {
                                                    return 14.0;
                                                  }
                                                }(),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (widget!.headacheDoc?.notes != null &&
                              widget!.headacheDoc?.notes != '')
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 20.0, 20.0, 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x71313259),
                                  borderRadius: BorderRadius.circular(6.0),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Color(0xFF6F61EF),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 10.0, 0.0, 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.note_add_sharp,
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            size: 24.0,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Notes:',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        font: GoogleFonts.mukta(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmall
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        fontSize: () {
                                                          if (MediaQuery.sizeOf(
                                                                      context)
                                                                  .width >
                                                              768.0) {
                                                            return 22.0;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width >
                                                              415.0) {
                                                            return 18.0;
                                                          } else {
                                                            return 14.0;
                                                          }
                                                        }(),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmall
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 15.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF202341),
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(18.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              widget!.headacheDoc?.notes,
                                              'N/A',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  font: GoogleFonts.mukta(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: () {
                                                    if (MediaQuery.sizeOf(
                                                                context)
                                                            .width >
                                                        768.0) {
                                                      return 18.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width >
                                                        415.0) {
                                                      return 14.0;
                                                    } else {
                                                      return 11.0;
                                                    }
                                                  }(),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmall
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 25.0, 0.0, 250.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    FFAppState().edit = true;
                                    FFAppState().greatestSeverity =
                                        widget!.headacheDoc!.greatestSeverity;
                                    FFAppState().notes =
                                        widget!.headacheDoc!.notes;
                                    safeSetState(() {});

                                    context.pushNamed(
                                      LogHeadachePageWidget.routeName,
                                      queryParameters: {
                                        'headacheDoc': serializeParam(
                                          widget!.headacheDoc,
                                          ParamType.Document,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'headacheDoc': widget!.headacheDoc,
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 150.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF6366F1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 25.0,
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Edit',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title:
                                                      Text('Delete Headache'),
                                                  content: Text(
                                                      'Are you sure you want to delete this headache entry? This action cannot be undone.'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              true),
                                                      child: Text('Confirm'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ) ??
                                            false;
                                    if (confirmDialogResponse) {
                                      await widget!.headacheDoc!.reference
                                          .delete();
                                      context.safePop();
                                    }
                                  },
                                  child: Container(
                                    width: 150.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF7F1D1D),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Color(0xFFEF4444),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Color(0xFFFCA5A5),
                                          size: 25.0,
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Delete',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: Color(0xFFFCA5A5),
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
