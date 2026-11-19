import '/auth/firebase_auth/auth_util.dart';
import '/backend/ai_agents/ai_agent.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'analysis_dashboard_model.dart';
export 'analysis_dashboard_model.dart';

class AnalysisDashboardWidget extends StatefulWidget {
  const AnalysisDashboardWidget({super.key});

  static String routeName = 'AnalysisDashboard';
  static String routePath = '/analysisDashboard';

  @override
  State<AnalysisDashboardWidget> createState() =>
      _AnalysisDashboardWidgetState();
}

class _AnalysisDashboardWidgetState extends State<AnalysisDashboardWidget>
    with TickerProviderStateMixin {
  late AnalysisDashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnalysisDashboardModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().selectedDate = getCurrentTimestamp;
      safeSetState(() {});
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    animationsMap.addAll({
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 50.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 80.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.8, 0.8),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<HeadachesRecord>>(
      stream: queryHeadachesRecord(
        parent: currentUserReference,
        queryBuilder: (headachesRecord) => headachesRecord
            .where(
              'startTime',
              isGreaterThan:
                  functions.getStartOfDay(FFAppState().selectedDate!),
            )
            .where(
              'ongoing',
              isEqualTo: false,
            ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<HeadachesRecord> analysisDashboardHeadachesRecordList =
            snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: StreamBuilder<List<HeadachesRecord>>(
              stream: queryHeadachesRecord(
                parent: currentUserReference,
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                List<HeadachesRecord> containerHeadachesRecordList =
                    snapshot.data!;

                return Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 70.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 30.0,
                                height: 30.0,
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
                                  Icons.analytics_outlined,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                              ),
                              Text(
                                'Analytics Dashboard',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      font: GoogleFonts.mukta(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      fontSize: () {
                                        if (MediaQuery.sizeOf(context).width >
                                            768.0) {
                                          return 30.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width >
                                            415.0) {
                                          return 25.0;
                                        } else {
                                          return 16.0;
                                        }
                                      }(),
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(SizedBox(width: 10.0)),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment(0.0, 0),
                                    child: TabBar(
                                      labelColor: Colors.white,
                                      unselectedLabelColor: Color(0xFFA2A2A2),
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
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
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                      unselectedLabelStyle: FlutterFlowTheme.of(
                                              context)
                                          .titleMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
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
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                      indicatorColor: Color(0xFF6366F1),
                                      tabs: [
                                        Tab(
                                          text: 'Calendar View',
                                        ),
                                        Tab(
                                          text: 'AI Insights',
                                        ),
                                      ],
                                      controller: _model.tabBarController,
                                      onTap: (i) async {
                                        [
                                          () async {},
                                          () async {
                                            if (containerHeadachesRecordList
                                                    .length >=
                                                15) {
                                              _model.isLoading = true;
                                              safeSetState(() {});
                                              await callAiAgent(
                                                context: context,
                                                prompt: valueOrDefault<String>(
                                                  functions.generateTrendsPrompt(
                                                      containerHeadachesRecordList
                                                          .toList(),
                                                      valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.sex,
                                                          false),
                                                      currentUserDocument!
                                                          .birthday!),
                                                  'Analysis Error',
                                                ),
                                                threadId:
                                                    'AnalysisTabConversation',
                                                agentCloudFunctionName:
                                                    'headacheAnalysis',
                                                provider: 'GOOGLE',
                                                agentJson:
                                                    '{\"status\":\"LIVE\",\"identifier\":{\"name\":\"headacheAnalysis\",\"key\":\"w43ek\"},\"name\":\"HeadacheAnalysis\",\"description\":\"Analyzes a user’s headache records to identify trends and patterns related to time, severity, symptoms, and triggers. Returns 3 concise, data-driven bullet-point insights formatted with one blank line between each.\",\"aiModel\":{\"provider\":\"GOOGLE\",\"model\":\"gemini-2.5-flash\",\"parameters\":{\"temperature\":{\"inputValue\":0.3},\"maxTokens\":{\"inputValue\":1500},\"topP\":{\"inputValue\":0.95}},\"messages\":[{\"role\":\"SYSTEM\",\"text\":\"You are HeadacheWise, an intelligent assistant that analyzes headache logs and identifies meaningful trends. Always output exactly three concise bullet-point observations, each separated by a single blank line. Do not include extra headings, markdown formatting, introductions, or conclusions. Focus on patterns across time, severity, symptoms, triggers, and related details. Keep language clear, clinical, and insightful. Go beyond pointing out the obvious. Output plain text only — no asterisks, no markdown, no bold formatting of any kind. I need you to include a source for every fact at the end of in parentheses. \"}]},\"requestOptions\":{\"requestTypes\":[\"PLAINTEXT\"]},\"responseOptions\":{\"responseType\":\"PLAINTEXT\"}}',
                                                responseType: 'PLAINTEXT',
                                              ).then((generatedText) {
                                                safeSetState(() => _model
                                                        .geminiOutputAnalysisTab =
                                                    generatedText);
                                              });

                                              _model.isLoading = false;
                                              safeSetState(() {});
                                            } else {
                                              _model.isLoading = false;
                                              safeSetState(() {});
                                            }

                                            safeSetState(() {});
                                          }
                                        ][i]();
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      controller: _model.tabBarController,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 30.0, 0.0, 0.0),
                                                child: StreamBuilder<
                                                    List<HeadachesRecord>>(
                                                  stream: queryHeadachesRecord(
                                                    parent:
                                                        currentUserReference,
                                                    queryBuilder:
                                                        (headachesRecord) =>
                                                            headachesRecord
                                                                .where(
                                                      'ongoing',
                                                      isEqualTo: false,
                                                    ),
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<HeadachesRecord>
                                                        containerHeadachesRecordList =
                                                        snapshot.data!;

                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF4F5A82),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.0),
                                                      ),
                                                      child: Container(
                                                        width: () {
                                                          if (MediaQuery.sizeOf(
                                                                      context)
                                                                  .width >
                                                              768.0) {
                                                            return 325.0;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width >
                                                              415.0) {
                                                            return 300.0;
                                                          } else {
                                                            return 300.0;
                                                          }
                                                        }(),
                                                        height: 400.0,
                                                        child: custom_widgets
                                                            .CustomHeadacheCalendar(
                                                          width: () {
                                                            if (MediaQuery.sizeOf(
                                                                        context)
                                                                    .width >
                                                                768.0) {
                                                              return 325.0;
                                                            } else if (MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width >
                                                                415.0) {
                                                              return 300.0;
                                                            } else {
                                                              return 300.0;
                                                            }
                                                          }(),
                                                          height: 400.0,
                                                          selectedDate:
                                                              FFAppState()
                                                                  .selectedDate!,
                                                          markedDates: functions
                                                              .getHeadacheDates(
                                                                  containerHeadachesRecordList
                                                                      .toList()),
                                                          headacheList:
                                                              containerHeadachesRecordList,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 20.0, 0.0, 50.0),
                                                child: Builder(
                                                  builder: (context) {
                                                    final headaches = functions
                                                        .filterHeadachesByDay(
                                                            analysisDashboardHeadachesRecordList
                                                                .toList(),
                                                            FFAppState()
                                                                .selectedDate!)
                                                        .toList();

                                                    return ListView.separated(
                                                      padding: EdgeInsets.zero,
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          headaches.length,
                                                      separatorBuilder:
                                                          (_, __) => SizedBox(
                                                              height: 15.0),
                                                      itemBuilder: (context,
                                                          headachesIndex) {
                                                        final headachesItem =
                                                            headaches[
                                                                headachesIndex];
                                                        return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      40.0,
                                                                      0.0,
                                                                      40.0,
                                                                      0.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                SummariesWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'headacheDoc':
                                                                      serializeParam(
                                                                    headachesItem,
                                                                    ParamType
                                                                        .Document,
                                                                  ),
                                                                }.withoutNulls,
                                                                extra: <String,
                                                                    dynamic>{
                                                                  'headacheDoc':
                                                                      headachesItem,
                                                                },
                                                              );
                                                            },
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 280.0,
                                                              child: custom_widgets
                                                                  .HeadacheCalendarCard(
                                                                width: double
                                                                    .infinity,
                                                                height: 280.0,
                                                                headachesRecord:
                                                                    headachesItem,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Visibility(
                                                  visible: functions
                                                          .filterHeadachesForDay(
                                                              analysisDashboardHeadachesRecordList
                                                                  .toList(),
                                                              FFAppState()
                                                                  .selectedDate!)
                                                          .length ==
                                                      0,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    30.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Selected Date: ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        () {
                                                                      if (MediaQuery.sizeOf(context)
                                                                              .width >
                                                                          768.0) {
                                                                        return 25.0;
                                                                      } else if (MediaQuery.sizeOf(context)
                                                                              .width >
                                                                          415.0) {
                                                                        return 20.0;
                                                                      } else {
                                                                        return 16.0;
                                                                      }
                                                                    }(),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Text(
                                                              dateTimeFormat(
                                                                  "yMMMd",
                                                                  FFAppState()
                                                                      .selectedDate),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        () {
                                                                      if (MediaQuery.sizeOf(context)
                                                                              .width >
                                                                          768.0) {
                                                                        return 25.0;
                                                                      } else if (MediaQuery.sizeOf(context)
                                                                              .width >
                                                                          415.0) {
                                                                        return 20.0;
                                                                      } else {
                                                                        return 16.0;
                                                                      }
                                                                    }(),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Color(
                                                                    0xFF6366F1),
                                                                size: 60.0,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          20.0,
                                                                          0.0,
                                                                          20.0),
                                                              child: Text(
                                                                'No headaches recorded on this day',
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
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          () {
                                                                        if (MediaQuery.sizeOf(context).width >
                                                                            768.0) {
                                                                          return 20.0;
                                                                        } else if (MediaQuery.sizeOf(context).width >
                                                                            415.0) {
                                                                          return 16.0;
                                                                        } else {
                                                                          return 12.0;
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
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                            'columnOnPageLoadAnimation']!),
                                        Container(
                                          width: 100.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: custom_widgets
                                                .HeadacheAnalysisWidget(
                                              width: double.infinity,
                                              height: double.infinity,
                                              aiAnalysisResult: _model
                                                  .geminiOutputAnalysisTab,
                                              isLoading: _model.isLoading,
                                              headacheList:
                                                  containerHeadachesRecordList,
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
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
