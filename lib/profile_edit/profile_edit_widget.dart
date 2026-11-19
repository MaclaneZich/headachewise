import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/sex_pill_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_edit_model.dart';
export 'profile_edit_model.dart';

class ProfileEditWidget extends StatefulWidget {
  const ProfileEditWidget({super.key});

  static String routeName = 'ProfileEdit';
  static String routePath = '/profileEdit';

  @override
  State<ProfileEditWidget> createState() => _ProfileEditWidgetState();
}

class _ProfileEditWidgetState extends State<ProfileEditWidget> {
  late ProfileEditModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileEditModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.sex = valueOrDefault<bool>(currentUserDocument?.sex, false);
      safeSetState(() {});
    });

    _model.nameButtonTextController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.firstName, ''));
    _model.nameButtonFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 70.0, 0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: FlutterFlowTheme.of(context).divider,
                  width: 1.0,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Edit Profile',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 24.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                          ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      ProfileNewWidget.routeName,
                                      extra: <String, dynamic>{
                                        '__transition_info__': TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.leftToRight,
                                        ),
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Save',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Container(
                              width: 0.0,
                              height: 0.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          child: Stack(
                            children: [
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).divider,
                                    width: 2.0,
                                  ),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Icon(
                                  Icons.person_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 48.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'FIRST NAME',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 13.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                      lineHeight: 1.2,
                                    ),
                              ),
                              AuthUserStreamWidget(
                                builder: (context) => Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: _model.nameButtonTextController,
                                    focusNode: _model.nameButtonFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.nameButtonTextController',
                                      Duration(milliseconds: 2000),
                                      () async {
                                        await currentUserReference!
                                            .update(createUsersRecordData(
                                          firstName: _model
                                              .nameButtonTextController.text,
                                          email: '',
                                        ));
                                      },
                                    ),
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: () {
                                              if (MediaQuery.sizeOf(context)
                                                      .width >
                                                  768.0) {
                                                return 24.0;
                                              } else if (MediaQuery.sizeOf(
                                                          context)
                                                      .width >
                                                  415.0) {
                                                return 18.0;
                                              } else {
                                                return 12.0;
                                              }
                                            }(),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      hintText: 'First Name',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .hint,
                                            fontSize: () {
                                              if (MediaQuery.sizeOf(context)
                                                      .width >
                                                  768.0) {
                                                return 24.0;
                                              } else if (MediaQuery.sizeOf(
                                                          context)
                                                      .width >
                                                  415.0) {
                                                return 18.0;
                                              } else {
                                                return 12.0;
                                              }
                                            }(),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF0A0A0A),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF1E2440),
                                      contentPadding: EdgeInsets.all(24.0),
                                      suffixIcon: _model
                                              .nameButtonTextController!
                                              .text
                                              .isNotEmpty
                                          ? InkWell(
                                              onTap: () async {
                                                _model.nameButtonTextController
                                                    ?.clear();
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  firstName: _model
                                                      .nameButtonTextController
                                                      .text,
                                                  email: '',
                                                ));
                                                safeSetState(() {});
                                              },
                                              child: Icon(
                                                Icons.clear,
                                                color: Color(0xFF64748B),
                                                size: 24.0,
                                              ),
                                            )
                                          : null,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: () {
                                            if (MediaQuery.sizeOf(context)
                                                    .width >
                                                768.0) {
                                              return 24.0;
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
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    keyboardType: TextInputType.name,
                                    validator: _model
                                        .nameButtonTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'DATE OF BIRTH',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 13.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                      lineHeight: 1.2,
                                    ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  final _datePickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: getCurrentTimestamp,
                                    firstDate: DateTime(1900),
                                    lastDate: getCurrentTimestamp,
                                    builder: (context, child) {
                                      return wrapInMaterialDatePickerTheme(
                                        context,
                                        child!,
                                        headerBackgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        headerForegroundColor:
                                            FlutterFlowTheme.of(context).info,
                                        headerTextStyle: FlutterFlowTheme.of(
                                                context)
                                            .headlineLarge
                                            .override(
                                              font: GoogleFonts.mukta(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .fontStyle,
                                              ),
                                              fontSize: 32.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                        pickerBackgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        pickerForegroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        selectedDateTimeBackgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        selectedDateTimeForegroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        actionButtonForegroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        iconSize: 24.0,
                                      );
                                    },
                                  );

                                  if (_datePickedDate != null) {
                                    safeSetState(() {
                                      _model.datePicked = DateTime(
                                        _datePickedDate.year,
                                        _datePickedDate.month,
                                        _datePickedDate.day,
                                      );
                                    });
                                  } else if (_model.datePicked != null) {
                                    safeSetState(() {
                                      _model.datePicked = getCurrentTimestamp;
                                    });
                                  }

                                  await currentUserReference!
                                      .update(createUsersRecordData(
                                    birthday: _model.datePicked,
                                  ));
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(18.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AuthUserStreamWidget(
                                          builder: (context) => Text(
                                            dateTimeFormat("yMMMd",
                                                currentUserDocument!.birthday!),
                                            style: FlutterFlowTheme.of(context)
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: () {
                                                    if (MediaQuery.sizeOf(
                                                                context)
                                                            .width >
                                                        768.0) {
                                                      return 24.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width >
                                                        415.0) {
                                                      return 18.0;
                                                    } else {
                                                      return 14.0;
                                                    }
                                                  }(),
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
                                        Icon(
                                          Icons.calendar_today_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 20.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'BIOLOGICAL SEX',
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      font: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 13.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontStyle,
                                      lineHeight: 1.2,
                                    ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.sex = true;
                                        safeSetState(() {});

                                        await currentUserReference!
                                            .update(createUsersRecordData(
                                          sex: true,
                                        ));
                                      },
                                      child: wrapWithModel(
                                        model: _model.sexPillModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SexPillWidget(
                                          label: 'Male',
                                          sex: _model.sex,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.sex = false;
                                        safeSetState(() {});

                                        await currentUserReference!
                                            .update(createUsersRecordData(
                                          sex: false,
                                        ));
                                      },
                                      child: wrapWithModel(
                                        model: _model.sexPillModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SexPillWidget(
                                          label: 'Female',
                                          sex: _model.sex,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ].divide(SizedBox(height: 30.0)),
                      ),
                      Container(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock_outline_rounded,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                size: 14.0,
                              ),
                              Text(
                                'Your clinical data is encrypted',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ),
                      Container(
                        height: 24.0,
                      ),
                    ].divide(SizedBox(height: 24.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
